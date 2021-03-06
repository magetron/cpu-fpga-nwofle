LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

LIBRARY work;
USE work.PCK_CRC32_D4.ALL;
USE work.common.ALL;

ENTITY mac_snd IS
  PORT (
    E_TX_CLK : IN STD_LOGIC; -- Sender Clock.
    E_TX_EN : OUT STD_LOGIC; -- Sender Enable.
    E_TXD : OUT STD_LOGIC_VECTOR(3 DOWNTO 0); -- Sent Data.
    el_data : IN snd_data_t; -- Actual data.
    el_snd_en : IN STD_LOGIC; -- User Start Send.
    el_snd_ack : OUT STD_LOGIC -- Send Ack to FIFO buffer
  );
END mac_snd;

ARCHITECTURE rtl OF mac_snd IS

  TYPE mem_t IS ARRAY(0 TO 14) OF STD_LOGIC_VECTOR(7 DOWNTO 0);

  -- -- TO BE REMOVED
  -- SIGNAL mem : mem_t := (
  --   -- DST MAC Address
  --   x"00", x"e0", x"4c", x"6b", x"dc", x"98",

  --   -- FPGA MAC Address (Xilinx OUI)                                        --
  --   x"00", x"0a", x"35", x"00", x"00", x"00",

  --   -- EtherType Field: 0x0000                                              --
  --   x"08", x"00",

  --   -- Data Header                                                          --
  --   x"45"
  -- );

  --ATTRIBUTE RAM_STYLE : STRING;
  --ATTRIBUTE RAM_STYLE OF mem : SIGNAL IS "BLOCK";

  TYPE state_t IS (
    Idle, -- Wait for signal en.
    Read, -- Read from FIFO
    Preamble, -- 55 55 55 55 55 55 55 5
    StartOfFrame, -- d
    --EtherUpper, -- 6 Byte MAC address Upper nibble
    --EtherLower, -- 6 Byte MAC address Lower nibble
    EtherMACDST, -- 6 Byte MAC DST address
    EtherMACSRC, -- 6 Byte MAC SRC address
    EtherType, -- 0x0800
    IPVersion, -- 0x4
    IPIHL, -- 0x5
    IPDSCPECN, -- 0x00
    IPLength, -- ipLength
    IPID, -- 0x00
    IPFlagsFragment, -- 0x00
    IPTTL, -- 0x40
    IPProtocol, -- 0x11
    IPChecksum, -- Checksum
    IPAddrSRC, -- IPAddr SRC
    IPAddrDST, -- IPAddr DST
    UDPPortSRC, -- 2 byte UDP SRC
    UDPPortDST, -- 2 byte UDP dst
    UDPLength, -- 2 byte UDP Length
    UDPChecksum, -- Checksum,
    DNSMsg, -- 1472 Max bytes
    FrameCheck, -- CRC32
    InterframeGap -- Gap between two cosecutive frames (24 Bit).
  );

  TYPE snd_t IS RECORD
    s : state_t;
    crc : STD_LOGIC_VECTOR(31 DOWNTO 0); -- CRC32 latch.
    c : NATURAL RANGE 0 TO 1023;
  END RECORD;

  SIGNAL d : snd_data_t
  := snd_data_t'(
  srcMAC => (OTHERS => '0'), dstMAC => (OTHERS => '0'),
  srcIP => (OTHERS => '0'), dstIP => (OTHERS => '0'),
  ipLength => (OTHERS => '0'), ipTTL => (OTHERS => '0'),
  ipChecksum => (OTHERS => '0'),
  srcPort => (OTHERS => '0'), dstPort => (OTHERS => '0'),
  udpLength => (OTHERS => '0'),
  udpChecksum => (OTHERS => '0'),
  dnsPktCnt => 0, dnsPkt => (OTHERS => '0')
  );

  SIGNAL s, sin : snd_t
  := snd_t'(
  s => Idle,
  crc => x"ffffffff",
  c => 0
  );

