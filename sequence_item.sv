// Object class

class JTAG_sequence_item extends uvm_sequence_item;
    `uvm_object_utils(JTAG_sequence_item)

    //--------------------------
    //Istantiation
    //--------------------------
    rand logic TRST;
    rand logic TMS;
    // logic [3:0]previous_state, next_state;
    // logic previous_TMS, previous_TRST;
    logic [3:0]previous_state;
    logic [3:0]next_state;//output, don't randanmize it
    //logic [3:0]STATE;
    // //-----------------------------------------
    // //Default Constraints
    // //-----------------------------------------
    // constraint input1_c(a inside {[10:20]};)
    // constraint input2_c(b inside {[1:10]};)
    // constraint input3_c(op_code inside {[0, 1, 2, 3]};)

    //-----------------------------------------
    //Contructor
    //-----------------------------------------
    function new (string name="JTAG_sequence_item" );
        super.new(name);
    endfunction: new


endclass: JTAG_sequence_item