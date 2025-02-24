// Because parameterized class, name the sequence item(transaction) we are going to use
// To let driver know what type of sequence item that we are gonna use in driver and sequencer

class JTAG_driver extends uvm_driver #(JTAG_sequence_item);
    `uvm_component_utils(JTAG_driver);  
    
    virtual JTAG_controller_interface vif;

    JTAG_sequence_item item;

    //----------------------------------------
    //Contructor
    //----------------------------------------                   
    function new (string name="JTAG_driver", uvm_component parent);
        super.new(name, parent);
        `uvm_info("DRIVER_CLASS", "In constructor", UVM_HIGH)
    endfunction:new

    //----------------------------------------
    //BUild Phase and get interface here ideally
    //----------------------------------------  
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("DRIVER_CLASS", "In build phase", UVM_HIGH)

        //Get Interface
        if(!(uvm_config_db #(virtual JTAG_controller_interface)::get(this, "*", "vif", vif)))begin
            `uvm_error("DRIVER_CLASS", "Cannot get the VIF from config DB!" )
        end
    endfunction: build_phase
    
    //----------------------------------------
    //Connect Phase
    //----------------------------------------  
    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("DRIVER_CLASS", "In connect phase", UVM_HIGH)
    endfunction: connect_phase


    //----------------------------------------
    //Run Phase
    //----------------------------------------  
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("DRIVER_CLASS", "In run phase", UVM_HIGH)

        //Logic
        forever begin
            item = JTAG_sequence_item::type_id::create("item");
            //let sequence from the sequencer
            seq_item_port.get_next_item(item);
            //logic
            drive(item);
            seq_item_port.item_done();
        end
 
    endtask: run_phase


    //Drive
    task drive(JTAG_sequence_item item);
        @(posedge vif.TCLK)
        vif.TRST <=item.TRST;
        vif.TMS <= item.TMS;
    endtask:drive

endclass:JTAG_driver

