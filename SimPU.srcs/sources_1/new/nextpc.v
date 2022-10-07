`timescale 1ns / 1ps
`include "config.v"

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/23 13:17:36
// Design Name: 
// Module Name: nextpc
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


module nextpc(
    input wire [31:0]   pc_addr,
    input wire [31:0]   inst,
    input wire [31:0]   reg_addr,
    input wire flag,
    output reg [31:0]   next_pc
    );
    wire [31:0] pc_off4;
    wire [5:0] opcode;
    wire [5:0] func;
    assign opcode = inst[31:26];
    assign func = inst[5:0];
    
    assign j = (opcode == `OP_J) ? 1 : 0;
    assign jr = (opcode == `OP_JR && func == `FUNC_JR) ? 1 : 0; 
    assign beq = (opcode == `OP_BEQ) ? 1 : 0;
    
    assign pc_off4 = pc_addr + 4;
    
    always @(*) begin
        if (j) begin
            next_pc <= {pc_off4[31:28], inst[25:0], 2'b0};
        end
        else begin
            if (jr) begin
                next_pc <= reg_addr;
            end
            else begin
                if (beq) begin
                    next_pc <= flag ? pc_addr + inst[15:0] : pc_off4;                    
                end else begin
                    next_pc <= pc_off4;
                end
            end
        end
    end
endmodule
