class JTAG_scoreboard extends uvm_scoreboard;

    `uvm_component_utils(JTAG_scoreboard)

    //Received port with monitor
    uvm_analysis_imp #(JTAG_sequence_item, JTAG_scoreboard) scoreboard_port;

    JTAG_sequence_item transactions[$];


    function new(string name="JTAG_scoreboard", uvm_component parent);
        super.new(name, parent);
        `uvm_info("SCOREBOARD_CLASS", "In constructor", UVM_HIGH)
    endfunction: new

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `uvm_info("SCOREBOARD_CLASS", "In build phase", UVM_HIGH)

        scoreboard_port = new("scoreboard_port", this);
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        super.connect_phase(phase);
        `uvm_info("SCOREBOARD_CLASS", "In connect phase", UVM_HIGH)
    endfunction: connect_phase


    //-------------------------
    //Write Method to determine what is happen when monitor sends item to scoreboard
    //-------------------------
    function void write(JTAG_sequence_item item);
        //Save all packets
        transactions.push_back(item);

    endfunction:write


    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        `uvm_info("SCOREBOARD_CLASS", "In run phase", UVM_HIGH)

        forever begin
            //get the packet
            //generate the expected value and compare with actual value
            // score the transactions accordingly
            JTAG_sequence_item current_trans;
            //Wait for transactions
            wait((transactions.size()!=0));
            //Like FIFO, first in first out
            current_trans = transactions.pop_front();
            compare(current_trans);
        end
    endtask: run_phase

    function [3:0]expected_next_state(input [3:0]STATE, input bit TMS, input bit TRST);
        if(TRST)begin
            expected_next_state = 4'b0000;
        end
        else begin
        case(STATE)
            4'b0000:begin
                expected_next_state = (TMS==0)? 4'b0001:4'b0000;
            end  
            4'b0001:begin
                expected_next_state = (TMS==0)? 4'b0001:4'b0010;
            end
            4'b0010:begin
                expected_next_state = (TMS==0)?4'b0011:4'b1001;
            end
            4'b0011:begin
               expected_next_state = (TMS==0)?4'b0100:4'b0101;
            end
            4'b0100:begin
               expected_next_state = (TMS==0)?4'b0100:4'b0101;
            end
            4'b0101:begin
                expected_next_state = (TMS==0)?4'b0110:4'b1000;
            end
            4'b0110:begin
                expected_next_state = (TMS==0)?4'b0110:4'b0111;
            end
            4'b0111:begin
                expected_next_state = (TMS==0)?4'b0100:4'b1000;
            end
            4'b1000:begin
                expected_next_state = (TMS==0)?4'b0001:4'b0010;
            end
            4'b1001:begin
                expected_next_state  = (TMS==0)? 4'b1010:4'b0000;
            end
            4'b1010:begin
                expected_next_state  = (TMS==0)?4'b1011:4'b1100;
            end
            4'b1011:begin
                expected_next_state  = (TMS==0)?4'b1011:4'b1100;
            end
            4'b1100: begin
                expected_next_state = (TMS==0)?4'b1101:4'b1111;
            end
            4'b1101:begin
                expected_next_state  = (TMS==0)?4'b1101:4'b1110;
            end
            4'b1110:begin
               expected_next_state = (TMS==0)?4'b1011:4'b1111;
            end
            4'b1111:begin
                expected_next_state  = (TMS==0)?4'b0001:4'b0010;
            end
            default: expected_next_state = 4'b0000;

        endcase
            end
    endfunction: expected_next_state

    function void compare(JTAG_sequence_item item);
        bit TMS = item.TMS;
        bit TRST = item.TRST;
        logic [3:0]expected_state = expected_next_state(item.previous_state, TMS,  TRST);


        if(expected_state!=item.next_state)begin
            `uvm_error("COMPARE", $sformatf("Transaction failed! ACTUAL = %d, EXPETED = %d, TMS is %d, Prevoius Stste is %d, TRST is %d\n", item.next_state,  expected_state, TMS, item.previous_state, TRST))
        end
        else begin
            `uvm_info("COMPARE", $sformatf("Transaction passed! State transaction %0d -> %0d, TRST is %d, TMS is %d\n", item.previous_state, item.next_state, TRST, TMS), UVM_LOW)
        end

    endfunction: compare
endclass: JTAG_scoreboard