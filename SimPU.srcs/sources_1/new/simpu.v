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

wire[5:0] opcode;
wire[4:0] reg1_id;
wire[4:0] reg2_id;

assign opcode = inst[31:26];
assign reg1_id = inst[25:21];
assign reg2_id = inst[20:16];

wire requires_reg_write;
wire[4:0] w_addr;
wire[31:0] w_data;

wire[31:0] reg1_data;
wire[31:0] reg2_data;
wire ok;

register_file simreg(
    .clk(clk),
    .reg1_addr(reg1_id),
    .reg2_addr(reg2_id),
    .reg_write(requires_reg_write),
    .w_addr(w_addr),
    .w_data(w_data),
    .reg1_data(reg1_data),
    .reg2_data(reg2_data),
    .write_ok(ok)
);

wire mem_write;
wire [11:2] mem_addr;
wire [31:0] mem_data;
wire [31:0] mem_write_data;

simmem mem(
    .clk(clk),
    .mem_write(mem_write),
    .mem_addr(mem_addr),
    .read_data(mem_data),
    .write_data(mem_write_data)
);

simcu simcontrol(
    .instruction(inst),
    .opcode(opcode),
    .reg1_id(reg1_id),
    .reg2_id(reg2_id),
    .reg1_data(reg1_data),
    .reg2_data(reg2_data),
    
    .reg_write(requires_reg_write),
    .w_addr(w_addr),
    .w_data(w_data),
    .write_ok(ok),
    
    .mem_write(mem_write),
    .mem_addr(mem_addr),
    .mem_data(mem_data),
    .mem_write_data(mem_write_data)
);

endmodule