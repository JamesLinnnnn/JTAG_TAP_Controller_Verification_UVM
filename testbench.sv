`timescale 1ns/1ns


import uvm_pkg::*;
`include "uvm_macros.svh"


//--------------------------------------
// Include Files
//--------------------------------------

//The order of include files is very important
`include "interface.sv"
`include "sequence_item.sv"
`include "sequence.sv"
`include "sequencer.sv"
`include "driver.sv"
`include "JTAG_coverage.sv"
`include "monitor.sv"
`include "agent.sv"
`include "scoreboard.sv"
`include "env.sv"
`include "test.sv"

module top;

logic TCLK;

JTAG_controller_interface intf(.TCLK(TCLK));

tap_controller uut(
    .TCLK(intf.TCLK),
    .TRST(intf.TRST),
    .TMS(intf.TMS),
    .STATE(intf.STATE)
);


//--------------------------------------
// Interface setting since interface is not dynamic, not like class
//--------------------------------------
initial begin                   
    // The first parameter(null) plus the second parameter(*, every component) specify the path wherethis handle will be available
    //so those path are able to access the interface
    //the third argument means, totlaly four arguments here
    //Driver and monitor need virtual interface
    uvm_config_db #(virtual JTAG_controller_interface)::set(null, "*", "vif",intf);
end


//--------------------------------------
// Start the test
//--------------------------------------
initial begin
    run_test("JTAG_test");
end

    initial begin
        TCLK = 0;
        #5;
        forever begin
            TCLK = ~TCLK;
            #2;
        end
    end

initial begin
    #1000000;
    $display("Finish due to too many clock cycles, please check design!\n");
    $finish;
end

initial begin
    $dumpfile("JTAG_controller.vcd");
    $dumpvars();
end

endmodule:top