`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 02/05/2022 03:21:50 PM
// Design Name: 
// Module Name: testbench
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


module testbench();
    reg clear_tb;
    reg start_tb;
    reg clk_tb;
    reg [31:0] a_tb;
    reg [15:0] b_tb;
    wire [31:0] q_tb;
    wire [15:0] r_tb;
    wire busy_tb;
    wire ready_tb;
    wire [4:0] counter_tb;
    initial begin
        clear_tb <= 0;
        start_tb <= 0;
        clk_tb <= 1;
        assign a_tb = 33'h0x4c7f228a;
        assign b_tb = 17'h0x6a0e;
        #5
        start_tb <=1;
        clear_tb <=1;
        #10
        start_tb <=0;
        end
        Divider Divider_tb(clk_tb, clear_tb, start_tb, a_tb, b_tb, q_tb, r_tb, busy_tb, ready_tb, counter_tb);
        always begin
            #5;
            clk_tb = ~clk_tb;
        end
endmodule

