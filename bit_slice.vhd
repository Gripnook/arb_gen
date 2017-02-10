library ieee;
use ieee.std_logic_1164.all;

entity bit_slice is
    port (clock : in std_logic;
          reset : in std_logic;
          frequency_control : in std_logic;
          update_in : in std_logic;
          Cin : in std_logic;
          update_out : out std_logic;
          Cout : out std_logic);
end bit_slice;

architecture arch of bit_slice is

    component delay_equalizer is
        port (clock : in std_logic;
              reset : in std_logic;
              frequency_control_in : in std_logic;
              update_in : in std_logic;
              frequency_control_out : out std_logic;
              update_out : out std_logic);
    end component;

    component accumulator is
        port (clock : in std_logic;
              reset : in std_logic;
              A : in std_logic;
              Cin : in std_logic;
              Cout : out std_logic);
    end component;

    signal frequency_control_internal : std_logic;

begin

    delay : delay_equalizer
    port map (clock => clock,
              reset => reset,
              frequency_control_in => frequency_control,
              update_in => update_in,
              frequency_control_out => frequency_control_internal,
              update_out => update_out);

    acc : accumulator
    port map (clock => clock,
              reset => reset,
              A => frequency_control_internal,
              Cin => Cin,
              Cout => Cout);

end architecture;
