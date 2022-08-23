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
    input wire[5:0]     opcode,
    input wire[4:0]     reg1_id,
    input wire[4:0]     reg2_id,
    input wire[31:0]    reg1_data,
    input wire[31:0]    reg2_data,
    
    output wire         reg_write,
    output wire[4:0]    w_addr,
    output wire[31:0]   w_data
    );
    wire addi, lui;
    assign opcode = instruction[31:26];
    assign addiu    = (opcode == `OP_ADDIU)     ? 1 : 0;
    assign lui      = (opcode == `OP_LUI)       ? 1 : 0;
    
    assign rs = (addiu) ? instruction[25:21] : `REG_NONE;
    assign rt = (addiu || lui) ? instruction[20:16] : `REG_NONE;
    assign reg_write = (addiu || lui) ? 1 : 0;
    
    assign w_addr = (addiu) ? reg2_id : `REG_NONE;
    
    wire [15:0] imm16;
    assign imm16 = instruction[15:0];
    
    wire [31:0] alu_out;
    wire [31:0] alu_in1;
    wire [31:0] alu_in2;
    wire [2:0]  alu_op;
    assign alu_op = (addiu) ? `ALU_ADD : `ALU_NONE;
    assign alu_in1 = (addiu) ? reg1_data : `ZERO;
    assign alu_in2 = (addiu) ? {16'b0, imm16} : `ZERO;
    
    simalu alu(
        .input_1(alu_in1),
        .input_2(alu_in2),
        .alu_op(alu_op),
        .alu_out(alu_out)
    );
    
    assign w_data = (addiu) ? alu_out : `ZERO;
    
endmodule
