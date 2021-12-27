`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2021 07:20:22 PM
// Design Name: 
// Module Name: baudrate_gen
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


module baudrate_gen(
    output reg tick, 
    input wire clk  
    );

//    parameter CLOCK_FREQ = 1e8;
//    parameter BAUDRATE = 9600;
    
//    integer CLOCK_MAX = CLOCK_FREQ/(BAUDRATE * 32); = 325
    
    // Accumulator for timing
    integer cnt;
    
    always @(posedge clk) begin
        cnt = cnt + 1;
        if(cnt == 325) begin
            cnt = 0;
            tick = ~tick;
        end
    end

endmodule
