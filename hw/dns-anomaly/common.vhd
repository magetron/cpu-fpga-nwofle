LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

PACKAGE common IS
  TYPE data_t IS RECORD
    srcMAC : STD_LOGIC_VECTOR(47 DOWNTO 0);
    dstMAC : STD_LOGIC_VECTOR(47 DOWNTO 0);
    srcIP  : STD_LOGIC_VECTOR(31 DOWNTO 0);
    dstIP  : STD_LOGIC_VECTOR(31 DOWNTO 0);
    ipHeaderLength: NATURAL RANGE 0 TO 15;
    ipLength : NATURAL RANGE 0 TO 1500;
    srcPort : STD_LOGIC_VECTOR(15 DOWNTO 0);
    dstPort : STD_LOGIC_VECTOR(15 DOWNTO 0);
    dnsLength : NATURAL RANGE 0 TO 1500; -- MAX 1472
    --dns : STD_LOGIC_VECTOR(1471 DOWNTO 0);
  END RECORD;
END common;

-- PACKAGE common IS

--   -- Array for channel data.
--   TYPE data_t IS ARRAY(7 DOWNTO 0) OF STD_LOGIC_VECTOR(15 DOWNTO 0);

--   -- Channel constants.
--   CONSTANT CHANNEL_A : NATURAL RANGE 0 TO 7 := 0;
--   CONSTANT CHANNEL_B : NATURAL RANGE 0 TO 7 := 1;
--   CONSTANT CHANNEL_C : NATURAL RANGE 0 TO 7 := 2;
--   CONSTANT CHANNEL_D : NATURAL RANGE 0 TO 7 := 3;
--   CONSTANT CHANNEL_E : NATURAL RANGE 0 TO 7 := 4;
--   CONSTANT CHANNEL_F : NATURAL RANGE 0 TO 7 := 5;
--   CONSTANT CHANNEL_G : NATURAL RANGE 0 TO 7 := 6;
--   CONSTANT CHANNEL_H : NATURAL RANGE 0 TO 7 := 7;

--   -- Check, if channel flag is set.
--   FUNCTION isSet(el_chnl : STD_LOGIC_VECTOR; channel : NATURAL) RETURN BOOLEAN;
-- END common;

-- PACKAGE BODY common IS

--   -- Check, if channel flag is set.
--   FUNCTION isSet(el_chnl : STD_LOGIC_VECTOR; channel : NATURAL)
--     RETURN BOOLEAN IS
--   BEGIN
--     RETURN (el_chnl(channel) = '1');
--   END;
-- END common;