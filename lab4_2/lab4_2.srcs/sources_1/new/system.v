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
    input [4:0] sw,
    input clk
    );
    
    // declare input digits to 7 seg
    wire [3:0] num0;
    wire [3:0] num1;
    wire [3:0] num2;
    wire [3:0] num3;
   
    // clock division
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
    
    // connect input to rom
    wire[7:0] data;
    wire [4:0] from_sw;
    
    genvar i;
    generate for(i=0;i<5;i=i+1)
    begin
        debouncer switch(from_sw[i],  sw[i],clk);
    end
    endgenerate

    rom binaryToBCD(data, from_sw);
    assign {num1,num0} = data;
    
    clockDiv fdivTarget(slowClk, tclk[18]);
    sevenSegModule q7seg(seg,dp,an0,an1,an2,an3, num0,num1,num2,num3,slowClk);
    
endmodule
