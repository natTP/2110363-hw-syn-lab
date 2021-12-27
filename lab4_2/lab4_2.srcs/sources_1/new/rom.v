`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/14/2021 06:04:38 PM
// Design Name: 
// Module Name: rom
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


module rom(
    output wire [7:0] data,
    input wire [4:0] address
    );
    
    (* synthesis, rom_block = "ROM_CELL XYZ01" *)
    (* ram_style = "distributed" *)
    
    parameter ROM_WIDTH = 8;
    parameter ROM_ADDR_BITS = 5;
    
    reg [ROM_WIDTH-1:0] rom [0:(2**ROM_ADDR_BITS)-1];
    
    initial $readmemb("decimalToBCD.mem", rom);
    assign data = rom[address];

endmodule
