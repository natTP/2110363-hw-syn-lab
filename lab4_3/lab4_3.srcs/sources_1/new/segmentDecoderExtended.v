`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/31/2021 01:53:35 PM
// Design Name: 
// Module Name: segmentDecoder
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


module segmentDecoderExtended(
    output reg [6:0] segment,
    input [7:0] hex
    );
    
// 7-segment encoding
//      0
//     ---
//  5 |   | 1
//     --- <--6
//  4 |   | 2
//     ---
//      3
   
   always @(hex)
      case (hex)
          8'h01 : segment = 7'b1111001;   // 1
          8'h02 : segment = 7'b0100100;   // 2
          8'h03 : segment = 7'b0110000;   // 3
          8'h04 : segment = 7'b0011001;   // 4
          8'h05 : segment = 7'b0010010;   // 5
          8'h06 : segment = 7'b0000010;   // 6
          8'h07 : segment = 7'b1111000;   // 7
          8'h08 : segment = 7'b0000000;   // 8
          8'h09 : segment = 7'b0010000;   // 9
          8'h0A : segment = 7'b0001000;   // A
          8'h0B : segment = 7'b0000011;   // b
          8'h0C : segment = 7'b1000110;   // C
          8'h0D : segment = 7'b0100001;   // d
          8'h0E : segment = 7'b0000110;   // E
          8'h0F : segment = 7'b0001110;   // F
          8'h10 : segment = 7'b0111111;   // -
          8'h1F : segment = 7'b1111111;   // <empty>
          default  : segment = 7'b1000000;   // 0
      endcase
				
				
endmodule
