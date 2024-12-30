library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_TB is 
end entity ALU_TB;

architecture Behavioural of ALU_TB is
  signal Control: std_logic_vector(1 downto 0);
  signal a: std_logic_vector(3 downto 0);
  type res_t is array (0 to 2) of std_logic_vector(3 downto 0);
  signal results: res_t;
begin
  df: entity work.ALU(Dataflow) port map(
    Control => Control,
    a => a,
    Result => results(0)
  );

  beh: entity work.ALU(Behavioural) port map(
    Control => Control,
    a => a,
    Result => results(1)
  );

  struct: entity work.ALU(Structural) port map(
    Control => Control,
    a => a,
    Result => results(2)
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
        -- make sure all architectures have the same results
        assert results(0) = results(1) report "df and beh were different" severity failure;
        assert results(1) = results(2) report "beh and struct were different" severity failure;
        assert results(2) = results(0) report "df and struct were different" severity failure;

        case Control is
          when "00" => assert results(0) = std_logic_vector(rotate_left(unsigned(a), 1)) report "bad rotate left" severity failure;
          when "01" => assert results(0) = std_logic_vector(rotate_right(unsigned(a), 1)) report "bad rotate right" severity failure;
          when "10" => assert results(0) = std_logic_vector(shift_right(unsigned(a), 1)) report "bad shift right" severity failure;
          when "11" => assert results(0) = std_logic_vector(shift_left(unsigned(a), 1)) report "bad shift left" severity failure;
          when others =>
        end case;
      end loop;
    end loop;

    report "Hey! VSAUCE! Michael here..." severity note;
  end process;
end architecture Behavioural;
