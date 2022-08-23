`timescale 1ns / 1ps
`include "config.v"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/23 14:24:17
// Design Name: 
// Module Name: instruction_mem
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


module instruction_mem(
    input   wire[11:2]  inst_addr,
    output  wire[31:0]   instruction
    );
    reg[31:0] inst_mem[`PROGRAM_MAXSIZE - 1: 0];
    
    assign instruction = inst_mem[inst_addr];
endmodule
