`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/01/2021 05:20:08 PM
// Design Name: 
// Module Name: uart
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


module uart(
    output wire RsTx,
    input wire RsRx,
    input clk
    );
    
    reg en, prev_received;
    reg[7:0] data_in;
    wire[7:0] data_out;
    wire sent, received, tick;
    
    baudrate_gen baudrate_gen(.clk(clk), .tick(tick));
    uart_receiver       rx(.clk(tick), .RxD(RsRx),                  .done(received), .data(data_out));
    uart_transmitter    tx(.clk(tick), .data(data_in), .en(en),     .done(sent), .TxD(RsTx));
    
    always @(posedge tick) begin
        if(en) en = 0;
        if(~prev_received & received) begin
            data_in = data_out + 8'h01;
            if(data_in <= 8'h7A && data_in >= 8'h41) en = 1; //if next data is still a letter A-Za-z
        end
        prev_received = received;
    end
    
endmodule

//use tick to enable counting

module uart_transmitter(
    output reg TxD,
    output reg done,
    input wire [7:0]data,
    input wire en,
    input wire clk
    );
    
   reg prev_en;
   reg sending = 0;
   reg [7:0] cnt;
   reg [7:0] temp;
   
   always @(posedge clk) begin
        // if enabled, start sending
        if(~sending & ~prev_en & en) begin 
            temp <= data;
            sending <= 1;
            done <= 0;
            cnt <= 0;
        end
        
        prev_en <= en;
        
        if(sending) cnt <= cnt + 1;
        else begin
            cnt <= 0;
            TxD <= 1;
        end
        
        case(cnt)
            8'd8: TxD <= 0; // start bit
            8'd24: TxD <= temp[0];  
            8'd40: TxD <= temp[1];
            8'd56: TxD <= temp[2];
            8'd72: TxD <= temp[3];
            8'd88: TxD <= temp[4];
            8'd104: TxD <= temp[5];
            8'd120: TxD <= temp[6];
            8'd136: TxD <= temp[7];
            8'd152: begin done <= 1; sending <= 0; end
        endcase
   end
    
endmodule

module uart_receiver(
    output reg [7:0]data,
    output reg done,
    input wire RxD,
    input wire clk
    );
    
    reg prev_bit;
    reg receiving = 0;
    reg [7:0] cnt;
    
    always @(posedge clk) begin
        // if start bit comes in, start receiving
        if(~receiving & prev_bit & ~RxD) begin 
            receiving <= 1;
            done <= 0;
            cnt <= 0;
        end
        
        prev_bit = RxD;
        cnt <= receiving ? cnt+1 : 0;
        
        case(cnt)
            8'd24:  data[0] <= RxD;
            8'd40:  data[1] <= RxD;
            8'd56:  data[2] <= RxD;
            8'd72:  data[3] <= RxD;
            8'd88:  data[4] <= RxD;
            8'd104: data[5] <= RxD;
            8'd120: data[6] <= RxD;
            8'd136: data[7] <= RxD;
            8'd152: begin done <= 1; receiving <= 0; end
        endcase        
    end
    
endmodule