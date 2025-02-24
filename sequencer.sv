
//Arbitrates and schedules sequences, sending items to the driver.
class JTAG_sequencer extends uvm_sequencer #(JTAG_sequence_item);
    `uvm_component_utils(JTAG_sequencer)

    function new(string name="JTAG_sequencer", uvm_component parent);
        super.new(name, parent);
        `uvm_info("SEQR_CLASS", "In constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("SEQR_CLASS", "In build phase", UVM_HIGH)
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("SEQR_CLASS", "In connect phase", UVM_HIGH)
    endfunction: connect_phase

    // NO need run phase in sequencer because 

endclass: JTAG_sequencer