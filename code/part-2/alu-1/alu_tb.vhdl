library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu_tb is
end entity alu_tb;

architecture behavioural of alu_tb is
  component ALU is
  port ( 
    S1 : in STD_LOGIC;
    S0 : in STD_LOGIC;
    Cin : in STD_LOGIC;
    A : in STD_LOGIC_VECTOR (7 downto 0);
    B : in STD_LOGIC_VECTOR (7 downto 0);
    Y : out STD_LOGIC_VECTOR (7 downto 0)
  );
  end component ALU;

  signal i: signed(7 downto 0);
  signal j: signed(7 downto 0);
  signal s: signed(1 downto 0);
  signal Cin: std_logic;
  signal Y_out: std_logic_vector(7 downto 0);
  signal signed_Y: signed(7 downto 0);
begin
  uut: ALU port map (
  A => std_logic_vector(i),
  B => std_logic_vector(j),
  S1 => s(1),
  S0 => s(0),
  Cin => Cin,
  Y => Y_out
 );

 signed_Y <= signed(Y_out);

  process is
  begin
    i <= to_signed(5, i'length);
    j <= to_signed(3, j'length);
    Cin <= '0';
    s <= "00";
    wait for 20 ns;
    assert signed_Y = 2 report "bad subtraction" severity failure;

    Cin <= '1';

    wait for 20 ns;
    assert signed_Y = 3 report "bad subtraction with carry" severity failure;

    s <= "01";
    wait for 20 ns;
    assert signed_Y =  2 report "bad arithmetic shift right" severity failure;

    s <= "10";
    Cin <= '0';
    wait for 20 ns;
    assert signed_Y = 1 report "bad logical shift right" severity failure;

    Cin <= '1';
    wait for 20 ns;
    assert signed_Y = 10 report "bad logical shift left" severity failure;

    s <= "11";
    wait for 20 ns;
    assert Y_out = "11111110" report "bad nand result" severity failure;

    -- tests with negatives
    s <= "00";
    i <= to_signed(-2, i'length);
    j <= to_signed(-5, i'length);

    wait for 20 ns;
    assert signed_Y = 4 report "bad negative subtraction" severity failure;

    s <= "01";
    wait for 20 ns;
    assert signed_Y = -1 report "bad arithmetic shift right on negative" severity failure;

    s <= "10";
    wait for 20 ns;
    assert Y_out = "11111100" report "bad logical shift left on negative A" severity failure;

    report "tests passed!" severity note;
    wait;
  end process;

end architecture behavioural;