BEGIN

  -- POSSIBLE solution: try prepare 4 bits clk before sending
  snd_nsl : PROCESS (E_TX_CLK) -- mem
  BEGIN
    IF rising_edge(E_TX_CLK) THEN
      E_TXD <= x"0";
      E_TX_EN <= '0';
      el_snd_ack <= '0';

      CASE s.s IS
        WHEN Idle =>
          IF el_snd_en = '1' THEN
            sin.c <= 0;
            sin.s <= Read;
          END IF;

        WHEN Read =>
          d <= el_data;
          el_snd_ack <= '1';
          sin.s <= Preamble;

          -- Preamble, 15 5s (including nibble for start of frame)
        WHEN Preamble =>
          E_TXD <= x"5";
          E_TX_EN <= '1';
          IF s.c = 14 THEN
            sin.c <= 0;
            sin.s <= StartOfFrame;
          ELSE
            sin.c <= s.c + 1;
          END IF;

          -- start of frame (0xd)
        WHEN StartOfFrame =>
          E_TXD <= x"d";
          E_TX_EN <= '1';

          sin.crc <= x"ffffffff";
          sin.c <= 0;
          sin.s <= EtherMACDST;

          -- Ethernet DST MAC
        WHEN EtherMACDST =>
          E_TXD <= d.dstMAC((s.c + 3) DOWNTO (s.c));
          E_TX_EN <= '1';
          sin.crc <= nextCRC32_D4(d.dstMAC((s.c + 3) DOWNTO (s.c)), s.crc);
          IF s.c = 44 THEN
            sin.c <= 0;
            sin.s <= EtherMACSRC;
          ELSE
            sin.c <= s.c + 4;
          END IF;

          -- Ethernet SRC MAC
        WHEN EtherMACSRC =>
          E_TXD <= d.srcMAC((s.c + 3) DOWNTO (s.c));
          E_TX_EN <= '1';
          sin.crc <= nextCRC32_D4(d.srcMAC((s.c + 3) DOWNTO (s.c)), s.crc);
          IF s.c = 44 THEN
            sin.c <= 0;
            sin.s <= EtherType;
          ELSE
            sin.c <= s.c + 4;
          END IF;

          -- Ethertype 0x0800
        WHEN EtherType =>
          IF s.c = 0 THEN
            E_TXD <= x"8";
            E_TX_EN <= '1';
            sin.crc <= nextCRC32_D4(x"8", s.crc);
            sin.c <= s.c + 1;
          ELSE
            E_TXD <= x"0";
            E_TX_EN <= '1';
            sin.crc <= nextCRC32_D4(x"0", s.crc);
            IF s.c = 3 THEN
              sin.c <= 0;
              sin.s <= IPIHL;
            ELSE
              sin.c <= s.c + 1;
            END IF;
          END IF;

          -- IP IHL 5
        WHEN IPIHL =>
          E_TXD <= x"5";
          E_TX_EN <= '1';
          sin.crc <= nextCRC32_D4(x"5", s.crc);
          sin.c <= 0;
          sin.s <= IPVersion;

          -- IP Version 4
        WHEN IPVersion =>
          E_TXD <= x"4";
          E_TX_EN <= '1';
          sin.crc <= nextCRC32_D4(x"4", s.crc);
          sin.c <= 0;
          sin.s <= IPDSCPECN;

          -- IP DSCP ECN 0x00
        WHEN IPDSCPECN =>
          E_TXD <= x"0";
          E_TX_EN <= '1';
          sin.crc <= nextCRC32_D4(x"0", s.crc);
          IF s.c = 1 THEN
            sin.c <= 0;
            sin.s <= IPLength;
          ELSE
            sin.c <= s.c + 1;
          END IF;

          -- IPLength, WRONG byte order! FIX ME!
        WHEN IPLength =>
          E_TXD <= d.ipLength((s.c + 3) DOWNTO (s.c));
          E_TX_EN <= '1';
          sin.crc <= nextCRC32_D4(d.ipLength((s.c + 3) DOWNTO (s.c)), s.crc);
          IF s.c = 12 THEN
            sin.c <= 0;
            sin.s <= IPID;
          ELSE
            sin.c <= s.c + 4;
          END IF;

          -- IP - ID 0x00
        WHEN IPID =>
          E_TXD <= x"0";
          E_TX_EN <= '1';
          sin.crc <= nextCRC32_D4(x"0", s.crc);
          IF s.c = 3 THEN
            sin.c <= 0;
            sin.s <= IPFlagsFragment;
          ELSE
            sin.c <= s.c + 1;
          END IF;

          -- IP Flags Fragment Offset 0x00
        WHEN IPFlagsFragment =>
          E_TXD <= x"0";
          E_TX_EN <= '1';
          sin.crc <= nextCRC32_D4(x"0", s.crc);
          IF s.c = 3 THEN
            sin.c <= 0;
            sin.s <= IPTTL;
          ELSE
            sin.c <= s.c + 1;
          END IF;

          -- IP TTL
        WHEN IPTTL =>
          E_TXD <= d.ipTTL((s.c + 3) DOWNTO (s.c));
          E_TX_EN <= '1';
          sin.crc <= nextCRC32_D4(d.ipTTL((s.c + 3) DOWNTO (s.c)), s.crc);
          IF s.c = 4 THEN
            sin.c <= 0;
            sin.s <= IPProtocol;
          ELSE
            sin.c <= s.c + 4;
          END IF;

          -- IP Protocol
        WHEN IPProtocol =>
          E_TXD <= x"1";
          E_TX_EN <= '1';
          sin.crc <= nextCRC32_D4(x"1", s.crc);
          IF s.c = 1 THEN
            sin.c <= 0;
            sin.s <= IPChecksum;
          ELSE
            sin.c <= s.c + 1;
          END IF;

          -- IPChecksum
        WHEN IPChecksum =>
          E_TXD <= d.ipChecksum((s.c + 3) DOWNTO (s.c));
          --E_TXD <= x"0";
          E_TX_EN <= '1';
          sin.crc <= nextCRC32_D4(d.ipChecksum((s.c + 3) DOWNTO (s.c)), s.crc);
          --sin.crc <= nextCRC32_D4(x"0", s.crc);
          IF s.c = 12 THEN
            sin.c <= 0;
            sin.s <= IPAddrSRC;
          ELSE
            sin.c <= s.c + 4;
          END IF;

          -- IP Addr SRC
        WHEN IPAddrSRC =>
          E_TXD <= d.srcIP((s.c + 3) DOWNTO (s.c));
          E_TX_EN <= '1';
          sin.crc <= nextCRC32_D4(d.srcIP((s.c + 3) DOWNTO (s.c)), s.crc);
          IF s.c = 28 THEN
            sin.c <= 0;
            sin.s <= IPAddrDST;
          ELSE
            sin.c <= s.c + 4;
          END IF;

          -- IP Addr DST
        WHEN IPAddrDST =>
          E_TXD <= d.dstIP((s.c + 3) DOWNTO (s.c));
          E_TX_EN <= '1';
          sin.crc <= nextCRC32_D4(d.dstIP((s.c + 3) DOWNTO (s.c)), s.crc);
          IF s.c = 28 THEN
            sin.c <= 0;
            sin.s <= UDPPortSRC;
          ELSE
            sin.c <= s.c + 4;
          END IF;

          -- UDP Port SRC
        WHEN UDPPortSRC =>
          E_TXD <= d.srcPort((s.c + 3) DOWNTO (s.c));
          E_TX_EN <= '1';
          sin.crc <= nextCRC32_D4(d.srcPort((s.c + 3) DOWNTO (s.c)), s.crc);
          IF s.c = 12 THEN
            sin.c <= 0;
            sin.s <= UDPPortDST;
          ELSE
            sin.c <= s.c + 4;
          END IF;

          -- UDP Port DST
        WHEN UDPPortDST =>
          E_TXD <= d.dstPort((s.c + 3) DOWNTO (s.c));
          E_TX_EN <= '1';
          sin.crc <= nextCRC32_D4(d.dstPort((s.c + 3) DOWNTO (s.c)), s.crc);
          IF s.c = 12 THEN
            sin.c <= 0;
            sin.s <= UDPLength;
          ELSE
            sin.c <= s.c + 4;
          END IF;

          -- UDP Length
        WHEN UDPLength =>
          E_TXD <= d.udpLength((s.c + 3) DOWNTO (s.c));
          E_TX_EN <= '1';
          sin.crc <= nextCRC32_D4(d.udpLength((s.c + 3) DOWNTO (s.c)), s.crc);
          IF s.c = 12 THEN
            sin.c <= 0;
            sin.s <= UDPChecksum;
          ELSE
            sin.c <= s.c + 4;
          END IF;

          -- UDP checksum
        WHEN UDPChecksum =>
          E_TXD <= d.udpChecksum((s.c + 3) DOWNTO (s.c));
          E_TX_EN <= '1';
          sin.crc <= nextCRC32_D4(d.udpChecksum((s.c + 3) DOWNTO (s.c)), s.crc);
          IF s.c = 12 THEN
            sin.c <= 0;
            sin.s <= DNSMsg;
          ELSE
            sin.c <= s.c + 4;
          END IF;

          -- DNS Message
        WHEN DNSMsg =>
          E_TXD <= d.dnsPkt((s.c + 3) DOWNTO (s.c));
          --E_TXD <= x"0";
          E_TX_EN <= '1';
          sin.crc <= nextCRC32_D4(d.dnsPkt((s.c + 3) DOWNTO (s.c)), s.crc);
          --sin.crc <= nextCRC32_D4(x"0", s.crc);
          IF (s.c >= d.dnsPktCnt and s.c >= 140) THEN
            sin.c <= 0;
            sin.s <= FrameCheck;
          ELSE
            sin.c <= s.c + 4;
          END IF;

          -- Ethernet Frame Check Sequence
        WHEN FrameCheck =>
          E_TXD <= NOT s.crc((s.c + 3) DOWNTO (s.c));
          E_TX_EN <= '1';
          IF s.c = 28 THEN
            sin.c <= 0;
            sin.s <= InterframeGap;
          ELSE
            sin.c <= s.c + 4;
          END IF;

          -- Ethernet Interframe Gap
        WHEN InterframeGap =>
          IF s.c = 23 THEN
            sin.c <= 0;
            sin.s <= Idle;
          ELSE
            sin.c <= s.c + 1;
          END IF;
      END CASE;
    END IF;
  END PROCESS;

  snd_reg : PROCESS (E_TX_CLK)
  BEGIN
    IF falling_edge(E_TX_CLK) THEN
      s <= sin;
    END IF;
  END PROCESS;
END rtl;
