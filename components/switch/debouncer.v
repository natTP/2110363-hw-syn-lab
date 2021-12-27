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

module debouncer(
    output wire pulse,
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
    
    //assign pulse = q1 && ~q2;
    assign pulse = q2;

endmodule
