`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2021 10:56:50 AM
// Design Name: 
// Module Name: testSystem
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


module testSystem();
    wire [6:0] seg;
    wire dp;
    wire [3:0] an;
    reg [7:0] sw; 
    reg btnU, btnC, btnD, clk;
    system s(seg,dp,an,sw,btnU,btnC,btnD,clk);
    always 
        #10 clk = ~clk;
    initial begin
        #0 btnU = 0; btnC = 0; btnD = 0; clk = 0; sw=0;
        #20 sw=5; btnU = 1; #5 btnU = 0;
        #10 sw=200; #10 btnU = 1; #5 btnU = 0;
        #20 btnC = 1; #5 btnC = 0;
        #10 sw=187; #10 btnU = 1; #5 btnU = 0;
        #20 btnC = 1; #5 btnC = 0;
        #20 btnC = 1; #5 btnC = 0;
        #20 sw=5; btnU = 1; #5 btnU = 0;
        #10 sw=200; #10 btnU = 1; #5 btnU = 0;
        #20 btnD = 1; #5 btnD = 0;
        #200 $finish;
    end
    
endmodule
