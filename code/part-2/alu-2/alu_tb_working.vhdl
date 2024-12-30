library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_TB_WORKING is 
end entity ALU_TB_WORKING ;

architecture Behavioural of ALU_TB_WORKING  is
  signal Control: std_logic_vector(1 downto 0);
  signal a: std_logic_vector(3 downto 0);
  signal Result: std_logic_vector(3 downto 0);
begin
  struct: entity work.ALU(Structural) port map(
    Control => Control,
    a => a,
    Result => Result
  );

  process is
  begin
    -- architecture testing
    for j in 0 to 3 loop
      Control <= std_logic_vector(to_unsigned(j, Control'length));
      report "testing for control value " & integer'image(j) severity note;

      for i in 0 to 15 loop
        a <= std_logic_vector(to_unsigned(i, a'length));
        wait for 20 ns;
        case Control is
          when "00" => assert Result = std_logic_vector(rotate_left(unsigned(a), 1)) report "bad rotate left" severity failure;
          when "01" => assert Result = std_logic_vector(rotate_right(unsigned(a), 1)) report "bad rotate right" severity failure;
          when "10" => assert Result = std_logic_vector(shift_right(unsigned(a), 1)) report "bad shift right" severity failure;
          when "11" => assert Result = std_logic_vector(shift_left(unsigned(a), 1)) report "bad shift left" severity failure;
          when others =>
        end case;
      end loop;
    end loop;

    report "Hey! VSAUCE! Michael here..." severity note;
  end process;
end architecture Behavioural;
