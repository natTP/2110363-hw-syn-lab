`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/02/2021 01:13:35 AM
// Design Name: 
// Module Name: system
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


module system(
    input wire [11:0]sw, //vga
    input btnC, btnU, btnL, //vga
    output wire Hsync, Vsync, //vga
    output wire [3:0] vgaRed, vgaGreen, vgaBlue, //vga
    output wire RsTx, //uart
    input wire RsRx, //uart
    output wire [10:0] led, //uart
    input clk //both
    );
    
    vga_test vga(
        .clk(clk), .sw(sw),
        .push({btnL, btnU}),
        .hsync(Hsync), .vsync(Vsync),
        .rgb({vgaRed, vgaGreen, vgaBlue})
        );
    
    uart uart(RsTx,RsRx,clk);
    
endmodule
