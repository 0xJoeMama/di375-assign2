library ieee;
use ieee.std_logic_1164.all; 

entity ALU is
    port (
      a : in std_logic_vector(3 downto 0);
      Control : in std_logic_vector(1 downto 0);
      Result : out std_logic_vector(3 downto 0)
    );
end entity ALU;

architecture Dataflow of ALU is
  signal rotate_a: std_logic_vector(3 downto 0);
  signal shift_a: std_logic_vector(3 downto 0);
begin
  with Control(0) select
    rotate_a <= a(2 downto 0) & a(3) when '0',
                a(0) & a(3 downto 1) when '1',
                (others => '0') when others;

  with Control(0) select
    shift_a <= a(2 downto 0) & '0' when '1',
              '0' & a(3 downto 1) when '0',
              (others => '0') when others;

  with Control(1) select
    Result <= rotate_a when '0',
              shift_a when '1',
              (others => '0') when others;
end architecture Dataflow;

architecture Structural of ALU is
  component RotateLR_4bit is
      port ( 
        a: in std_logic_vector(3 downto 0);
        Control: in std_logic;
        Result: out std_logic_vector(3 downto 0)
      );
  end component RotateLR_4bit;

  component ShiftLR_4bit is
      port ( 
        a: in std_logic_vector(3 downto 0);
        Control: in std_logic;
        Result: out std_logic_vector(3 downto 0)
      );
  end component ShiftLR_4bit;

  signal rotated_a: std_logic_vector(3 downto 0);
  signal shifted_a: std_logic_vector(3 downto 0);
begin
  rotator: RotateLR_4bit port map(
    a => a,
    Control => Control(0),
    Result => rotated_a
  );

  shifter: ShiftLR_4bit port map(
    a => a,
    Control => Control(0),
    Result => shifted_a
  );

  with Control(1) select
    Result <= rotated_a when '0',
              shifted_a when '1',
              (others => '0') when others;
end architecture Structural;

architecture Behavioural of ALU is
  signal rotated_a: std_logic_vector(3 downto 0);
  signal shifted_a: std_logic_vector(3 downto 0);
begin
  rotate: process (a, Control(0)) is
  begin
    if Control(0) = '0' then
      rotated_a <= a(2 downto 0) & a(3);
    else
      rotated_a <= a(0) & a(3 downto 1);
    end if;
  end process;

  shift: process (a, Control(0)) is
  begin
    if Control(0) = '1' then
      shifted_a <= a(2 downto 0) & '0';
    else
      shifted_a <= '0' & a(3 downto 1);
    end if;
  end process;

  process (Control(1), rotated_a, shifted_a) is
  begin
    if Control(1) = '0' then
      Result <= rotated_a;
    else
      Result  <= shifted_a;
    end if;
  end process;
end architecture Behavioural;

