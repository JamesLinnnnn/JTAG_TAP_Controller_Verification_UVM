class JTAG_monitor extends uvm_monitor;
    `uvm_component_utils(JTAG_monitor)

    virtual JTAG_controller_interface vif;
    JTAG_sequence_item item;
    JTAG_coverage cov;

    //Build port for scoreboard
    uvm_analysis_port #(JTAG_sequence_item) monitor_port;



    function new(string name="JTAG_monitor", uvm_component parent);
        super.new(name, parent);
        `uvm_info("MONITOR_CLASS", "In constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("MONITOR_CLASS", "In build phase", UVM_HIGH)

        monitor_port = new("monitor_port",this);
        cov = JTAG_coverage::type_id::create("cov", this);         
        //Get Interface
        if(!(uvm_config_db #(virtual JTAG_controller_interface)::get(this, "*", "vif", vif)))begin
            `uvm_error("MONITOR_CLASS", "Cannot get the VIF from config DB!" )
        end
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("MONITOR_CLASS", "In connect phase", UVM_HIGH)
    endfunction: connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("MONITOR_CLASS", "In run phase", UVM_HIGH)

        forever begin
            item = JTAG_sequence_item::type_id::create("item");
            
            //Only sample when TRST=0
            @(posedge vif.TCLK)
            item.previous_state=vif.STATE;
            //Sample inputs, use blocking here because general practice in monitor
            item.TMS = vif.TMS;
            item.TRST= vif.TRST;

            cov.write(item);
            @(posedge vif.TCLK)
            //Sample outputs, we need to wait one more cycle to get outputs
            item.next_state = vif.STATE;
            cov.write(item);
            //Send something to scoreboard
            monitor_port.write(item);
        end
    endtask: run_phase


endclass: JTAG_monitor