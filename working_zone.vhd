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

signal en_status : std_logic := '0';
signal we_status : std_logic := '0';
signal wz_found : std_logic := '0';
signal encode_status : std_logic := '0';
signal tmp_o_data : std_logic_vector(7 downto 0);
signal mem_counter : integer := 0;
signal status : integer := 0;

constant binary0:std_logic_vector(2 downto 0) := "000";
constant binary1:std_logic_vector(2 downto 0) := "001";
constant binary2:std_logic_vector(2 downto 0) := "010";
constant binary3:std_logic_vector(2 downto 0) := "011";
constant binary4:std_logic_vector(2 downto 0) := "100";
constant binary5:std_logic_vector(2 downto 0) := "101";
constant binary6:std_logic_vector(2 downto 0) := "110";
constant binary7:std_logic_vector(2 downto 0) := "111";

constant onehot0:std_logic_vector(3 downto 0) := "0001";
constant onehot1:std_logic_vector(3 downto 0) := "0010";
constant onehot2:std_logic_vector(3 downto 0) := "0100";
constant onehot3:std_logic_vector(3 downto 0) := "1000";


begin
    process(i_clk, i_start, i_rst)

    begin
        if(rising_edge(i_clk)) then
            if(i_rst = '1') then
                o_en <= '0';
                o_we <= '0';
                o_done <= '0';
                en_status <= '0';
                we_status <= '0';
                wz_found <= '0';
                encode_status <= '0';
                mem_counter <= 0;
                status <= 0;
            else
                if(i_start = '1') then
                    case status is
                        when 0 => 
                            if(en_status = '0')then
                                o_en <= '1';
                                en_status <= '1';
                            else
                                case mem_counter is
                                    when 0 =>
                                        o_address <= std_logic_vector(to_unsigned(0,o_address'length));
                                        mem_counter <= 1;
                                     when 1 =>
                                        wz0 <= i_data;
                                        mem_counter <= 2;
                                    when 2 =>
                                        wz0 <= i_data;
                                         o_address <= std_logic_vector(to_unsigned(1,o_address'length));
                                        mem_counter <= 3;
                                    when 3 =>
                                        wz1 <= i_data;
                                        mem_counter <= 4;
                                    when 4 =>
                                        wz1 <= i_data;
                                        o_address <= std_logic_vector(to_unsigned(2,o_address'length));
                                        mem_counter <= 5;
                                    when 5 =>
                                        wz2 <= i_data;
                                        mem_counter <= 6;
                                    when 6 =>
                                        wz2 <= i_data;
                                        o_address <= std_logic_vector(to_unsigned(3,o_address'length));
                                        mem_counter <= 7;
                                    when 7  => 
                                        wz3 <= i_data;
                                        mem_counter  <= 8;
                                    when 8 =>
                                        wz3 <= i_data;
                                        o_address <= std_logic_vector(to_unsigned(4,o_address'length));
                                        mem_counter <= 9;
                                    when 9 =>
                                        wz4 <= i_data;
                                        mem_counter <= 10;
                                    when 10 =>
                                        wz4 <= i_data;
                                        o_address <= std_logic_vector(to_unsigned(5,o_address'length));
                                        mem_counter <= 11;
                                    when 11  => 
                                        wz5 <= i_data;
                                        mem_counter <= 12;
                                    when 12  => 
                                        wz5 <= i_data;
                                        o_address <= std_logic_vector(to_unsigned(6,o_address'length));
                                        mem_counter <= 13;
                                    when 13  => 
                                        wz6 <= i_data;
                                        mem_counter <= 14;
                                    when 14  => 
                                        wz6  <= i_data;
                                         o_address <= std_logic_vector(to_unsigned(7,o_address'length));
                                        mem_counter  <= 15;
                                    when 15  => 
                                        wz7  <= i_data;
                                        mem_counter <= 16;
                                    when 16  => 
                                        wz7 <= i_data;
                                        o_address <= std_logic_vector(to_unsigned(8,o_address'length));
                                        mem_counter <= 17;
                                    when 17  => 
                                        addr <= i_data;
                                        mem_counter <= 18;
                                    when 18  =>
                                        addr <= i_data;
                                        o_address <= std_logic_vector(to_unsigned(9,o_address'length));
                                        status <= 1;
                                    when others => 
                                        mem_counter <= 0;
                                    end case;
                            end if;
                        when 1 => 
                            if(we_status = '0') then
                                o_we <= '1';
                                we_status <= '1';
                            else
                                if(encode_status = '0') then
                                    case (addr - wz0) is
                                        when "00000000" => 
                                            tmp_o_data <= "1" & binary0 & onehot0;
                                            wz_found <= '1';
                                        when "00000001" => 
                                            tmp_o_data <= "1" & binary0 & onehot1;
                                            wz_found <= '1';
                                        when "00000010" => 
                                            tmp_o_data <= "1" & binary0 & onehot2;
                                            wz_found <= '1';
                                        when "00000011" =>
                                            tmp_o_data <= "1" & binary0 & onehot3;
                                            wz_found <= '1';
                                        when others => 
                                            encode_status <= '1';
                                    end case;

                                    case (addr - wz1) is
                                        when "00000000" => 
                                            tmp_o_data <= "1" & binary1 & onehot0;
                                            wz_found <= '1';
                                        when "00000001" => 
                                            tmp_o_data <= "1" & binary1 & onehot1;
                                            wz_found <= '1';
                                        when "00000010" => 
                                            tmp_o_data <= "1" & binary1 & onehot2;
                                            wz_found <= '1';
                                        when "00000011" =>
                                            tmp_o_data <= "1" & binary1 & onehot3;
                                            wz_found <= '1';
                                        when others => 
                                            encode_status <= '1';
                                    end case;

                                    case (addr - wz2) is
                                        when "00000000" => 
                                            tmp_o_data <= "1" & binary2 & onehot0;
                                            wz_found <= '1';
                                        when "00000001" => 
                                            tmp_o_data <= "1" & binary2 & onehot1;
                                            wz_found <= '1';
                                        when "00000010" => 
                                            tmp_o_data <= "1" & binary2 & onehot2;
                                            wz_found <= '1';
                                        when "00000011" =>
                                            tmp_o_data <= "1" & binary2 & onehot3;
                                            wz_found <= '1';
                                        when others => 
                                            encode_status <= '1';
                                    end case;

                                    case (addr - wz3) is
                                        when "00000000" => 
                                            tmp_o_data <= "1" & binary3 & onehot0;
                                            wz_found <= '1';
                                        when "00000001" => 
                                            tmp_o_data <= "1" & binary3 & onehot1;
                                            wz_found <= '1';
                                        when "00000010" => 
                                            tmp_o_data <= "1" & binary3 & onehot2;
                                            wz_found <= '1';
                                        when "00000011" =>
                                            tmp_o_data <= "1" & binary3 & onehot3;
                                            wz_found <= '1';
                                        when others => 
                                            encode_status <= '1';
                                    end case;

                                    case (addr - wz4) is
                                        when "00000000" => 
                                            tmp_o_data <= "1" & binary4 & onehot0;
                                            wz_found <= '1';
                                        when "00000001" => 
                                            tmp_o_data <= "1" & binary4 & onehot1;
                                            wz_found <= '1';
                                        when "00000010" => 
                                            tmp_o_data <= "1" & binary4 & onehot2;
                                            wz_found <= '1';
                                        when "00000011" =>
                                            tmp_o_data <= "1" & binary4 & onehot3;
                                            wz_found <= '1';
                                        when others => 
                                            encode_status <= '1'; 
                                    end case;

                                    case (addr - wz5) is
                                        when "00000000" => 
                                            tmp_o_data <= "1" & binary5 & onehot0;
                                            wz_found <= '1';
                                        when "00000001" => 
                                            tmp_o_data <= "1" & binary5 & onehot1;
                                            wz_found <= '1';
                                        when "00000010" => 
                                            tmp_o_data <= "1" & binary5 & onehot2;
                                            wz_found <= '1';
                                        when "00000011" =>
                                            tmp_o_data <= "1" & binary5 & onehot3;
                                            wz_found <= '1';
                                        when others => 
                                            encode_status <= '1'; 
                                    end case;

                                    case (addr - wz6) is
                                        when "00000000" => 
                                            tmp_o_data <= "1" & binary6 & onehot0;
                                            wz_found <= '1';
                                        when "00000001" => 
                                            tmp_o_data <= "1" & binary6 & onehot1;
                                            wz_found <= '1';
                                        when "00000010" => 
                                            tmp_o_data <= "1" & binary6 & onehot2;
                                            wz_found <= '1';
                                    when "00000011" =>
                                            tmp_o_data <= "1" & binary6 & onehot3;
                                            wz_found <= '1';
                                        when others => 
                                           encode_status <= '1';
                                    end case;

                                    case (addr - wz7) is
                                        when "00000000" => 
                                            tmp_o_data <= "1" & binary7 & onehot0;
                                            wz_found <= '1';
                                        when "00000001" => 
                                            tmp_o_data <= "1" & binary7 & onehot1;
                                            wz_found <= '1';
                                        when "00000010" => 
                                            tmp_o_data <= "1" & binary7 & onehot2;
                                            wz_found <= '1';
                                        when "00000011" =>
                                            tmp_o_data <= "1" & binary7 & onehot3;
                                            wz_found <= '1';
                                        when others => 
                                            encode_status <= '1';
                                    end case;
                                else
                                    if(wz_found = '1') then
                                        o_data <= tmp_o_data;
                                    else
                                        o_data <= addr;
                                    end if;
                                    status <= 2;
                                end if;
                            end if;
                        when 2 => 
                            o_we <= '0';
                            o_en <= '0';
                            en_status <= '0';
                            we_status <= '0';
                            o_done <= '1';
                            status <= 3;
                            encode_status <= '0';
                            wz_found <= '0';
                        when others => 
                            status <= 3;
                    end case;
                else
                    if(status = 3) then
                        o_done <= '0';
                        status <= 0;
                        o_address <= std_logic_vector(to_unsigned(8,o_address'length));
                        mem_counter <= 17;
                    end if;
                end if;
            end if;
        end if;
    end process;
end architecture Behavioral;
