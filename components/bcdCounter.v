`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2021 06:09:12 PM
// Design Name: 
// Module Name: bcdCounter
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


module bcdCounter(
    output [3:0] num,
    output cout,
    output bout,
    input up,
    input down,
    input set0,
    input set9,
    input clk
    );
    
    reg [3:0] state;
    
    assign num = state;
    assign cout = state == 4'b1001 && up;
    assign bout = state == 4'b0000 && down;
    
    initial     
        state = 4'b0000;

    always @(posedge clk, posedge set0, posedge set9)
    begin
        if(set0 == 1) 
            state <= 4'b0000;
        else if(set9 == 1)
            state <= 4'b1001;
        else begin
            if(up == 1)
                if(state == 4'b1001)
                    state <= 4'b0000;
                else 
                    state = state + 1;
            else if(down == 1)
                if(state == 4'b0000)
                    state <= 4'b1001;
                else
                    state = state - 1;
        end
    end
    
endmodule
