library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
  port ( 
    S1 : in std_logic;
    S0 : in std_logic;
    Cin : in std_logic;
    A : in std_logic_vector(7 downto 0);
    B : in std_logic_vector(7 downto 0);
    Y : out std_logic_vector(7 downto 0)
  );
end entity ALU;

architecture Dataflow of ALU is
  signal signed_A: signed(7 downto 0);
  signal signed_B: signed(7 downto 0);
  signal C_vec: std_logic_vector(7 downto 0);
  signal logical_shifted_signal: std_logic_vector(7 downto 0);
  signal S : std_logic_vector(1 downto 0);
begin
  signed_A <= signed(A);
  signed_B <= signed(B);
  S(1) <= S1; 
  S(0) <= S0;

  with Cin select
    logical_shifted_signal <= '0' & B(7 downto 1) when '0',
                          A(6 downto 0) & '0' when '1',
                          (others => '0') when others;

  with S select
    Y <= std_logic_vector(signed_A - signed_B + signed(std_logic_vector'("0000000" & Cin))) when "00",
         std_logic_vector(shift_right(signed_A, 1)) when "01",
         logical_shifted_signal when "10",
         A nand B when "11",
         (others => '0') when others;

end architecture Dataflow;
