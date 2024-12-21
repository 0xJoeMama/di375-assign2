U1: process (A, B, C, D) is 
begin
  If ((B = '1' and C = D) then
    Y <= '1';
  elsif ((A = '0' and A /= C) then
    Y <= '1';
  else
    Y <= '0';
  end if;
end process;

U2:process (A, B, C, D) is 
begin
  If ((D = '1' and B = C) then
    X <= '1';
  else
    X <= '0';
  end if;
end process;
