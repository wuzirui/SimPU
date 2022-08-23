`timescale 1ns / 1ps
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
    input wire [31:26]  inst_opcode,
    input wire [31:0]   inst_offset,
    output reg [31:0]  next_pc
    );
    wire [31:0] pc_off4;
    assign pc_off4 = pc_addr + 4;
    
    always @(*) begin
        next_pc <= pc_off4;
    end
endmodule
