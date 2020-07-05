`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/18 10:45:00
// Design Name: 
// Module Name: sccomp_dataflow
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


module sccomp_dataflow(
    input clk_in,
    input reset,
    output [31:0] inst,
    output [31:0] pc,
    output [31:0] tmp1,
    output [31:0] t_alua,
    output [31:0] t_alub,
    output [31:0] t_ext16,
    output [15:0] t_immoffset,
    output [31:0] t_rfwdata
    );

    Top sccpu(
        .clk(clk_in),
        .i_rst(reset),
        .o_inst(inst),
        .o_pc(pc),
        .tmp1(tmp1),
        .t_alua(t_alua),
        .t_alub(t_alub),
        .t_ext16(t_ext16),
        .t_immoffset(t_immoffset),
        .t_rfwdata(t_rfwdata)
    );

endmodule
