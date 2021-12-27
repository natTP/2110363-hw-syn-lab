`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/24/2021 01:01:18 PM
// Design Name: 
// Module Name: dFlipFlop
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


module dFlipFlop(
    output q,
    input clock,
    input nreset,
    input d
    );
    
    reg q;
    
    always @(posedge clock)
    begin
        if (nreset==1)
            q=d;
        else
            q=0;
    end
endmodule
