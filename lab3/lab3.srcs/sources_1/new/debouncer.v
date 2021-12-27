`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2021 11:32:40 PM
// Design Name: 
// Module Name: debouncer
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

//module debouncer(
//    output out,
//    input in,
//    input clk
//    );
    
//    reg cnt, outEn;
//    parameter CLOCK_PERIODS = 1000000;

//    dFlipFlop d1(q1, clk,1,in);
//    dFlipFlop d2(q2, clk,1,q1);
//    dFlipFlop d3(out,outEn,1,q2);
    
//    assign cntReset = q1 ^ q2;
    
//    always @(posedge clk)
//    begin
//        if(cntReset) cnt = 0;
//        else if(cnt == CLOCK_PERIODS) begin 
//            outEn = 1;
//            cnt = 0;
//        end
//        else cnt = cnt + 1;
//    end
    
//endmodule

module debouncer(
    output pulse,
    input in,
    input clk
    );
 
    wire q1, q2, mClk;
    
    wire [20:0] tclk;
    assign tclk[0] = clk;
    
    genvar c;
    generate for(c=0;c<20;c=c+1)
    begin
        clockDiv fdiv(tclk[c+1], tclk[c]);
    end
    endgenerate
    
    clockDiv fdivTarget(mClk, tclk[20]);
    dFlipFlop d1(q1, mClk,1,in);
    dFlipFlop d2(q2, mClk,1,q1);
    
    assign synced = q1 && ~q2;
    
    singlePulser pulser(pulse, synced,clk);

endmodule
