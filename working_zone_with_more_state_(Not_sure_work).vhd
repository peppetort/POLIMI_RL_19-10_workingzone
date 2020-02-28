library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;
use IEEE.NUMERIC_STD.ALL;


entity project_reti_logiche is
  Port (
    i_clk       : in std_logic;
    i_start     : in std_logic;
    i_rst       : in std_logic;
    i_data      : in std_logic_vector(7 downto 0);
    o_address   : out std_logic_vector(15 downto 0);
    o_done      : out std_logic;
    o_en        : out std_logic;
    o_we        : out std_logic;
    o_data      : out std_logic_vector(7 downto 0)

 );
end project_reti_logiche;

architecture Behavioral of project_reti_logiche is
signal wz0 : std_logic_vector(7 downto 0);
signal wz1 : std_logic_vector(7 downto 0);
signal wz2 : std_logic_vector(7 downto 0);
signal wz3 : std_logic_vector(7 downto 0);
signal wz4 : std_logic_vector(7 downto 0);
signal wz5 : std_logic_vector(7 downto 0);
signal wz6 : std_logic_vector(7 downto 0);
signal wz7 : std_logic_vector(7 downto 0);
signal addr : std_logic_vector(7 downto 0);
signal mem_counter : integer := 0;
signal status : integer := -1;
signal en_status : integer := 0;
signal we_status : integer := 0;

--costanti
signal base0: std_logic_vector(7 downto 0) := "00000000";
signal base1: std_logic_vector(7 downto 0) := "00000001";
signal base2: std_logic_vector(7 downto 0) := "00000010";
signal base3: std_logic_vector(7 downto 0) := "00000011";

signal binary0:std_logic_vector(2 downto 0) := "000";
signal binary1:std_logic_vector(2 downto 0) := "001";
signal binary2:std_logic_vector(2 downto 0) := "010";
signal binary3:std_logic_vector(2 downto 0) := "011";
signal binary4:std_logic_vector(2 downto 0) := "100";
signal binary5:std_logic_vector(2 downto 0) := "101";
signal binary6:std_logic_vector(2 downto 0) := "110";
signal binary7:std_logic_vector(2 downto 0) := "111";

signal onehot0:std_logic_vector(3 downto 0) := "0001";
signal onehot1:std_logic_vector(3 downto 0) := "0010";
signal onehot2:std_logic_vector(3 downto 0) := "0100";
signal onehot3:std_logic_vector(3 downto 0) := "1000";


