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
signal wz0 : std_logic_vector(7 downto 0);
signal wz1 : std_logic_vector(7 downto 0);
signal wz2 : std_logic_vector(7 downto 0);
signal wz3 : std_logic_vector(7 downto 0);
signal wz4 : std_logic_vector(7 downto 0);
signal wz5 : std_logic_vector(7 downto 0);
signal wz6 : std_logic_vector(7 downto 0);
signal wz7 : std_logic_vector(7 downto 0);
signal contatoreWZReading  : integer;
signal status : integer; --status: 0->Leggo input, 1->Scrivo l'output, 2->Disabilito o_done, questo perchè o_done deve rimanese in alto fino a quando i_start non sia sceso

begin
process(i_clk)
begin

    if (rising_edge(i_clk)) then
        if(i_rst = '1') then
            contatoreWZReading<=0;
            o_address <= std_logic_vector(to_unsigned(0,o_address'length)); --Non so bene come specificare che o_adress deva indicare la cella numero [0]
            o_en <= '1';
            status <=0;
        end if;
        case contatoreWZReading is
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
                    wz7<=i_data;
                    o_en<='0';
         end case;





        if(contatoreWZReading==8)then
        case status is
          when 0 =>
              o_adress <= 8; --Vado a leggere nella 8° zona il valore di input
              o_en <= 1;
              if(i_start=1) then
                status<=1;
              end if;
          when 1 =>
            --Qui va l'elaborazione del dato, a questo punto creo un entita che passandogli le 8 wz e l'indirizzo di base elabora per darmi il risultato



            o_we <= 1;
            o_done <=1;
            status<=2;
          when 2 =>
          if(i_start=0) then
            o_done=0;
            status<=0;
          end if;
          end case;

        endif;










-- Instanzo un contatore da 0 a 7, con un bit di fine


-- Quando mi arriva il bit di reset, faccio ripartire il contatore, da li faccio 7 cicli di clock per riempire i signal

-- Aspetto che i_start sia ad 1,
-- A quel punto si parte nella lettura, quindi o_address deve andare all'ottava posizione della RAM, o_en = 1 e o_we = 0
-- Ricevo su i_data l'indirizzo che devo condificare, quindi devo prenderlo e fare le operazioni

    end if;
end Behavioral;



































entity encoder_logic is
  Port (
    wz0               : in std_logic_vector(7 downto 0);
    wz1               : in std_logic_vector(7 downto 0);
    wz2               : in std_logic_vector(7 downto 0);
    wz3               : in std_logic_vector(7 downto 0);
    wz4               : in std_logic_vector(7 downto 0);
    wz5               : in std_logic_vector(7 downto 0);
    wz6               : in std_logic_vector(7 downto 0);
    wz7               : in std_logic_vector(7 downto 0);
    input_address     : in std_logic_vector(7 downto 0);
    output_address    : out std_logic_vector(7 downto 0);
 );
end encoder_logic;

architecture Behavioral of encoder_logic is

begin

--Non so come implementarlo, la mia idea è di creare un componente che mi da l'output solo se questo è
--Questo perchè vorrei scrivere del codice pulito, molto semplice da controllare

--Se potessi creare un componente che passandogli in input (wz,"Numero wz", input_address) come output mi dia ((booleano)is_in, output_address )
--Così in questa entity faccio if(is_in) then output_address<=output_address else if così via fino a che l'ultimo else faccio output_address<=input_address

end Behavioral;
