`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/07/2021 12:12:24 AM
// Design Name: 
// Module Name: stabilizedSinglePulser
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


module stabilizedSinglePulser(
    output pulse,
    input in,
    input clk
    );
    
    stabilizer s(outS,in,clk);
    debouncer d(outD,outS,clk);
    
    singlePulser pulser(pulse,outD,clk);
    
endmodule
