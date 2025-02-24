
class JTAG_agent extends uvm_agent;
    `uvm_component_utils(JTAG_agent)

    JTAG_sequencer seqr;
    JTAG_driver drv;
    JTAG_monitor mon;

    function new(string name="JTAG_agent", uvm_component parent);
        super.new(name, parent);
        `uvm_info("AGNT_CLASS", "In constructor", UVM_HIGH)
    endfunction:new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("AGNT_CLASS", "In build phas", UVM_HIGH)

        seqr = JTAG_sequencer::type_id::create("seqr",this);
        mon = JTAG_monitor::type_id::create("mon", this);
        drv = JTAG_driver::type_id::create("drv", this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("AGNT_CLASS", "In connect phase", UVM_HIGH)

        //Connect sequencer and driver
        drv.seq_item_port.connect(seqr.seq_item_export);
    endfunction: connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("AGNT_CLASS", "In run phase", UVM_HIGH)

        //Logic

    endtask: run_phase
endclass: JTAG_agent