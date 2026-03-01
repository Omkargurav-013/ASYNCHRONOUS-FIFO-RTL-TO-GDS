
# DESIGN
set ::env(DESIGN_NAME) "async_fifo"

set ::env(VERILOG_FILES) [glob ./designs/FIFO/src/*.v]

set ::env(BASE_SDC_FILE) "./designs/FIFO/src/async_fifo.sdc"



# CLOCK CONFIGURATION
set ::env(CLOCK_PORT) "wr_clk rd_clk"
set ::env(CLOCK_PERIOD) "10.0"



# RESET CONFIGURATION

set ::env(RESET_PORT) "rst"
set ::env(RESET_POLARITY) "HIGH"


# STA SETTINGS
set ::env(STA_MULTICORNER) 1



# FLOORPLAN
set ::env(FP_CORE_UTIL) 55
set ::env(FP_PIN_ORDER_CFG) [glob $::env(DESIGN_DIR)/src/pin_order.cfg]
set ::env(FP_IO_HLAYER) {met3}
set ::env(FP_IO_VLAYER) {met4}


# ANTENNA FIXING

 set ::env(DIODE_CELL) "sky130_fd_sc_hd__diode_2"
 set ::env(DIODE_CELL_PIN) "DIODE"


set filename $::env(OPENLANE_ROOT)/designs/$::env(DESIGN_NAME)/$::env(PDK)_$::env(STD_CELL_LIBRARY)_config.tcl
if { [file exists $filename] } {
    source $filename
}
