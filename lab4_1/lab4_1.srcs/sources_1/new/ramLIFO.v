`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/13/2021 04:14:30 PM
// Design Name: 
// Module Name: ramLIFO
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

module ramLIFO(
    output reg [7:0] data_out,
    input wire [7:0] data_in,
    input wire [7:0] address,
    input wire write,
    input clk
    );
    
    parameter RAM_WIDTH = 8;
    parameter RAM_ADDR_BITS = 8;
    
    reg [RAM_WIDTH-1:0] ram [(2**RAM_ADDR_BITS)-1:0];
    
    // BRAM because synchronous
    always @(posedge clk)
    begin
        if(write) begin
            ram[address] <= data_in;
            data_out <= data_in;
        end
        else data_out <= ram[address];
    end

endmodule
