`timescale 1ns/ 1ps

module simpu(
    input wire clk,
    input wire rst_n
);

wire[31:0] pc_addr;
wire[31:0] next_addr;

simpc pc(
    .clk(clk),
    .rst_n(rst_n),
    .next_addr(next_addr),
    .pc(pc_addr)
);

nextpc pc_control(
    .pc_addr(pc_addr),
    .next_pc(next_addr)
);

wire[31:0] inst;

instruction_mem simim(
    .inst_addr(pc_addr[11:2]),
    .instruction(inst)
);

endmodule