`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/06/2021 05:39:33 PM
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

module testSinglePulser();
    reg in,clk;
    singlePulser pulser(pulse,in,clk);
    always
        #10 clk = ~clk;
    initial begin
        #0 in = 0; clk = 0;
        #15 in = 1;
        #10 in = 0;
        #100 in = 1;
        #10 in = 0;
        #100 in = 1;
        #100 in = 0;
        #500 $finish;
    end
    
endmodule

module testBCDCounter();
    wire [3:0] num;
    reg up,down,set9,set0,clk;
    bcdCounter counter(num,cout,bout,up,down,set0,set9,clk);
    always 
        #10 clk = ~clk;
    initial begin
        #0 up = 0; down = 0; set0 = 0; set9 = 0; clk = 0;
        #100 up = 1;
        #200 up = 0; down = 1;
        #300 down = 0; up = 1;
        #200 set0 = 1;
        #50 set0 = 0;
        #50 set9 = 1;
        #50 set9 = 0;
        #200 $finish;
    end
    
endmodule

//module testDebouncer();
//    reg in,clk;
//    debouncer debouncer(pulse,in,clk);
//    always
//        #10 clk = ~clk;
//    initial begin
//        #0 in = 0; clk = 0;
//        #15 in = 1;s
//        #10 in = 0;
//        #100 in = 1;
//        #10 in = 0;
//        #100 in = 1;
//        #100 in = 0;
//        #500 $finish;
//    end
    
//endmodule

module testMultidigitBDCCounter();
    wire [3:0] num0;
    wire [3:0] num1;
    wire [3:0] num2;
    wire [3:0] num3;
    wire cout0, bout0, cout1, bout1, cout2, bout2, cout3, bout3;
    
    reg up1,down1,up10,down10,up100,down100,up1000,down1000;
    reg set9,set0,clk;
    
    bcdCounter dig0(num0,cout0,bout0, up1,down1,set0,set9,clk);
    bcdCounter dig1(num1,cout1,bout1, cout0 || up10,    bout0 || down10,    set0,set9,clk);
    bcdCounter dig2(num2,cout2,bout2, cout1 || up100,   bout1 || down100,   set0,set9,clk);
    bcdCounter dig3(num3,cout3,bout3, cout2 || up1000,  bout2 || down1000,  set0,set9,clk);
    
    always 
        #10 clk = ~clk;
    initial begin
        #0 up1 = 0; down1 = 0; 
        up10 = 0; down10 = 0; 
        up100 = 0; down100 = 0; 
        up1000 = 0; down1000 = 0;
        set0 = 0; set9 = 0; clk = 0;
        
        #100 up1 = 1;
        #200 up1 = 0; down1 = 1;
        #1000 down1 = 0; up1 = 1;
        #20 up10 = 1;
        #40 up10 =0; up1000 = 1;
        #200 set0=1;
        #50 set0 = 0;
        #50 set9 = 1;
        #50 set9 = 0;
        #200 $finish;
    end
    
endmodule