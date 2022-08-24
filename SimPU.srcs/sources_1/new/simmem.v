`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/24 00:07:53
// Design Name: 
// Module Name: simmem
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


module simmem(
    input   wire            clk,
    input   wire            mem_write,
    input   wire    [11:2]  mem_addr,
    input   wire    [31:0]  write_data,
    input   wire            write_ok,
    output  wire    [31:0]  read_data
    );
    
    reg[31:0] mem[`MEM_LENGTH - 1 : 0];
    assign read_data = mem[mem_addr];
    
    always @(*) begin
        if (mem_write && write_ok) begin
            mem[mem_addr] <= write_data;
        end
    end
endmodule
