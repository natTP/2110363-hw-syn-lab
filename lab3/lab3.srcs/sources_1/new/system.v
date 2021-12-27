`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2021 05:05:18 PM
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
    output [6:0] seg,
    output dp,
    output [3:0] an,
    input [7:0] sw,
    input btnU,
    input btnC,
    input clk
    );
    
    wire [3:0] num0;
    wire [3:0] num1;
    wire [3:0] num2;
    wire [3:0] num3;
    
    wire slowClk;
    wire an0, an1, an2, an3;
    assign an = {an3,an2,an1,an0}; 
    
    wire [18:0] tclk;
    assign tclk[0] = clk;
    
    genvar c;
    generate for(c=0;c<18;c=c+1)
    begin
        clockDiv fdiv(tclk[c+1], tclk[c]);
    end
    endgenerate
    
    singlePulser set0_btn(set0btn,  btnC,clk);
    singlePulser set9_btn(set9btn,  btnU,clk);
    
    debouncer down1_sw(down1,       sw[0],clk);
    debouncer up1_sw(up1,           sw[1],clk);
    debouncer down10_sw(down10,     sw[2],clk);
    debouncer up10_sw(up10,         sw[3],clk);
    debouncer down100_sw(down100,   sw[4],clk);
    debouncer up100_sw(up100,       sw[5],clk);
    debouncer down1000_sw(down1000, sw[6],clk);
    debouncer up1000_sw(up1000,     sw[7],clk);
        
    // handle overflow
    assign set0 = set0btn || bout3;
    assign set9 = set9btn || cout3;
    
    bcdCounter dig0(num0,cout0,bout0, up1,down1,set0,set9,clk);
    bcdCounter dig1(num1,cout1,bout1, cout0 || up10,    bout0 || down10,    set0,set9,clk);
    bcdCounter dig2(num2,cout2,bout2, cout1 || up100,   bout1 || down100,   set0,set9,clk);
    bcdCounter dig3(num3,cout3,bout3, cout2 || up1000,  bout2 || down1000,  set0,set9,clk);
    
    clockDiv fdivTarget(slowClk, tclk[18]);
    sevenSegModule q7seg(seg,dp,an0,an1,an2,an3, num0,num1,num2,num3,slowClk);
    
endmodule
