`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2021 12:21:07 PM
// Design Name: 
// Module Name: stabilizer
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


module stabilizer(
    output out,
    input in,
    input clk
    );
    
    assign nreset = 1;
    assign out = q2;
    
    dFlipFlop d1(q1, clk,nreset,in);
    dFlipFlop d2(q2, clk,nreset,q1);
    
endmodule
