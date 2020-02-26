----------------------------------------------------------------------------------
-- Company:
-- Engineer:
--
-- Create Date: 29.12.2019 11:45:30
-- Design Name:
-- Module Name: source_code_project - Behavioral
-- Project Name:
-- Target Devices:
-- Tool Versions:
-- Description:
--
-- Dependencies:
--
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity source_code_project is
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
end source_code_project;

architecture Behavioral of source_code_project is
signal wz0 : std_logic_vector(7 downto 0); --Queste sono le "variabili" dove mettiamo le Working Zone
signal wz1 : std_logic_vector(7 downto 0);
signal wz2 : std_logic_vector(7 downto 0);
signal wz3 : std_logic_vector(7 downto 0);
signal wz4 : std_logic_vector(7 downto 0);
signal wz5 : std_logic_vector(7 downto 0);
signal wz6 : std_logic_vector(7 downto 0);
signal wz7 : std_logic_vector(7 downto 0);
signal contatoreWZReading  : integer; --Questo è un contatore per sapere a quale working zone sto leggendo
signal status : integer; --status: 0->Leggo input, 1->Scrivo l'output, 2->Disabilito o_done, questo perchè o_done deve rimanese in alto fino a quando i_start non sia sceso

begin
process(i_clk)
begin

    if (rising_edge(i_clk)) then
        if(i_rst = '1') then
            --Qui ho appena ricevuto il reset, quindi devo caricare tutte le working zone in memoria
            --Allora chiedo la prima working zone e abilito la memoria ad effettura le operazioni solo in lettura
            contatoreWZReading<=1;
            o_address <= std_logic_vector(to_unsigned(0,o_address'length));
            o_en <= '1';
            o_we <= '0';
            status <=0;
        end if;
        case contatoreWZReading is
        --Questo case mi serve per leggere una a una le varie working zone, usando il contatore per sapere dove sono
        --Questa è la soluzione più semplice che mi sia venuta in mente, anche se quella con più codice
                when 1 =>
                    wz0 <= i_data;
                    o_address <= std_logic_vector(to_unsigned(1,o_address'length));
                    contatoreWZReading <= 2;
                when 2 =>
                    wz1<=i_data;
                    o_address <= std_logic_vector(to_unsigned(2,o_address'length));
                    contatoreWZReading  <= 3;
                when 3 =>
                    wz2<=i_data;
                    o_address <= std_logic_vector(to_unsigned(3,o_address'length));
                    contatoreWZReading  <= 4;
                when 4 =>
                    wz3<=i_data;
                    o_address <= std_logic_vector(to_unsigned(4,o_address'length));
                    contatoreWZReading  <= 5;
                when 5 =>
                    wz4<=i_data;
                    o_address <= std_logic_vector(to_unsigned(5,o_address'length));
                    contatoreWZReading  <= 6;
                when 6 =>
                    wz5<=i_data;
                    o_address <= std_logic_vector(to_unsigned(6,o_address'length));
                    contatoreWZReading  <= 7;
                when 7 =>
                    wz6<=i_data;
                    o_address <= std_logic_vector(to_unsigned(7,o_address'length));
                    contatoreWZReading  <= 8;
                when 8 =>
                    --Questa è l'ultima working zone, quindi disabilito la memoria a fare operazioni
                    wz7<=i_data;
                    o_en<='0';
                    
         end case;




        --Questa if mi serve per sapere se ho letto tutte le working zone, quindi a questo punto se i_start è attivo inizio a processare
        if contatoreWZReading = 8 then
          
            case status is
              when 0 =>
                  --Qui faccio richiesta della cella dove c'è il dato che si leggerà nel prossimo ciclo
                  o_address <= std_logic_vector(to_unsigned(8,o_address'length)); --Vado a leggere nella 8° zona il valore di input
                  o_en <= '1';
                  if i_start = '1' then
                    status<=1;
                  end if;
              when 1 =>
              --Qui dovrebbe esserci in i_data il nostro valore da processare, inizia una serie di if contatenati
              --Il procedimento è questo, controllo se il i_data - wzX sia compreso tra 0 e 3
              --Allora se lo è metto in o_data il valore della wzX con X codificato, quindi "1JJJ0000", con JJJ (2) = X (10)
              --Poi con un case controllo la differenza, "traducendo" il valore che ottengo in onehot
              --Else fino all'ultima wz e nel caso non fosse in nessuna passo direttamente il valore d'ingresso in uscita
                if i_data - wz0 >0 and i_data - wz0 <3 then 
                    o_data <= "10000000";
                    case i_data - wz0 is
                        when "00000000" =>
                            o_data <= i_data + "00000001";
                        when "00000001" =>
                            o_data <= i_data + "00000010";
                        when "00000010" =>
                            o_data <= i_data + "00000100";
                        when "00000011" =>
                            o_data <= i_data + "00001000";
                    end case;
                    
                else
                    if i_data - wz1 >0 and i_data - wz1 <3 then
                    
                        o_data <= "10010000";
                        case i_data - wz1 is
                            when "00000000" =>
                                o_data <= i_data + "00000001";
                            when "00000001" =>
                                o_data <= i_data + "00000010";
                            when "00000010" =>
                                o_data <= i_data + "00000100";
                            when "00000011" =>
                                o_data <= i_data + "00001000";
                        end case;
                    else
                        if i_data - wz2 >0 and i_data - wz2 <3 then
                    
                        o_data <= "10100000";
                        case i_data - wz2 is
                            when "00000000" =>
                                o_data <= i_data + "00000001";
                            when "00000001" =>
                                o_data <= i_data + "00000010";
                            when "00000010" =>
                                o_data <= i_data + "00000100";
                            when "00000011" =>
                                o_data <= i_data + "00001000";
                        end case;
                        else
                            if i_data - wz3 >0 and i_data - wz3 <3 then
                                
                                o_data <= "10110000";
                                case i_data - wz3 is
                                    when "00000000" =>
                                        o_data <= i_data + "00000001";
                                    when "00000001" =>
                                        o_data <= i_data + "00000010";
                                    when "00000010" =>
                                        o_data <= i_data + "00000100";
                                    when "00000011" =>
                                        o_data <= i_data + "00001000";
                                end case;
                            else
                                if i_data - wz4 >0 and i_data - wz4 <3 then
                                    o_data <= "11000000";
                                    case i_data - wz4 is
                                        when "00000000" =>
                                            o_data <= i_data + "00000001";
                                        when "00000001" =>
                                            o_data <= i_data + "00000010";
                                        when "00000010" =>
                                            o_data <= i_data + "00000100";
                                        when "00000011" =>
                                        o_data <= i_data + "00001000";
                                    end case;
                                else
                                    if i_data - wz5 >0 and i_data - wz5 <3 then
                                        o_data <= "11010000";
                                        case i_data - wz5 is
                                            when "00000000" =>
                                                o_data <= i_data + "00000001";
                                            when "00000001" =>
                                                o_data <= i_data + "00000010";
                                            when "00000010" =>
                                                o_data <= i_data + "00000100";
                                            when "00000011" =>
                                        o_data <= i_data + "00001000";
                                        end case;
                                    else
                                        if i_data - wz6 >0 and i_data - wz6 <3 then
                                            o_data <= "11100000";
                                            case i_data - wz6 is
                                                when "00000000" =>
                                                    o_data <= i_data + "00000001";
                                                when "00000001" =>
                                                    o_data <= i_data + "00000010";
                                                when "00000010" =>
                                                    o_data <= i_data + "00000100";
                                                when "00000011" =>
                                                    o_data <= i_data + "00001000";
                                             end case;
                                        else
                                            if i_data - wz7 >0 and i_data - wz7 <3 then
                                                o_data <= "11110000";
                                                case i_data - wz7 is
                                                    when "00000000" =>
                                                        o_data <= i_data + "00000001";
                                                    when "00000001" =>
                                                        o_data <= i_data + "00000010";
                                                    when "00000010" =>
                                                        o_data <= i_data + "00000100";
                                                    when "00000011" =>
                                                        o_data <= i_data + "00001000";
                                                 end case;
                                            else
                                                o_data <= i_data;
                                            end if;
                o_we <= '1';
                o_done <= '1';
                status<=2;
                o_address <= "00001000"; -- Metto o_address a 8
              when 2 =>
                  if i_start = '0' then
                    o_done <= '0';
                    status <=  0;
                  end if;
              end case;

        end if;


    end if;
    end process;
end Behavioral;