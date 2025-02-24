class JTAG_env extends uvm_env;
    `uvm_component_utils(JTAG_env);

    //Both in the same hierachy
    JTAG_agent agnt;
    JTAG_scoreboard scb;
    JTAG_coverage cov;

    function new(string name="JTAG_env", uvm_component parent);
        super.new(name, parent);
        `uvm_info("ENV_CLASS", "In constructor", UVM_HIGH)
    endfunction:new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("ENVC_CLASS", "IN Build Phase", UVM_HIGH)

        agnt = JTAG_agent::type_id::create("agnt",this);
        scb = JTAG_scoreboard::type_id::create("scb", this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("ENV_CLASS", "In connect phase", UVM_HIGH)

        agnt.mon.monitor_port.connect(scb.scoreboard_port);
        //agnt.mon.monitor_port.connect(cov.analysis_export);
    endfunction: connect_phase

    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("ENV_CLASS", "In run phase", UVM_HIGH)

       repeat (10) begin
            #100;
            print_coverage();
        end
    endtask: run_phase

    function void print_coverage();
        real functional_coverage;
        functional_coverage = $get_coverage();  // SystemVerilog built-in function
        `uvm_info("COVERAGE", $sformatf("Current Coverage: %0.2f%%", functional_coverage), UVM_MEDIUM)
    endfunction


endclass:JTAG_env