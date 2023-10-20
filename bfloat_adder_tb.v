`timescale 1ns / 1ps



module bfloat_adder_tb();
reg [15:0]a,b;
wire [15:0]c;

bfloat_adder DUT(a,b,c);
initial begin
$dumpfile("bfloat_adder_tb.vcd");
$dumpvars(0,bfloat_adder_tb);
a=16'b0100001000011000;
b=16'b0100000101010000;
#250 $finish;
end
endmodule
