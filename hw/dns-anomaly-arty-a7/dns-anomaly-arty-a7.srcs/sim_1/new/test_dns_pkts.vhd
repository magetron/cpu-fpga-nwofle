LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

LIBRARY work;
USE work.common.ALL;

LIBRARY work;
USE work.test_pkt_infra.ALL;

PACKAGE test_dns_pkts IS
  PROCEDURE dns_empty_test_suite
    (E_RX_CLK_period : IN TIME;
    SIGNAL E_RX_DV : OUT STD_LOGIC;
    SIGNAL E_RXD : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));

  PROCEDURE dns_admin_black_test_suite
    (E_RX_CLK_period : IN TIME;
    SIGNAL E_RX_DV : OUT STD_LOGIC;
    SIGNAL E_RXD : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));

  PROCEDURE dns_admin_white_test_suite
    (E_RX_CLK_period : IN TIME;
    SIGNAL E_RX_DV : OUT STD_LOGIC;
    SIGNAL E_RXD : OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
END test_dns_pkts;

PACKAGE BODY test_dns_pkts IS

  PROCEDURE receive_dns_admin_black_payload
    (E_RX_CLK_period : IN TIME;
    SIGNAL E_RXD : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)) is
  BEGIN
    FOR i IN 0 TO 99 LOOP
      E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;
    END LOOP;

    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"1"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"1"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"2"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"8"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"4"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"2"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"a"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"5"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"a"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"4"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"f"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"2"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"8"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"8"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"2"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"5"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"a"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"a"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"2"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"8"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"2"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;

    -- HASH
    E_RXD <= x"1"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"3"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"9"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"f"; WAIT FOR E_RX_CLK_period;

  END receive_dns_admin_black_payload;

  PROCEDURE receive_dns_admin_white_payload
    (E_RX_CLK_period : IN TIME;
    SIGNAL E_RXD : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)) is
  BEGIN
    FOR i IN 0 TO 99 LOOP
      E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;
    END LOOP;

    E_RXD <= x"4"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"1"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"1"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"2"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"8"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"4"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"2"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"a"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"5"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"a"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"4"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"f"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"2"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"8"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"8"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"2"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"5"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"a"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"a"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"2"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"8"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"2"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;

    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;

    -- HASH
    E_RXD <= x"1"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"3"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"9"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"a"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"f"; WAIT FOR E_RX_CLK_period;
  END receive_dns_admin_white_payload;

  PROCEDURE receive_dns_admin_black_packet
    (E_RX_CLK_period : IN TIME;
    SIGNAL E_RX_DV : OUT STD_LOGIC;
    SIGNAL E_RXD : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)) IS
  BEGIN
    E_RX_DV <= '1';
    receive_preamble(E_RX_CLK_period, E_RXD);
    receive_ethernet_header(E_RX_CLK_period, x"b043df1bb706", x"000a35ffffff", E_RXD);
    receive_ip_header(E_RX_CLK_period, x"0ac4e67a", x"0a6b1ba0", x"0078", E_RXD);
    receive_udp_header(E_RX_CLK_period, x"2ba3", x"2ebc", x"0064", E_RXD);
    receive_dns_admin_black_payload(E_RX_CLK_period, E_RXD);
    receive_null_fcs(E_RX_CLK_period, E_RXD);
    E_RX_DV <= '0';
  END receive_dns_admin_black_packet;

  PROCEDURE receive_dns_admin_white_packet
    (E_RX_CLK_period : IN TIME;
    SIGNAL E_RX_DV : OUT STD_LOGIC;
    SIGNAL E_RXD : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)) IS
  BEGIN
    E_RX_DV <= '1';
    receive_preamble(E_RX_CLK_period, E_RXD);
    receive_ethernet_header(E_RX_CLK_period, x"b043df1bb706", x"000a35ffffff", E_RXD);
    receive_ip_header(E_RX_CLK_period, x"0aee28fc", x"0a6b1ba0", x"0078", E_RXD);
    receive_udp_header(E_RX_CLK_period, x"2ba3", x"2ebc", x"0064", E_RXD);
    receive_dns_admin_white_payload(E_RX_CLK_period, E_RXD);
    receive_null_fcs(E_RX_CLK_period, E_RXD);
    E_RX_DV <= '0';
  END receive_dns_admin_white_packet;

  PROCEDURE receive_dns_blacklist_one_packet
    (E_RX_CLK_period : IN TIME;
    SIGNAL E_RX_DV : OUT STD_LOGIC;
    SIGNAL E_RXD : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)) IS
  BEGIN
    E_RX_DV <= '1';
    receive_preamble(E_RX_CLK_period, E_RXD);
    receive_ethernet_header(E_RX_CLK_period, x"d60c2706b70a", x"e4ce33abdab0", E_RXD);
    receive_ip_header(E_RX_CLK_period, x"0ac728aa", x"0a6b1ba0", x"0028", E_RXD);
    receive_udp_header(E_RX_CLK_period, x"2ba3", x"2ebc", x"0014", E_RXD);

    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"7"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"1"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"4"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"7"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"2"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"7"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"9"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"3"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"b"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"7"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"7"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"5"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"7"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"2"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"5"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"7"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"b"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;

    receive_null_fcs(E_RX_CLK_period, E_RXD);
    E_RX_DV <= '0';
  END receive_dns_blacklist_one_packet;

  PROCEDURE receive_dns_blacklist_two_packet
    (E_RX_CLK_period : IN TIME;
    SIGNAL E_RX_DV : OUT STD_LOGIC;
    SIGNAL E_RXD : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)) IS
  BEGIN
    E_RX_DV <= '1';
    receive_preamble(E_RX_CLK_period, E_RXD);
    receive_ethernet_header(E_RX_CLK_period, x"cd9783f7189a", x"f827353ef560", E_RXD);
    receive_ip_header(E_RX_CLK_period, x"0aee28fc", x"0a6b1ba0", x"002c", E_RXD);
    receive_udp_header(E_RX_CLK_period, x"2ba3", x"2ebc", x"0018", E_RXD);

    E_RXD <= x"a"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"7"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"9"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"4"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"7"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"f"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"7"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"9"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"2"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"5"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"7"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"1"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"f"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"1"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;

    receive_null_fcs(E_RX_CLK_period, E_RXD);
    E_RX_DV <= '0';
  END receive_dns_blacklist_two_packet;

  PROCEDURE receive_dns_whitelist_one_packet
    (E_RX_CLK_period : IN TIME;
    SIGNAL E_RX_DV : OUT STD_LOGIC;
    SIGNAL E_RXD : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)) IS
  BEGIN
    E_RX_DV <= '1';
    receive_preamble(E_RX_CLK_period, E_RXD);
    receive_ethernet_header(E_RX_CLK_period, x"b9b9331d2000", x"514950422ebb", E_RXD);
    receive_ip_header(E_RX_CLK_period, x"0a3c8747", x"0a6b1ba0", x"0028", E_RXD);
    receive_udp_header(E_RX_CLK_period, x"2ba3", x"2ebc", x"0014", E_RXD);

    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"7"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"1"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"4"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"7"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"2"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"7"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"9"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"3"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"b"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"7"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"7"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"5"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"7"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"2"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"5"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"7"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"b"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;

    receive_null_fcs(E_RX_CLK_period, E_RXD);
    E_RX_DV <= '0';
  END receive_dns_whitelist_one_packet;

  PROCEDURE receive_dns_whitelist_two_packet
    (E_RX_CLK_period : IN TIME;
    SIGNAL E_RX_DV : OUT STD_LOGIC;
    SIGNAL E_RXD : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)) IS
  BEGIN
    E_RX_DV <= '1';
    receive_preamble(E_RX_CLK_period, E_RXD);
    receive_ethernet_header(E_RX_CLK_period, x"6ae1c34da084", x"e76e2d19f507", E_RXD);
    receive_ip_header(E_RX_CLK_period, x"0ae865b0", x"0a6b1ba0", x"002c", E_RXD);
    receive_udp_header(E_RX_CLK_period, x"2ba3", x"2ebc", x"0018", E_RXD);

    E_RXD <= x"a"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"7"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"9"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"4"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"7"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"f"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"7"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"9"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"e"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"2"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"d"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"5"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"0"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"7"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"1"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"c"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"f"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"1"; WAIT FOR E_RX_CLK_period;
    E_RXD <= x"6"; WAIT FOR E_RX_CLK_period;

    receive_null_fcs(E_RX_CLK_period, E_RXD);
    E_RX_DV <= '0';
  END receive_dns_whitelist_two_packet;

  PROCEDURE receive_dns_empty_admin_packet
    (E_RX_CLK_period : IN TIME;
    SIGNAL E_RX_DV : OUT STD_LOGIC;
    SIGNAL E_RXD : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)) IS
  BEGIN
    E_RX_DV <= '1';
    receive_preamble(E_RX_CLK_period, E_RXD);
    receive_ethernet_header(E_RX_CLK_period, x"b043df1bb706", x"000a35ffffff", E_RXD);
    receive_ip_header(E_RX_CLK_period, x"0ac4e67a", x"0a6b1ba0", x"0078", E_RXD);
    receive_udp_header(E_RX_CLK_period, x"2ba3", x"2ebc", x"0064", E_RXD);
    receive_empty_admin_payload(E_RX_CLK_period, E_RXD);
    receive_null_fcs(E_RX_CLK_period, E_RXD);
    E_RX_DV <= '0';
  END receive_dns_empty_admin_packet;

  PROCEDURE dns_empty_test_suite
    (E_RX_CLK_period : IN TIME;
    SIGNAL E_RX_DV : OUT STD_LOGIC;
    SIGNAL E_RXD : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)) IS
  BEGIN
    receive_dns_empty_admin_packet(E_RX_CLK_period, E_RX_DV, E_RXD);
    WAIT FOR E_RX_CLK_period * 200;

    FOR i IN 0 TO 9 LOOP
      receive_any_random_packet(E_RX_CLK_period, E_RX_DV, E_RXD);
      WAIT FOR E_RX_CLK_period * 200;
    END LOOP;

  END dns_empty_test_suite;

  PROCEDURE dns_admin_black_test_suite
    (E_RX_CLK_period : IN TIME;
    SIGNAL E_RX_DV : OUT STD_LOGIC;
    SIGNAL E_RXD : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)) IS
  BEGIN
    receive_dns_admin_black_packet(E_RX_CLK_period, E_RX_DV, E_RXD);
    WAIT FOR E_RX_CLK_period * 200;

    FOR i IN 0 TO 9 LOOP
      receive_any_random_packet(E_RX_CLK_period, E_RX_DV, E_RXD);
      WAIT FOR E_RX_CLK_period * 200;
    END LOOP;

    FOR i IN 0 TO 4 LOOP
      -- Black list 1
      receive_dns_blacklist_one_packet(E_RX_CLK_period, E_RX_DV, E_RXD);
      WAIT FOR E_RX_CLK_period * 200;
    END LOOP;

    FOR i IN 0 TO 4 LOOP
      -- Black list 2
      receive_dns_blacklist_two_packet(E_RX_CLK_period, E_RX_DV, E_RXD);
      WAIT FOR E_RX_CLK_period * 200;
    END LOOP;

  END dns_admin_black_test_suite;

  PROCEDURE dns_admin_white_test_suite
    (E_RX_CLK_period : IN TIME;
    SIGNAL E_RX_DV : OUT STD_LOGIC;
    SIGNAL E_RXD : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)) IS
  BEGIN
    receive_dns_admin_white_packet(E_RX_CLK_period, E_RX_DV, E_RXD);
    WAIT FOR E_RX_CLK_period * 200;

    FOR i IN 0 TO 9 LOOP
      receive_any_random_packet(E_RX_CLK_period, E_RX_DV, E_RXD);
      WAIT FOR E_RX_CLK_period * 200;
    END LOOP;

    FOR i IN 0 TO 4 LOOP
      -- White list 1
      receive_dns_whitelist_one_packet(E_RX_CLK_period, E_RX_DV, E_RXD);
      WAIT FOR E_RX_CLK_period * 200;
    END LOOP;

    FOR i IN 0 TO 4 LOOP
      -- White list 2
      receive_dns_whitelist_two_packet(E_RX_CLK_period, E_RX_DV, E_RXD);
      WAIT FOR E_RX_CLK_period * 200;
    END LOOP;

  END dns_admin_white_test_suite;

END test_dns_pkts;
