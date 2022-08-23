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

wire[4:0] rs;
wire[4:0] rt;
wire requires_reg_write;
wire[2:0] alu_op;
wire[31:0] alu_out;

simcu simcontrol(
    .instruction(inst),
    .rs(rs),
    .rt(rt),
    .reg_write(requires_reg_write),
    .alu_op(alu_op)
);

wire[31:0] reg1_data;
wire[31:0] reg2_data;
wire[15:0] imm16;

assign imm16 = inst[15:0];

simalu alu(
    .input_1(reg1_data),
    .input_2({16'b0, imm16}),
    .alu_out(alu_out)
);

register_file simreg(
    .clk(clk),
    .reg1_addr(rs),
    .reg_write(requires_reg_write),
    .w_addr(rt),
    .w_data(alu_out),
    .reg1_data(reg1_data),
    .reg2_data(reg2_data)
);

endmodule