# ##############################################################################

# iCEcube SDC

# Version:            2017.08.27940

# File Generated:     Feb 17 2018 06:37:20

# ##############################################################################

####---- CreateClock list ----2
create_clock  -period 4000 -waveform {0.00 2000} -name {clk} [get_ports {clk}] 
create_clock  -period 8000 -waveform {0.00 2000} -name {spi_clk} [get_ports {spi_clk}] 

