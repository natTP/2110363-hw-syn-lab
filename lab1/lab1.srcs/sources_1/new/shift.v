`timescale 1ns / 1ns

module shiftA(q,clock,d);
output [1:0] q;
input clock,d;

reg [1:0] q;

always @(posedge clock)
begin
    q[0]=d;
    q[1]=q[0];
end
endmodule

module shiftB(q,clock,d);
output [1:0] q;
input clock,d;

reg [1:0] q;

always @(posedge clock)
begin
    q[0]<=d;
    q[1]<=q[0];
end
endmodule

//module shiftN(q,clock,d);
//    output [N-1:0] q;
//    input clock,d;
    
//    parameter N;
    
//    reg [N-1:0] q;
    
//    always @(posedge clock)
//    begin
//        q[0]<=d;
//        q[N-1:1]<=q[N-2:0];
//    end
//endmodule