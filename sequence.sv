//Generates transactions(sequence items)

class JTAG_sequence extends uvm_sequence;
    `uvm_object_utils(JTAG_sequence)

    //Send items to driver
    JTAG_sequence_item TRST_pkg;

    function new(string name="JTAG_sequence");
        super.new(name);
        `uvm_info("BASE_SEQ", "In constructor", UVM_HIGH)
    endfunction: new


    //A sequence must generate and send transactions over time, which requires delays and synchronization.
    // So we use task
    task body();
        `uvm_info("BASE_SEQ", "In body", UVM_HIGH)
        
        //Handle Name                                  //Item name
        TRST_pkg = JTAG_sequence_item::type_id::create("TRST_pkg");
        start_item(TRST_pkg);
        TRST_pkg.randomize() with {TRST==1;};
        finish_item(TRST_pkg);
    endtask:body
endclass: JTAG_sequence




//Another sequence we wanna create
class JTAG_test_sequence extends JTAG_sequence;
    `uvm_object_utils(JTAG_test_sequence)

    //Send items to driver
    JTAG_sequence_item item;

    function new(string name="JTAG_test_sequence");
        super.new(name);
        `uvm_info("TEST_SEQ", "In constructor", UVM_HIGH)
    endfunction: new


    //A sequence must generate and send transactions over time, which requires delays and synchronization.
    // So we use task
    task body();
        `uvm_info("TEST_SEQ", "In body", UVM_HIGH)
        
        //Handle Name                                  //Item name
        item = JTAG_sequence_item::type_id::create("item");
        start_item(item);
        item.randomize() with {TRST==0;};
        finish_item(item);
    endtask:body

endclass: JTAG_test_sequence


class JTAG_test_sequence_1 extends JTAG_sequence;
    `uvm_object_utils(JTAG_test_sequence_1)

    //Send items to driver
    JTAG_sequence_item item;

    function new(string name="JTAG_test_sequence_1");
        super.new(name);
        `uvm_info("TEST_SEQ", "In constructor", UVM_HIGH)
    endfunction: new


    //A sequence must generate and send transactions over time, which requires delays and synchronization.
    // So we use task
    task body();
        `uvm_info("TEST_SEQ", "In body", UVM_HIGH)
        
        //Handle Name                                  //Item name
        item = JTAG_sequence_item::type_id::create("item");
        start_item(item);
        item.randomize() with {TRST==0;TMS==1;};
        finish_item(item);
    endtask:body
endclass: JTAG_test_sequence_1


class JTAG_test_sequence_2 extends JTAG_sequence;
    `uvm_object_utils(JTAG_test_sequence_2)

    //Send items to driver
    JTAG_sequence_item item;

    function new(string name="JTAG_test_sequence_2");
        super.new(name);
        `uvm_info("TEST_SEQ", "In constructor", UVM_HIGH)
    endfunction: new


    //A sequence must generate and send transactions over time, which requires delays and synchronization.
    // So we use task
    task body();
        `uvm_info("TEST_SEQ", "In body", UVM_HIGH)
        
        //Handle Name                                  //Item name
        item = JTAG_sequence_item::type_id::create("item");
        start_item(item);
        item.randomize() with {TRST==0;TMS==0;};
        finish_item(item);
    endtask:body

endclass: JTAG_test_sequence_2