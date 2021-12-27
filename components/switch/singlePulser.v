`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2021 05:07:15 PM
// Design Name: 
// Module Name: singlePulser
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


module singlePulser(
    output reg pulse,
    input in,
    input clk
    );
    
    reg [1:0] state;
    parameter s0 = 2'b00, s1 = 2'b01, s2 = 2'b10;
    
    always @(posedge clk)
    begin
        if(in == 0) 
            state <= s0;
        else begin
            case(state)
                s0: state <= s1;
                s1: state <= s2;
                s2: state <= s2;
            endcase
        end
    end
    
    always @(state)
    begin
        if(state == s1) pulse = 1;
        else pulse = 0;
    end
    
endmodule
