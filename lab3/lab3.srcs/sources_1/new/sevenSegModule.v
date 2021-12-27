`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2021 02:02:43 PM
// Design Name: 
// Module Name: SevenSegModule
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


module sevenSegModule(
    output [6:0] seg,
    output dp,
    output an0,
    output an1,
    output an2,
    output an3,
    input [3:0] num0,
    input [3:0] num1,
    input [3:0] num2,
    input [3:0] num3,
    input clk
    );
    
    reg [1:0] state;
    
    reg [3:0] displayEn;
    reg [3:0] hex;
    wire [6:0] segments;
    
    assign seg = segments;
    segmentDecoder segDecoder(segments, hex);
    assign dp = 1;
    assign {an3,an2,an1,an0} = ~displayEn;
    
    always @(posedge clk)
    begin 
        state = state + 1;
    end

    always @(state)
    begin
        case(state)
            2'b00: displayEn = 4'b0001;
            2'b01: displayEn = 4'b0010;
            2'b10: displayEn = 4'b0100;
            2'b11: displayEn = 4'b1000;
        endcase
    end
    
    always @(state)
    begin
        case(state)
            2'b00: hex = num0;
            2'b01: hex = num1;
            2'b10: hex = num2;
            2'b11: hex = num3;
        endcase
    end
    
endmodule
