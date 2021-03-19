LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

LIBRARY work;
USE work.test_srcmac_pkts.ALL;

ENTITY test_main IS
END test_main;

ARCHITECTURE rtl OF test_main IS

  -- Component Declaration for the Unit Under Test (UUT)

  COMPONENT main
    PORT (
      clk : IN STD_LOGIC;
      E_RX_CLK : IN STD_LOGIC;
      E_RX_DV : IN STD_LOGIC;
      E_RXD : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      E_RX_ER : IN STD_LOGIC;
      E_TX_CLK : IN STD_LOGIC;
      E_TX_EN : OUT STD_LOGIC;
      E_TXD : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      LED : OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
  END COMPONENT;
  --Inputs
  SIGNAL clk : STD_LOGIC := '0';
  SIGNAL E_RX_CLK : STD_LOGIC := '0';
  SIGNAL E_RX_DV : STD_LOGIC := '0';
  SIGNAL E_RXD : STD_LOGIC_VECTOR(3 DOWNTO 0) := (OTHERS => '0');
  SIGNAL E_RX_ER : STD_LOGIC := '0';
  SIGNAL E_TX_CLK : STD_LOGIC := '0';

  --Outputs
  SIGNAL E_TX_EN : STD_LOGIC;
  SIGNAL E_TXD : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL LED : STD_LOGIC_VECTOR(3 DOWNTO 0);

  -- Clock period definitions
  CONSTANT clk_period : TIME := 10 ns;
  CONSTANT E_RX_CLK_period : TIME := 40 ns;
  CONSTANT E_TX_CLK_period : TIME := 40 ns;

BEGIN

  -- Instantiate the Unit Under Test (UUT)
  uut : main PORT MAP(
    clk => clk,
    E_RX_CLK => E_RX_CLK,
    E_RX_DV => E_RX_DV,
    E_RXD => E_RXD,
    E_RX_ER => E_RX_ER,
    E_TX_CLK => E_TX_CLK,
    E_TX_EN => E_TX_EN,
    E_TXD => E_TXD,
    LED => LED
  );

  -- Clock process definitions
  clk_process : PROCESS
  BEGIN
    clk <= '0';
    WAIT FOR clk_period/2;
    clk <= '1';
    WAIT FOR clk_period/2;
  END PROCESS;

  E_RX_CLK_process : PROCESS
  BEGIN
    E_RX_CLK <= '0';
    WAIT FOR E_RX_CLK_period/2;
    E_RX_CLK <= '1';
    WAIT FOR E_RX_CLK_period/2;
  END PROCESS;

  E_TX_CLK_process : PROCESS
  BEGIN
    E_TX_CLK <= '0';
    WAIT FOR E_TX_CLK_period/2;
    E_TX_CLK <= '1';
    WAIT FOR E_TX_CLK_period/2;
  END PROCESS;

  -- Stimulus process
  stim_proc : PROCESS
  BEGIN
    -- hold reset state for 100 ns.
    WAIT FOR 100 ns;

    WAIT FOR clk_period * 10;

    srcmac_empty_test_suite(E_RX_CLK_period, E_RX_DV, E_RXD);


  END PROCESS;

END;