`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2021 06:27:15 PM
// Design Name: 
// Module Name: testRAM
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


module testRAM();
    reg [7:0] ram [255:0];
    wire [7:0] data;
    reg [7:0] data_out, data_in;
    reg [7:0] address;
    reg write, clk;
    ramLIFO stack(data, address, write, clk);
    
    always 
        #10 clk = ~clk;
        
    always @(write) 
        data_out <= data;
    assign data = write ? 8'bz : data_out;
        
    initial begin
        #10 write = 1; address=8'hFF; data_in=8'h05; data_out=0; data_in=0; clk=0;
        #100 write = 0;
        #20 address=8'hFF;
        #100 address=8'h00;
        #200 $finish;
    end
    
endmodule
