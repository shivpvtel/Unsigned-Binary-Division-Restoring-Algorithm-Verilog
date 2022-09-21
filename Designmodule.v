Design module 


`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 02/05/2022 03:25:40 PM
// Design Name:
// Module Name: Divider
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
 
module Subtractor(
   input [16:0] a,
   input [16:0] b,
  
   output reg [16:0] s
   );
   always @(*) begin               
       s = a - b;
   end
endmodule
 
module AQmux(
   input [31:0] aq,
   input [31:0] qa,
   input start,
   output reg [31:0] aqaq
   );
   always@(*)
       begin
       if (start == 1)
       begin
           aqaq[31:0]= qa[31:0];
       end
       else begin
           aqaq[31:0]= aq[31:0];
       end
   end
endmodule
 
module SubtractorMux(
   input [15:0] r,
   input [16:0] b,
   output reg [15:0] regR
   );
   always@(*)
       begin
       if (b[16] == 1)
       begin //negative
           regR[15:0] = r[15:0];
       end else begin
           regR[15:0] = b[15:0];
       end
   end
endmodule
 
module Divider(
   input clk,
   input clear,
   input start,
   input [31:0] a,
   input [15:0] b,
  
   output reg [31:0] regQ,
   output reg [15:0] regR,
   output reg busy,
   output reg ready,
   output reg [4:0] counter
   );
  
   reg [15:0] regB;
   wire [16:0] subOut;
   wire [16:0] subA = {regR, regQ[31]};
   wire [16:0] subB = {1'b0, regB};
   wire [16:0] Remainder = {regR, regQ[31]};
   wire [16:0] SubtractorMuxOut;
   wire [31:0] qa = a;
   wire [31:0] realq = {regQ, 1'b0};
   wire [31:0] AQmuxOut;
   Subtractor sub(subA, subB, subOut);
   SubtractorMux mux(Remainder, subOut, SubtractorMuxOut);
   AQmux aqmux(qa, realq, start, AQmuxOut);
  
   always @(posedge clk)
   begin
       if (clear == 0)
       begin
           regB <=0;
           regQ <= 0;
           regR <= 0;
           ready <= 0;
           busy <= 0;
           counter <= 0;
       end
       else if (start ==1)
       begin
           regB <= b;
           regQ <= AQmuxOut;
           regR <= 0;
           ready <= 0;
           busy <= 1;
           counter <= 0;
       end
       else if (busy ==1)
       begin
           regB <=0;
           regQ <= AQmuxOut;
           regR <= SubtractorMuxOut;
           counter = counter + 1;
           if (counter == 31)
               begin
               ready <= 1;
               busy <= 0;
               end
       end
   end
endmodule