begin
    process(i_clk, i_start, i_rst)

    begin
        if(rising_edge(i_clk)) then
        
            if(i_rst = '1') then
                o_en <= '1';
                o_we <= '0';
                o_done <= '0';
                mem_counter <= 0;
                status <= 0;
                en_status <= 1;
                we_status <= 0;
            elsif(status=0) then
            case mem_counter is
                        when 0 =>
                            o_address <= std_logic_vector(to_unsigned(0,o_address'length));
                            mem_counter <= 1;
                        when 1 =>
                            wz0 <= i_data;
                            o_address <= std_logic_vector(to_unsigned(1,o_address'length));
                            mem_counter <= 2;
                        when 2 =>
                            wz1 <= i_data;
                            o_address <= std_logic_vector(to_unsigned(2,o_address'length));
                            mem_counter <= 3;
                        when 3 =>
                            wz2 <= i_data;
                            o_address <= std_logic_vector(to_unsigned(3,o_address'length));
                            mem_counter <= 4;
                        when 4 =>
                            wz3 <= i_data;
                            o_address <= std_logic_vector(to_unsigned(4,o_address'length));
                            mem_counter  <= 5;
                        when 5 =>
                            wz4 <= i_data;
                            o_address <= std_logic_vector(to_unsigned(5,o_address'length));
                            mem_counter <= 6;
                        when 6 =>
                            wz5 <= i_data;
                            o_address <= std_logic_vector(to_unsigned(6,o_address'length));
                            mem_counter <= 7;
                        when 7  => 
                            wz6 <= i_data;
                            o_address <= std_logic_vector(to_unsigned(7,o_address'length));
                            mem_counter <= 8;
                        when 8  => 
                            wz7  <= i_data;
                            status <= 1;
                        when others => 
                            mem_counter <= 0;
                        end case;
            elsif(i_start = '1') and (status = 1) then
                    case mem_counter is
                        when 8  => 
                            o_address <= std_logic_vector(to_unsigned(8,o_address'length));
                            mem_counter <= 9;
                        when 9  =>
                            addr <= i_data;
                            o_address <= std_logic_vector(to_unsigned(9,o_address'length));
                            mem_counter <= 10;
                        when 10  =>
                            addr <= i_data;
                            o_we <= '1';
                            status <= 2;
                        when others => 
                            mem_counter <= 0;
                        end case;
            elsif(i_start = '1') and (status = 2) then
                
                    if((addr - wz0) = base0) then
                        o_data <= "1" & binary0 & onehot0;
                    elsif((addr - (wz0 + base1)) = "00000000") then
                        o_data <= "1" & binary0 & onehot1;
                    elsif((addr - (wz0 + base2)) = "00000000") then
                        o_data <= "1" & binary0 & onehot2;
                    elsif ((addr - (wz0 + base3))= "00000000") then
                        o_data <= "1" & binary0 & onehot3;
                    elsif((addr - wz1) = base0) then
                        o_data <= "1" & binary1 & onehot0;
                    elsif((addr - (wz1 + base1)) = "00000000") then
                        o_data <= "1" & binary1 & onehot1;
                    elsif((addr - (wz1 + base2)) = "00000000") then
                        o_data <= "1" & binary1 & onehot2;
                    elsif ((addr - (wz1 + base3)) = "00000000") then
                        o_data <= "1" & binary1 & onehot3;
                    elsif((addr - wz2) = base0) then
                        o_data <= "1" & binary2 & onehot0;
                    elsif((addr - (wz2 + base1)) = "00000000") then
                        o_data <= "1" & binary2 & onehot1;
                    elsif((addr - (wz2 + base2)) = "00000000") then
                        o_data <= "1" & binary2 & onehot2;
                    elsif ((addr - (wz2 + base3)) = "00000000") then
                        o_data <= "1" & binary2 & onehot3;
                    elsif((addr - wz3) = base0) then
                        o_data <= "1" & binary3 & onehot0;
                    elsif((addr - (wz3 + base1)) = "00000000") then
                        o_data <= "1" & binary3 & onehot1;
                    elsif((addr - (wz3 + base2)) = "00000000") then
                        o_data <= "1" & binary3 & onehot2;
                    elsif ((addr - (wz3 + base3)) = "00000000") then
                        o_data <= "1" & binary3 & onehot3;
                    elsif((addr - wz4) = base0) then
                        o_data <= "1" & binary4 & onehot0;
                    elsif((addr - (wz4 + base1)) = "00000000") then
                        o_data <= "1" & binary4 & onehot1;
                    elsif((addr - (wz4 + base2)) = "00000000") then
                        o_data <= "1" & binary4 & onehot2;
                    elsif ((addr - (wz4 + base3)) = "00000000") then
                        o_data <= "1" & binary4 & onehot3;
                    elsif((addr - wz5) = base0) then
                        o_data <= "1" & binary5 & onehot0;
                    elsif((addr - (wz5 + base1)) = "00000000") then
                        o_data <= "1" & binary5 & onehot1;
                    elsif((addr - (wz5 + base2)) = "00000000") then
                        o_data <= "1" & binary5 & onehot2;
                    elsif ((addr - (wz5 + base3)) = "00000000") then
                        o_data <= "1" & binary5 & onehot3;
                    elsif((addr - wz6) = base0) then
                        o_data <= "1" & binary6 & onehot0;
                    elsif((addr - (wz6 + base1)) = "00000000") then
                        o_data <= "1" & binary6 & onehot1;
                    elsif((addr - (wz6 + base2)) = "00000000")  then
                        o_data <= "1" & binary6 & onehot2;
                    elsif ((addr - (wz6 + base3)) = "00000000") then
                        o_data <= "1" & binary6 & onehot3;
                    elsif((addr - wz7) = base0) then
                        o_data <= "1" & binary7 & onehot0;
                    elsif((addr - (wz7 + base1)) = "00000000") then
                        o_data <= "1" & binary7 & onehot1;
                    elsif((addr - (wz7 + base2)) = "00000000") then
                        o_data <= "1" & binary7 & onehot2;
                    elsif ((addr - (wz7 + base3)) = "00000000") then
                        o_data <= "1" & binary7 & onehot3;
                    else
                        o_data <= addr;
                    end if;
                    status <= 3;
            elsif (i_start = '1') and (status = 3) then
                o_we <= '0';
                en_status <= 0;
                we_status <= 0;
                o_done <= '1';
                status <= 4;
            elsif (i_start = '0') and (status = 4) then
                o_done <= '0';
                status <= 1;
                o_address <= std_logic_vector(to_unsigned(8,o_address'length));
                mem_counter <= 9;
            end if;
        end if;
    end process;
end architecture Behavioral;
