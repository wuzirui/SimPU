`timescale 1ns / 1ps
`include "config.v"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/23 15:03:53
// Design Name: 
// Module Name: simcu
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


module simcu(
    input wire[31:0]    instruction,
    output wire[4:0]    rs,
    output wire[4:0]    rt,
    output wire         reg_write,
    output wire[2:0]    alu_op
    );
    wire [5:0] opcode;
    wire addi;
    assign opcode = instruction[31:26];
    assign addiu    = (opcode == `OP_ADDIU)   ? 1 : 0;
    
    assign rs = (addiu) ? instruction[25:21] : `REG_NONE;
    assign rt = (addiu) ? instruction[20:16] : `REG_NONE;
    assign reg_write = (addiu) ? 1 : 0;
    assign alu_op = (addiu) ? `ALU_ADD : `ALU_NONE;
endmodule
