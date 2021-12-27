`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/18/2021 06:04:22 PM
// Design Name: 
// Module Name: tester
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


module testtask1();
    wire [31:0] S;
    reg [31:0] A,B;
    wire zero, Cout;
    reg Cin;
    reg [2:0] alu_ops;
    alu a(S,zero,Cout,A,B,Cin,alu_ops);
    
    initial
    begin
        #0 A=15; B=9; Cin=1; alu_ops = 3'b000;
        #20 alu_ops = 3'b001;
        #20 alu_ops = 3'b010;
        #20 alu_ops = 3'b011;
        #20 alu_ops = 3'b100;
        #20 alu_ops = 3'b101;
        #20 alu_ops = 3'b110;
        #20 alu_ops = 3'b111;
        #20 $finish;
    end

endmodule
