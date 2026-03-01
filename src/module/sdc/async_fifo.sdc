# Write clock
create_clock -name wr_clk -period 10 [get_ports wr_clk]

# Read clock
create_clock -name rd_clk -period 10 [get_ports rd_clk]


# DECLARE CLOCKS AS ASYNCHRONOUS
set_clock_groups -asynchronous \
    -group {wr_clk} \
    -group {rd_clk}


# INPUT DELAYS (per clock domain)

## Write clock ##
set_input_delay 2.0 -clock wr_clk [get_ports {wr_en din[*]}]

## Read clock ##
set_input_delay 2.0 -clock rd_clk [get_ports rd_en]

## OUTPUT DELAY ##
set_output_delay 2.0 -clock rd_clk [get_ports dout[*]]
set_output_delay 0 -clock wr_clk [get_ports full]
set_output_delay 0 -clock rd_clk [get_ports empty]



# RESET IS ASYNCHRONOUS (NOT TIMED)

set_false_path -from [get_ports rst]
