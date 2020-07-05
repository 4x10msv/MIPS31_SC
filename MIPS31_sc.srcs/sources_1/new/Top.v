`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/14 10:39:18
// Design Name: 
// Module Name: Top
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

`include "parameter.vh"

module Top(
    input wire clk,
    input wire i_rst,
    output wire [31:0] o_inst,
    output wire [31:0] o_pc,
    output wire [31:0] tmp1,
    output wire [31:0] t_alua,
    output wire [31:0] t_alub,
    output wire [31:0] t_ext16,
    output wire [15:0] t_immoffset,
    output wire [31:0] t_rfwdata
    );

    /********************信号定义部分********************/

    //MUX输出信号
    wire [31:0] muxPcData;
    wire [4:0] muxRfWaddrData;
    wire [31:0] muxRfWdataData;
    wire [31:0] muxAluAData;
    wire [31:0] muxAluBData;

    //EXT输出信号
    wire [31:0] ext5Data;
    wire [31:0] ext16Data;
    wire [31:0] ext18Data;

    //NPC输出信号
    wire [31:0] npcData;

    //PC输出信号
    wire [31:0] pcData;

    //IRAM输出信号
    wire [31:0] iramData;
    wire [4:0] rs = iramData[25:21];
    wire [4:0] rt = iramData[20:16];
    wire [4:0] rd = iramData[15:11];
    wire [4:0] sa = iramData[10:6];
    wire [25:0] target = iramData[25:0];
    wire [15:0] imm_offset = iramData[15:0];
    wire [5:0] op = iramData[31:26];
    wire [5:0] funct = iramData[5:0];

    //RegFile输出信号
    wire [31:0] rfData0;
    wire [31:0] rfData1;

    //ControlUnit输出信号
    wire dram_ena;
    wire dram_we;
    wire rf_we;
    wire ext_s;
    wire [3:0] aluc;
    wire [1:0] mux_pc_c;
    wire [1:0] mux_rf_wdata_c;
    wire [1:0] mux_rf_waddr_c;
    wire [1:0] mux_alu_a_c;
    wire mux_alu_b_c;

    //ADD输出信号
    wire [31:0] addData;

    //ALU输出信号
    wire [31:0] aluData;
    wire alu_Z;
    wire alu_C;
    wire alu_N;
    wire alu_O;

    //转移地址
    wire [31:0] extPcAddr = {pcData[31:28], target, 2'b0}; 

    //DRAM输出信号
    wire [31:0] dramData;

    /*******************模块实例化部分*******************/

    NPC npc(
        .i_curAddr(pcData),
        .o_nextAddr(npcData)
    );

    MUX4 #(
        .WIDTH(32)
    )muxPc(
        .i_data_0(rfData0),
        .i_data_1(extPcAddr),
        .i_data_2(npcData),
        .i_data_3(addData),
        .i_mux_c(mux_pc_c),
        .o_data(muxPcData)
    );

    PCReg pc(
        .clk(clk),
        .i_data(muxPcData),
        .i_rst(i_rst),
        .o_data(pcData)
    );

    `ifdef _USE_IPCORE
    IPIRAM iram(
        .a(pcData[12:2]),
        .spo(iramData)
    );
    `else
    IRAM iram(
        .i_addr(pcData[12:2]),
        .o_data(iramData)
    );
    `endif

    ControlUnit conUnit(
        .i_op(op),
        .i_funct(funct),
        .i_alu_o(alu_O),
        .i_alu_z(alu_Z),
        .o_dram_ena(dram_ena),
        .o_dram_we(dram_we),
        .o_rf_we(rf_we),
        .o_ext_s(ext_s),
        .o_aluc(aluc),
        .o_mux_pc_c(mux_pc_c),
        .o_mux_rf_wdata_c(mux_rf_wdata_c),
        .o_mux_rf_waddr_c(mux_rf_waddr_c),
        .o_mux_alu_a_c(mux_alu_a_c),
        .o_mux_alu_b_c(mux_alu_b_c)
    );

    MUX4 #(
        .WIDTH(5)
    )muxRfWaddr(
        .i_data_0(rd),
        .i_data_1(rt),
        .i_data_2(5'b11111),
        .i_data_3(5'b0),
        .i_mux_c(mux_rf_waddr_c),
        .o_data(muxRfWaddrData)
    );

    MUX4 #(
        .WIDTH(32)
    )muxRfWdata(
        .i_data_0(dramData),
        .i_data_1(aluData),
        .i_data_2(npcData),
        .i_data_3(32'b0),
        .i_mux_c(mux_rf_wdata_c),
        .o_data(muxRfWdataData)
    );

    RegFiles cpu_ref(
        .clk(clk),
        .i_rst(i_rst),
        .i_we(rf_we),
        .i_raddr0(rs),
        .i_raddr1(rt),
        .i_waddr(muxRfWaddrData),
        .i_wdata(muxRfWdataData),
        .o_rdata0(rfData0),
        .o_rdata1(rfData1)
    );

    EXT #(
        .IWIDTH(5)
    )ext5(
        .i_data(sa),
        .i_signed(ext_s),
        .o_data(ext5Data)
    );

    EXT #(
        .IWIDTH(16)
    )ext16(
        .i_data(imm_offset),
        .i_signed(ext_s),
        .o_data(ext16Data)
    );

    EXT #(
        .IWIDTH(18)
    )ext18(
        .i_data({imm_offset, 2'b0}),
        .i_signed(ext_s),
        .o_data(ext18Data)
    );

    ADD addIns(
        .i_data_0(npcData),
        .i_data_1(ext18Data),
        .o_data(addData)
    );

    MUX4 #(
        .WIDTH(32)
    )muxAluA(
        .i_data_0(ext5Data),
        .i_data_1(rfData0),
        .i_data_2(32'b10000),
        .i_data_3(32'b0),
        .i_mux_c(mux_alu_a_c),
        .o_data(muxAluAData)
    );

    MUX2 muxAluB(
        .i_data_0(rfData1),
        .i_data_1(ext16Data),
        .i_mux_c(mux_alu_b_c),
        .o_data(muxAluBData)
    );

    ALU alu(
        .a(muxAluAData),
        .b(muxAluBData),
        .aluc(aluc),
        .r(aluData),
        .zero(alu_Z),
        .carry(alu_C),
        .negative(alu_N),
        .overflow(alu_O)
    );

    DRAM dram(
        .clk(clk),
        .i_we(dram_we),
        .i_addr(aluData[10:0]),
        .i_data(rfData1),
        .o_data(dramData)
    ); 

    /**************************************************/
    assign o_inst = iramData;
    assign o_pc = pcData;

    assign tmp1 = aluData;
    assign t_alua = muxAluAData;
    assign t_alub = muxAluBData;
    assign t_ext16 = ext16Data;
    assign t_immoffset = imm_offset;
    assign t_rfwdata = muxRfWdataData;

endmodule
