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
    input btnU, btnC, btnD, clk
    );
    
//    // declare input digits to 7 seg
//    wire [3:0] num0;
//    wire [3:0] num1;
//    wire [3:0] num2;
//    wire [3:0] num3;
   
//    // clock division
//    wire slowClk;
//    wire an0, an1, an2, an3;
//    assign an = {an3,an2,an1,an0}; 
    
//    wire [18:0] tclk;
//    assign tclk[0] = clk;
    
//    genvar c;
//    generate for(c=0;c<18;c=c+1)
//    begin
//        clockDiv fdiv(tclk[c+1], tclk[c]);
//    end
//    endgenerate
    
//    // buttons
//    singlePulser push_btn(push,     btnU,clk);
//    singlePulser pop_btn(pop,       btnC,clk);
//    singlePulser clear_btn(clear,   btnD,clk);
    
//    // connect input to data
//    wire [7:0] data_in;
//    wire [7:0] data_out;
//    wire [7:0] from_sw;
    
//    assign data_in = from_sw;
//    assign {num3,num2} = data_out;
    
//    genvar i;
//    generate for(i=0;i<8;i=i+1)
//    begin
//        debouncer switch(from_sw[i],  sw[i],clk);
//    end
//    endgenerate
    
//    ramLIFO stack(data_out, data_in,top,write,clk);
    
//    // stack pointer 
//    reg [7:0] top;
//    reg [1:0] state, nstate;
//    wire write = state == 2'b01;

//    assign {num1,num0} = top;
    
//    clockDiv fdivTarget(slowClk, tclk[18]);
//    sevenSegModule q7seg(seg,dp,an0,an1,an2,an3, num0,num1,num2,num3,slowClk);
    
//    initial
//    begin
//        top = 0;
//        state = 2'b0;
//        nstate = 2'b0;
//    end
    
//    always @(posedge clk)
//    begin
//        state = nstate;
//        casez({state, pop, push, clear})
//            default: 
//                nstate = 2'b0;
//            5'b00001: begin         //state 0 & clear
//                top = 0; 
//                nstate = 2'b0; 
//                end
//            5'b00010:               //state 0 & push -> write RAM next clock
//                if(top < 255) nstate = 2'b01;
//            5'b00100:               //state 0 & pop -> read RAM next clock
//                if(top > 0) begin 
//                    nstate = 2'b10; 
//                    top = top - 1; 
//                    end
//            5'b010?0: begin         //state 1 -> write RAM
//                nstate = 2'b0;
//                top = top + 1; 
//                end
//            5'b10?00: nstate = 0;  //state 2 -> read RAM
//        endcase
//    end
    
endmodule
