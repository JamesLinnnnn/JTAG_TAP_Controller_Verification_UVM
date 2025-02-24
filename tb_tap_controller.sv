`timescale 1ns/1ns

module tb_tap_controller;

reg TCLK, TRST, TMS;
wire[3:0]STATE;

integer outfile;


tap_controller uut(
    .TCLK(TCLK),
    .TRST(TRST),
    .TMS(TMS),
    .STATE(STATE)
);

initial begin
    outfile= $fopen("tap_controller.out", "w");
    if(!outfile)begin
        $display("We cannot open output file\n");
        $stop;
    end
    $monitor("At time %0t ns, TMS = %b, STATE = %b\n", $time, TMS, STATE);
    $fmonitor(outfile,"At time %0t ns, TMS = %b, STATE = %b\n", $time, TMS, STATE);
end

initial begin
    TCLK=0;
    TMS=0;
end
always #1 TCLK=~TCLK;

initial begin
    TRST=1;
    #2;
    TRST=0;
    TMS=1;
    #2;
    // First, I want to test all path along DR.
    //run test idle
    TMS=0;
    #4;
    TMS=1;
    #2;
    // select DR scan
    TMS=0;
    #2;
    //capture DR
    TMS=0;
    #2;
    //shift DR
    TMS=0;
    #2;
    TMS=1;
    #2;
    // exit1 DR
    TMS=0;
    #2;
    // pause DR
    TMS=0;
    #2;
    TMS=1;
    #2;
    //exit 2 DR
    TMS=1;
    #2;
    //update DR
    TMS=0;
    #2;
    //back to run test idle
    TMS=1;
    #2;
    TMS=0;
    #2;
    //in capture DR
    TMS=1;
    #2;
    // in exit 1 DR
    TMS=0;
    #2;
    TMS=1;
    #2;
    //in exit 2 DR
    TMS=0;
    #2;
    // in shift DR
    TMS=1;
    #2;
    //in exit 1 DR
    TMS=1;
    #2;
    // in update DR
    TMS=1;
    #2;
    //in select DR scan
    TMS=1;
    #2;
    //in select IR scan
    TMS=1;
    #2;
    //back to test logic reset
    TMS=0;
    #2;
    //run test idle
    TMS=1;
    #2;
    //select IR scan
    TMS=1;
    #2;
    // back to selct IR scan
    TMS=0;
    #2;
    // in capture IR
    TMS=0;
    #2;
    // in shift IR
    TMS=0;
    #2;
    TMS=1;
    #2;
    // in exit 1 IR
    TMS=0;
    #2;
    //in pause IR
    TMS=0;
    #2;
    TMS=1;
    #2;
    //in exit 2 IR
    TMS=1;
    #2;
    // update IR
    TMS=0;
    #2;
    //back to run test idle
    TMS=1;
    #2;
    // in sel DR scan
    TMS=1;
    #2;
    //sel IR scan
    TMS=0;
    #2;
    // capture IR
    TMS=1;
    #2;
    //in exit 1 IR
    TMS=0;
    #2;
    //pause IR
    TMS=1;
    #2;
    // in exit 2 IR
    TMS=0;
    #2;
    // in shift IR
    TMS=1;
    #2;
    //in exit 1 IR
    TMS=1;
    #2;
    //in update IR
    TMS=1;
    #2;
    //in select DR scan
    #10;
    $fclose(outfile);
    $finish;    
end
endmodule