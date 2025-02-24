//Interface is not dynamic, not like class
interface JTAG_controller_interface(input logic TCLK);
    logic TRST;
    logic TMS;
    logic [3:0]STATE;
    // logic [3:0]next_state;
    // logic [3:0]previous_state;
    // logic previous_TMS;
    // logic previous_TRST;
endinterface: JTAG_controller_interface