library ieee;
use ieee.std_logic_1164.all;

entity RotateLR_4bit is
    port (
      a: in std_logic_vector(3 downto 0);
      Control: in std_logic;
      Result: out std_logic_vector(3 downto 0)
    );
end entity RotateLR_4bit;

architecture Dataflow of RotateLR_4bit is
begin
  with Control select
    Result <= a(2 downto 0) & a(3) when '0',
                a(0) & a(3 downto 1) when '1',
                (others => '0') when others;
end architecture Dataflow;
