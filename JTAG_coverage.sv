class JTAG_coverage extends uvm_subscriber#(JTAG_sequence_item);
    `uvm_component_utils(JTAG_coverage)

    rand bit TMS;
    rand bit [3:0] next_state;
    rand bit [3:0] previous_state;
    // Define Covergroup
    covergroup cg;
        option.per_instance = 1;
    //     // Cover all FSM states
    //     state_cp: coverpoint previous_state {
    //         bins all_states[] = {[0:15]};
    //     }
  state: coverpoint previous_state {
            bins reset = {4'd0};             // Test_logic_reset
            bins idle = {4'd1};              // Run_test_idle
            bins select_dr = {4'd2};         // Select_DR_scan
            bins capture_dr = {4'd3};        // Capture_DR
            bins shift_dr = {4'd4};          // Shift_DR
            bins exit1_dr = {4'd5};          // Exit1_DR
            bins pause_dr = {4'd6};          // Pause_DR
            bins exit2_dr = {4'd7};          // Exit2_DR
            bins update_dr = {4'd8};         // Update_DR
            bins select_ir = {4'd9};         // Select_IR_scan
            bins capture_ir = {4'd10};       // Capture_IR
            bins shift_ir = {4'd11};         // Shift_IR
            bins exit1_ir = {4'd12};         // Exit1_IR
            bins pause_ir = {4'd13};         // Pause_IR
            bins exit2_ir = {4'd14};         // Exit2_IR
            bins update_ir = {4'd15};        // Update_IR
        }

        // // Cover FSM transitions
        // transition_cp: coverpoint {previous_state, next_state} {
        //     bins test_logic_reset_test_logic_reset = {0,0};
        //     bins test_logic_reset_run_test_idle = {0,1};
        //     bins run_test_idle_run_test_idle = {1,1};
        //     bins run_test_idle_sel_DR = {1,2};
        //     bins sel_DR_sel_IR = {2,9};
        //     bins sel_DR_cap_DR = {2,3};
        //     bins cap_DR_shift_DR = {3,4};
        //     bins cap_DR_exit_1_DR = {3,5};
        //     bins shift_DR_exit_1_DR = {4,5};
        //     bins shift_DR_shift_DR = {4,4};
        //     bins exit_1_DR_pause_DR = {5,6};
        //     bins exit_1_DR_update_DR = {5,8};
        //     bins pause_DR_pause_DR = {6,6};
        //     bins pause_DR_exit_2_DR = {6,7};
        //     bins exit_2_DR_update_DR = {7,8};
        //     bins exit_2_DR_shift_DR = {7,3};
        //     bins update_DR_run_test_idle = {8,1};
        //     bins update_DR_sel_DR = {8,2};
        //     bins sel_IR_test_logic_reset = {9,0};
        //     bins sel_IR_cap_IR = {9,10};
        //     bins cap_IR_shift_IR = {10,11};
        //     bins cap_IR_exit_1_IR = {10,12};
        //     bins shift_IR_shift_IR = {11,11};
        //     bins shift_IR_exit_1_IR = {11,12};
        //     bins exit_1_IR_pause_IR = {12,13};
        //     bins exit_1_IR_update_IR = {12,15};
        //     bins pause_IR_exit_2_IR = {13,14};
        //     bins pause_IR_pause_IR = {13,13};
        //     bins exit_2_IR_shift_IR = {14,11};
        //     bins exit_2_IR_update_IR = {14,15};
        //     bins update_IR_run_test_idle = {15,1};
        //     bins update_IR_sel_DR = {15,2};
        // }

        // Cover TMS transitions (0 and 1)
        TMS_cp: coverpoint TMS {
            bins low = {0};
            bins high = {1};
        }

        // Cross Coverage: How `TMS` affects FSM transitions
        state_TMS_cross: cross state, TMS_cp;
    
    endgroup

    // Constructor
    function new(string name = "JTAG_coverage", uvm_component parent=null);
        super.new(name, parent);
        cg = new();
    endfunction

    // `write()` function to receive transactions from monitor
    function void write(JTAG_sequence_item t);
        previous_state = t.previous_state;
        next_state = t.next_state;
        TMS = t.TMS;
        cg.sample();
        `uvm_info("JTAG_COVERAGE", $sformatf("Coverage sampled: Prev_State=%0d, Next_State=%0d, TMS=%0b",
            previous_state, next_state, TMS), UVM_MEDIUM)
    endfunction

endclass
