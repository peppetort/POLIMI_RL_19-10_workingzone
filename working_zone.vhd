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
signal status : integer := 0;
signal en_status : integer := 0;
signal we_status : integer := 0;

begin
    process(i_clk, i_start, i_rst)

    begin
        if(rising_edge(i_clk)) then
            if(i_rst = '1') then
                o_en <= '0';
                o_we <= '0';
                o_done <= '0';
                mem_counter <= 0;
                status <= 0;
                en_status <= 0;
                we_status <= 0;
            elsif(i_start = '1') and (status = 0) then
                if(en_status = 1) then
                    case mem_counter is
                        when 0 =>
                            o_address <= std_logic_vector(to_unsigned(0,o_address'length));
                            mem_counter <= 1;
                        when 1 =>
                            wz0 <= i_data;
                            o_address <= std_logic_vector(to_unsigned(1,o_address'length));
                            mem_counter <= 2;
                        when 2 =>
                            wz0 <= i_data;
                            mem_counter <= 3;
                        when 3 =>
                            wz1 <= i_data;
                            o_address <= std_logic_vector(to_unsigned(2,o_address'length));
                            mem_counter <= 4;
                        when 4 =>
                            wz1 <= i_data;
                            mem_counter <= 5;
                        when 5 =>
                            wz2 <= i_data;
                            o_address <= std_logic_vector(to_unsigned(3,o_address'length));
                            mem_counter <= 6;
                        when 6 =>
                            wz2 <= i_data;
                            mem_counter <= 7;
                        when 7  => 
                            wz3 <= i_data;
                            o_address <= std_logic_vector(to_unsigned(4,o_address'length));
                            mem_counter  <= 8;
                        when 8 =>
                            wz3 <= i_data;
                            mem_counter <= 9;
                        when 9 =>
                            wz4 <= i_data;
                            o_address <= std_logic_vector(to_unsigned(5,o_address'length));
                            mem_counter <= 10;
                        when 10 =>
                            wz4 <= i_data;
                            mem_counter <= 11;
                        when 11  => 
                            wz5 <= i_data;
                            o_address <= std_logic_vector(to_unsigned(6,o_address'length));
                            mem_counter <= 12;
                        when 12  => 
                            wz5 <= i_data;
                            mem_counter <= 13;
                        when 13  => 
                            wz6 <= i_data;
                            o_address <= std_logic_vector(to_unsigned(7,o_address'length));
                            mem_counter <= 14;
                        when 14  => 
                            wz6  <= i_data;
                            mem_counter  <= 15;
                        when 15  => 
                            wz7  <= i_data;
                            o_address <= std_logic_vector(to_unsigned(8,o_address'length));
                            mem_counter <= 16;
                        when 16  => 
                            wz7 <= i_data;
                            mem_counter <= 17;
                        when 17  => 
                            addr <= i_data;
                            o_address <= std_logic_vector(to_unsigned(9,o_address'length));
                            mem_counter <= 18;
                        when 18  =>
                            addr <= i_data;
                            status <= 1;
                        when others => 
                            mem_counter <= 0;
                        end case;
                else
                    en_status <= 1;
                    o_en <= '1';
                end if;
            elsif(i_start = '1') and (status = 1) then
                if(we_status = 1) then
                    if((addr - wz0) = "00000000") then
                        o_data <= "1" & "000" & "0001";
                    elsif((addr - (wz0 + "00000001")) = "00000000") then
                        o_data <= "1" & "000" & "0010";
                    elsif((addr - (wz0 + "00000010")) = "00000000") then
                        o_data <= "1" & "000" & "0100";
                    elsif ((addr - (wz0 + "00000011"))= "00000000") then
                        o_data <= "1" & "000" & "1000";
                    elsif((addr - wz1) = "00000000") then
                        o_data <= "1" & "001" & "0001";
                    elsif((addr - (wz1 + "00000001")) = "00000000") then
                        o_data <= "1" & "001" & "0010";
                    elsif((addr - (wz1 + "00000010")) = "00000000") then
                        o_data <= "1" & "001" & "0100";
                    elsif ((addr - (wz1 + "00000011")) = "00000000") then
                        o_data <= "1" & "001" & "1000";
                    elsif((addr - wz2) = "00000000") then
                        o_data <= "1" & "010" & "0001";
                    elsif((addr - (wz2 + "00000001")) = "00000000") then
                        o_data <= "1" & "010" & "0010";
                    elsif((addr - (wz2 + "00000010")) = "00000000") then
                        o_data <= "1" & "010" & "0100";
                    elsif ((addr - (wz2 + "00000011")) = "00000000") then
                        o_data <= "1" & "010" & "1000";
                    elsif((addr - wz3) = "00000000") then
                        o_data <= "1" & "011" & "0001";
                    elsif((addr - (wz3 + "00000001")) = "00000000") then
                        o_data <= "1" & "011" & "0010";
                    elsif((addr - (wz3 + "00000010")) = "00000000") then
                        o_data <= "1" & "011" & "0100";
                    elsif ((addr - (wz3 + "00000011")) = "00000000") then
                        o_data <= "1" & "011" & "1000";
                    elsif((addr - wz4) = "00000000") then
                        o_data <= "1" & "100" & "0001";
                    elsif((addr - (wz4 + "00000001")) = "00000000") then
                        o_data <= "1" & "100" & "0010";
                    elsif((addr - (wz4 + "00000010")) = "00000000") then
                        o_data <= "1" & "100" & "0100";
                    elsif ((addr - (wz4 + "00000011")) = "00000000") then
                        o_data <= "1" & "100" & "1000";
                    elsif((addr - wz5) = "00000000") then
                        o_data <= "1" & "101" & "0001";
                    elsif((addr - (wz5 + "00000001")) = "00000000") then
                        o_data <= "1" & "101" & "0010";
                    elsif((addr - (wz5 + "00000010")) = "00000000") then
                        o_data <= "1" & "101" & "0100";
                    elsif ((addr - (wz5 + "00000011")) = "00000000") then
                        o_data <= "1" & "101" & "1000";
                    elsif((addr - wz6) = "00000000") then
                        o_data <= "1" & "110" & "0001";
                    elsif((addr - (wz6 + "00000001")) = "00000000") then
                        o_data <= "1" & "110" & "0010";
                    elsif((addr - (wz6 + "00000010")) = "00000000")  then
                        o_data <= "1" & "110" & "0100";
                    elsif ((addr - (wz6 + "00000011")) = "00000000") then
                        o_data <= "1" & "110" & "1000";
                    elsif((addr - wz7) = "00000000") then
                        o_data <= "1" & "111" & "0001";
                    elsif((addr - (wz7 + "00000001")) = "00000000") then
                        o_data <= "1" & "111" & "0010";
                    elsif((addr - (wz7 + "00000010")) = "00000000") then
                        o_data <= "1" & "111" & "0100";
                    elsif ((addr - (wz7 + "00000011")) = "00000000") then
                        o_data <= "1" & "111" & "1000";
                    else
                        o_data <= addr;
                    end if;
                    status <= 2;
                else
                    o_we <= '1';
                    we_status <= 1;
                end if;
            elsif (i_start = '1') and (status = 2) then
                o_we <= '0';
                o_en <= '0';
                en_status <= 0;
                we_status <= 0;
                o_done <= '1';
                status <= 3;
            elsif (i_start = '0') and (status = 3) then
                o_done <= '0';
                status <= 0;
                o_address <= std_logic_vector(to_unsigned(8,o_address'length));
                mem_counter <= 17;
            end if;
        end if;
    end process;
end architecture Behavioral;
