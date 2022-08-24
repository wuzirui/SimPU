`timescale 1ns / 1ps
`include "config.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/23 16:09:11
// Design Name: 
// Module Name: simalu
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


module simalu(
    input   wire        clk,
    input   wire[31:0]  input_1,
    input   wire[31:0]  input_2,
    input   wire[2:0]   alu_op,
    
    output  reg[31:0]  alu_out,
    output  reg        ok
    );
    always @(posedge clk) begin
        ok = 0;
        #3
        alu_out = (alu_op == `ALU_ADD) ? input_1 + input_2
                  : (alu_op == `ALU_OR) ? input_1 | input_2
                  : input_2;
        ok = 1;
    end
endmodule
