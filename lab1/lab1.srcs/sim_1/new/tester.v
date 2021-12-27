`timescale 1ns / 1ns
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/23/2021 07:46:01 PM
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


module tester;
    reg a,b,cin;
    wire cout,s;
    fullAdder2 a1(cout,s,a,b,cin);
initial
begin
    //$dumpfile("time.dump");
    //$dumpvars(2,a1);
    $monitor("time %t: {%b %b} <- {%d %d %d}", $time,cout,s,a,b,cin);
    
    #0;
    a=0;
    b=0;
    cin=0;
    
    #10;
    cin=1;
    
    #10;
    b=1;
    
    #10;
    cin=0;
    
    #10;
    a=1;
    
    #10;
    cin=1;
    
    #10;
    b=0;
    
    #10;
    cin=0;
    
    #50
    
    $finish;
end
endmodule

module testDFlipFlop();
    reg clock, nreset, d;
    dFlipFlop D1(q,clock,nreset,d);
    always
        #10 clock=~clock;
    initial
    begin
    //$dumpfile("testDFlipFlop.dump");
    //$dumpvars(1,D1);
    #0 d=0;
    clock=0;
    nreset=0;
    #50 nreset=1;
    #300 nreset=0;
    #1000 $finish;
end
    always
    #8 d=~d;
endmodule

module testShift();
    wire [1:0] q1;
    wire [1:0] q2;
    reg clock,d;
    shiftA s1(q1,clock,d);
    shiftB s2(q2,clock,d);
    always
        #10 clock=~clock;
    initial
    begin
        #0; 
        d=0;
        clock=0;
        #1000 $finish; 
    end
        always
        #8 d=~d;
endmodule
