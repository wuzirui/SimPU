`define REG_INITVAL     32'h0
`define PROGRAM_MAXSIZE 1024
`define MEM_LENGTH      1024

`define OP_ADDIU        6'b001001
`define OP_ADDU         6'b000000
`define OP_ADD          6'b000000
`define OP_LUI          6'b001111
`define OP_ORI          6'b001101
`define OP_SW           6'b101011
`define OP_LW           6'b100011

`define REG_NONE        5'b11111

`define ALU_NONE        3'b000
`define ALU_ADD         3'b001
`define ALU_SUB         3'b010
`define ALU_OR          3'b011
`define ALU_AND         3'b100
`define ALU_NEG         3'b101

`define ZERO            32'b0