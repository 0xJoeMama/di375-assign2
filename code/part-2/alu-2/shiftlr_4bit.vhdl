-- file: shiftlr_4bit.vhdl
library ieee;
use ieee.std_logic_1164.all;

entity ShiftLR_4bit is
    port ( 
      a: in std_logic_vector(3 downto 0);
      Control: in std_logic;
      Result: out std_logic_vector(3 downto 0)
    );
end entity ShiftLR_4bit;

architecture Dataflow of ShiftLR_4bit is
begin
  with Control select
    Result <= a(2 downto 0) & '0' when '1',
              '0' & a(3 downto 1) when '0',
              (others => '0') when others;
end architecture Dataflow;
