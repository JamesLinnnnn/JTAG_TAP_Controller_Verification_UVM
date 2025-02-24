`timescale 1ns/1ns

module  tap_controller( 
    input TCLK, TRST, TMS,
    output logic[3:0]STATE
);

parameter test_logic_reset=4'b0000, run_test_idle=4'b0001, select_DR_scan=4'b0010, capture_DR=4'b0011, shift_DR=4'b0100;
parameter exit_1_DR=4'b0101, pause_DR=4'b0110, exit_2_DR=4'b0111, update_DR=4'b1000, select_IR_scan=4'b1001,capture_IR=4'b1010;
parameter shift_IR=4'b1011, exit_1_IR=4'b1100, pause_IR=4'b1101, exit_2_IR=4'b1110, update_IR=4'b1111;

logic [3:0]next_state;


//StateReg
always@(posedge TCLK)begin
    if(TRST)begin
        STATE<=test_logic_reset;
    end
    else begin
        STATE<=next_state;
        // previous_state<=STATE;
        // previous_TMS<=TMS;
        // previous_TRST<=TRST;
    end
end


//Combinational Logic
always@(STATE, TMS)begin
    case(STATE) 
        test_logic_reset:begin
            next_state=(TMS==0)?run_test_idle:test_logic_reset;
        end
        run_test_idle: begin
            next_state=(TMS==0)?run_test_idle:select_DR_scan;
        end
        select_DR_scan: begin
            next_state=(TMS==0)?capture_DR:select_IR_scan;
        end
        capture_DR:begin
            next_state=(TMS==0)?shift_DR:exit_1_DR;
        end
        shift_DR: begin
            next_state=(TMS==0)?shift_DR:exit_1_DR;
        end
        exit_1_DR: begin
            next_state=(TMS==0)?pause_DR:update_DR;
        end
        pause_DR:begin
            next_state=(TMS==0)?pause_DR:exit_2_DR;
        end
        exit_2_DR: begin
            next_state=(TMS==0)?shift_DR:update_DR;
        end
        update_DR: begin
            next_state=(TMS==0)?run_test_idle:select_DR_scan;
        end
        select_IR_scan:begin
            next_state=(TMS==0)?capture_IR:test_logic_reset;
        end
        capture_IR: begin
            next_state=(TMS==0)?shift_IR:exit_1_IR;
        end
        shift_IR: begin
            next_state=(TMS==0)?shift_IR:exit_1_IR;
        end
        exit_1_IR: begin
            next_state=(TMS==0)?pause_IR:update_IR;
        end
        pause_IR:begin
            next_state=(TMS==0)?pause_IR:exit_2_IR;
        end
        exit_2_IR: begin
            next_state=(TMS==0)?shift_IR:update_IR;
        end
        update_IR: begin
            next_state=(TMS==0)?run_test_idle:select_DR_scan;
        end
        default: next_state=test_logic_reset;
    endcase
end
endmodule

