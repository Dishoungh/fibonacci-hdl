`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2023 12:56:59 AM
// Design Name: 
// Module Name: fib_tb
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


module fib_tb;

reg clk;
reg rst;
wire[31:0] out;



fibonacci uut
(
    .clk(clk),
    .rst(rst),
    .out(out)
);

initial
    begin
        #0
        clk = 1'b0;
        rst = 1'b1;
        
        #10
        rst = 1'b0;
        
        #2500
        rst = 1'b1;
        
        #50
        rst = 1'b0;
        
        #2500
        $finish;
    end

always
    #5 clk = ~clk;

endmodule
