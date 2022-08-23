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
    output wire[31:0]   w_data,
    output reg         write_ok
    );
    wire addiu, lui, addu, ori;
    assign opcode = instruction[31:26];
    assign addiu    = (opcode == `OP_ADDIU) ? 1 : 0;
    assign lui      = (opcode == `OP_LUI) ? 1 : 0;
    assign addu     = (opcode == `OP_ADDU && instruction[10:0] == 10'b100001) ? 1 : 0;
    assign ori      = (opcode == `OP_ORI) ? 1 : 0;
    
    wire [4:0] rd;
    assign rd = instruction[15:11];
    
    wire [15:0] imm16;
    assign imm16 = instruction[15:0];
    
    wire [31:0] alu_out;
    wire [31:0] alu_in1;
    wire [31:0] alu_in2;
    wire [2:0]  alu_op;
    assign alu_op = (addiu || addu) ? `ALU_ADD
                    : (ori) ? `ALU_OR
                    : `ALU_NONE;
    assign alu_in1 = (addiu || addu || ori) ? reg1_data
                    : `ZERO;
    assign alu_in2 = (addiu || ori) ? {16'b0, imm16}
                    : (addu) ? reg2_data
                    : `ZERO;
    wire alu_ok;
    simalu alu(
        .input_1(alu_in1),
        .input_2(alu_in2),
        .alu_op(alu_op),
        .alu_out(alu_out),
        .ok(alu_ok)
    );
//    assign write_ok = (alu_op == `ALU_NONE) ? 1 : alu_ok;
    always @(alu_ok) begin
        write_ok <= (alu_op == `ALU_NONE) ? 1 : alu_ok;
    end
    assign reg_write = (addiu || lui || addu || ori) ? 1 : 0;
    
    assign w_addr = (addiu || lui || ori) ? reg2_id 
                    : (addu) ? rd
                    : `REG_NONE;
    assign w_data = (addiu || addu || ori) ? alu_out
                    : (lui) ? {imm16, 16'b0}
                    : `ZERO;
    
endmodule
