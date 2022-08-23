`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2022/08/23 13:47:13
// Design Name: 
// Module Name: testbench
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


module testbench();
reg clk;
reg rst_n;
simpu cpu(clk, rst_n);

initial begin
    // Load instructions
    $readmemh("../../../../SimPU.resources/instructions.txt", cpu.simim.inst_mem);
//    // Load register initial values
//    $readmemh("../../../SimPU.resources/registers.txt", ZAN_TOP.ZAN_REG_FILE.gpr);
//    // Load memory data initial values
//    $readmemh("../../../SimPU.resources/data_memory.txt", ZAN_TOP.ZAN_DATA_MEM.dm);

    rst_n = 0;
    clk = 0;

    #30 rst_n = 1; // 30ns 时刻 CPU 开始运行
    #500 $stop;  // 500ns 时刻 CPU 停止
end

always
    #20 clk = ~clk; // 每隔 20ns 时钟信号 clk 翻转一次
endmodule
