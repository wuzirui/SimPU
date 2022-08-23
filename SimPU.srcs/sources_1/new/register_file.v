`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/23 15:54:11
// Design Name: 
// Module Name: register_file
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


module register_file(
    input   wire        clk,
    input   wire        reg_write,
    input   wire[4:0]   reg1_addr,
    input   wire[4:0]   reg2_addr,
    
    input   wire[4:0]   w_addr,
    input   wire[31:0]  w_data,
    input   wire        write_ok,
    
    output  wire[31:0]  reg1_data,
    output  wire[31:0]  reg2_data
    );
    reg[31:0] gpr[31:0];
    
    assign reg1_data = gpr[reg1_addr];
    assign reg2_data = gpr[reg2_addr];
    
    always @(*) begin
        if (reg_write && write_ok) begin
            gpr[w_addr] <= w_data;
        end
    end
endmodule
