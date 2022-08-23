`timescale 1ns / 1ps
`include "config.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/23 11:12:50
// Design Name: 
// Module Name: Program Counter
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


module simpc(
    input wire  clk,
    input wire  rst_n,
    input wire  [31:0] next_addr,
    
    output reg  [31:0] pc);
    always @(posedge clk) begin
        if (!rst_n) begin
            pc <= `REG_INITVAL;
        end
        else begin
            pc <= next_addr;
        end
    end
endmodule
