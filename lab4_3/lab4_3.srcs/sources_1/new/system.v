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
    input btnU, btnL, btnD, btnR,
    input clk
    );
    
    // declare input digits to 7 seg
    wire [7:0] num0;
    wire [7:0] num1;
    wire [7:0] num2;
    wire [7:0] num3;
   
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
    
    // buttons
    singlePulser add_btn(add,   btnU,clk);
    singlePulser sub_btn(sub,   btnL,clk);
    singlePulser mul_btn(mul,   btnD,clk);
    singlePulser div_btn(div,   btnR,clk);
    
    // connect input to rom
    reg [1:0] opcode;
    wire [23:0] data;
    wire [7:0] from_sw;
    
    genvar i;
    generate for(i=0;i<8;i=i+1)
    begin
        debouncer switch(from_sw[i],  sw[i],clk);
    end
    endgenerate
    
    rom calculator(data, {opcode,from_sw});
    
    // display data to 7 seg
    assign num3 = 8'h1F;
    assign {num2,num1,num0} = data;
    
    clockDiv fdivTarget(slowClk, tclk[18]);
    sevenSegModuleExtended q7seg(seg,dp,an0,an1,an2,an3, num0,num1,num2,num3,slowClk);
    
    always @(posedge clk)
    begin
        case({add,sub,mul,div})
            4'b1000:    opcode = 2'b00;
            4'b0100:    opcode = 2'b01;
            4'b0010:    opcode = 2'b10;
            4'b0001:    opcode = 2'b11;
        endcase
    end
    
endmodule
