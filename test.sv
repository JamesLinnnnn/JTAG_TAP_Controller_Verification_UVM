class JTAG_test extends uvm_test;
    `uvm_component_utils(JTAG_test);


    //Cover what inside the test module
    JTAG_env env;
    //JTAG_coverage cov;
    //
    JTAG_sequence TRST_seq;
    JTAG_test_sequence test_seq;
    JTAG_test_sequence_1 test_seq_1;
    JTAG_test_sequence_2 test_seq_2;

    function new(string name="JTAG_test", uvm_component parent);
        super.new(name, parent);
        `uvm_info("Test_CLASS", "In test constructor",UVM_HIGH)
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("Test_CLASS", "In Build Phase",UVM_HIGH)

        env = JTAG_env::type_id::create("env", this);//Since it is a component, we need two parameters
        //cov = JTAG_coverage::type_id::create("cov", this);
        // Enable functional coverage recording
       // uvm_config_db#(int)::set(this, "env.*", "record_coverage", 1);
    endfunction:build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("Test_CLASS", "In connect Phase",UVM_HIGH)

        //connect monitor and scoreboard

    endfunction:connect_phase

    //Only Run Phase can consume time  and have time consuming statement so we use task
   task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("Test_CLASS", "In Run Phase",UVM_HIGH)

        phase.raise_objection(this);
        //start our sequences, we need sequence
    
        //TRST seq
        TRST_seq = JTAG_sequence::type_id::create("TRST_seq");
        TRST_seq.start(env.agnt.seqr);
        #2;
        repeat(20000)begin
            test_seq = JTAG_test_sequence::type_id::create("test_seq");
            test_seq.start(env.agnt.seqr);
            #1;
        end
        // repeat(30)begin
        // //test_seq
        //     test_seq_1 = JTAG_test_sequence_1::type_id::create("test_seq_1");
        //     test_seq_1.start(env.agnt.seqr);
        //     #1;
        //     test_seq_2 = JTAG_test_sequence_2::type_id::create("test_seq_2");
        //     test_seq_2.start(env.agnt.seqr);
        //     #1;
        //     test_seq_1 = JTAG_test_sequence_1::type_id::create("test_seq_1");
        //     test_seq_1.start(env.agnt.seqr);
        //     #1;
        //     test_seq_2 = JTAG_test_sequence_2::type_id::create("test_seq_2");
        //     test_seq_2.start(env.agnt.seqr);
        //     #1;
        // end
        // repeat(30)begin
        //     test_seq_2 = JTAG_test_sequence_2::type_id::create("test_seq_2");
        //     test_seq_2.start(env.agnt.seqr);
        //     #1;
        //     test_seq_1 = JTAG_test_sequence_1::type_id::create("test_seq_1");
        //     test_seq_1.start(env.agnt.seqr);
        //     #1;
        //     test_seq_2 = JTAG_test_sequence_2::type_id::create("test_seq_2");
        //     test_seq_2.start(env.agnt.seqr);
        //     #1;
        //     test_seq_1 = JTAG_test_sequence_1::type_id::create("test_seq_1");
        //     test_seq_1.start(env.agnt.seqr);
        //     #1;
        // end
        phase.drop_objection(this);
   endtask:run_phase

endclass: JTAG_test