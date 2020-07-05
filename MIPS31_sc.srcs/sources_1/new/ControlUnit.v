`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/14 14:12:46
// Design Name: 
// Module Name: ControlUnit
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

module ControlUnit(
    input wire [5:0] i_op,
    input wire [5:0] i_funct,
    input wire i_alu_o,
    input wire i_alu_z,
    output wire o_dram_ena,
    output wire o_dram_we,
    output wire o_rf_we,
    output wire o_ext_s,
    output wire [3:0] o_aluc,
    output wire [1:0] o_mux_pc_c,
    output wire [1:0] o_mux_rf_wdata_c,
    output wire [1:0] o_mux_rf_waddr_c,
    output wire [1:0] o_mux_alu_a_c,
    output wire o_mux_alu_b_c
    );

    reg reg_dram_ena;
    reg reg_dram_we;
    reg reg_rf_we;
    reg reg_ext_s;
    reg [3:0] reg_aluc;
    reg [1:0] reg_mux_pc_c;
    reg [1:0] reg_mux_rf_wdata_c;
    reg [1:0] reg_mux_rf_waddr_c;
    reg [1:0] reg_mux_alu_a_c;
    reg reg_mux_alu_b_c;

    always @ (*)
    begin
        case(i_op)
            `CTRL_OP_RTYPE:
            begin
                case(i_funct)
                    `CTRL_FUNCT_ADD:
                    begin
                        reg_dram_ena = 0;
                        reg_dram_we = 0;
                        reg_rf_we = ~i_alu_o;
                        reg_ext_s = 0;
                        reg_aluc = `ALUOP_ADD;
                        reg_mux_pc_c = 2'b10;
                        reg_mux_rf_wdata_c = 2'b01;
                        reg_mux_rf_waddr_c = 2'b00;
                        reg_mux_alu_a_c = 2'b01;
                        reg_mux_alu_b_c = 0;
                    end
                    `CTRL_FUNCT_ADDU:
                    begin
                        reg_dram_ena = 0;
                        reg_dram_we = 0;
                        reg_rf_we = 1;
                        reg_ext_s = 0;
                        reg_aluc = `ALUOP_ADDU;
                        reg_mux_pc_c = 2'b10;
                        reg_mux_rf_wdata_c = 2'b01;
                        reg_mux_rf_waddr_c = 2'b00;
                        reg_mux_alu_a_c = 2'b01;
                        reg_mux_alu_b_c = 0;
                    end
                    `CTRL_FUNCT_SUB:
                    begin
                        reg_dram_ena = 0;
                        reg_dram_we = 0;
                        reg_rf_we = ~i_alu_o;
                        reg_ext_s = 0;
                        reg_aluc = `ALUOP_SUB;
                        reg_mux_pc_c = 2'b10;
                        reg_mux_rf_wdata_c = 2'b01;
                        reg_mux_rf_waddr_c = 2'b00;
                        reg_mux_alu_a_c = 2'b01;
                        reg_mux_alu_b_c = 0;
                    end
                    `CTRL_FUNCT_SUBU:
                    begin
                        reg_dram_ena = 0;
                        reg_dram_we = 0;
                        reg_rf_we = 1;
                        reg_ext_s = 0;
                        reg_aluc = `ALUOP_SUBU;
                        reg_mux_pc_c = 2'b10;
                        reg_mux_rf_wdata_c = 2'b01;
                        reg_mux_rf_waddr_c = 2'b00;
                        reg_mux_alu_a_c = 2'b01;
                        reg_mux_alu_b_c = 0;
                    end
                    `CTRL_FUNCT_AND:
                    begin
                        reg_dram_ena = 0;
                        reg_dram_we = 0;
                        reg_rf_we = 1;
                        reg_ext_s = 0;
                        reg_aluc = `ALUOP_AND;
                        reg_mux_pc_c = 2'b10;
                        reg_mux_rf_wdata_c = 2'b01;
                        reg_mux_rf_waddr_c = 2'b00;
                        reg_mux_alu_a_c = 2'b01;
                        reg_mux_alu_b_c = 0;
                    end
                    `CTRL_FUNCT_OR:
                    begin
                        reg_dram_ena = 0;
                        reg_dram_we = 0;
                        reg_rf_we = 1;
                        reg_ext_s = 0;
                        reg_aluc = `ALUOP_OR;
                        reg_mux_pc_c = 2'b10;
                        reg_mux_rf_wdata_c = 2'b01;
                        reg_mux_rf_waddr_c = 2'b00;
                        reg_mux_alu_a_c = 2'b01;
                        reg_mux_alu_b_c = 0;
                    end
                    `CTRL_FUNCT_XOR:
                    begin
                        reg_dram_ena = 0;
                        reg_dram_we = 0;
                        reg_rf_we = 1;
                        reg_ext_s = 0;
                        reg_aluc = `ALUOP_XOR;
                        reg_mux_pc_c = 2'b10;
                        reg_mux_rf_wdata_c = 2'b01;
                        reg_mux_rf_waddr_c = 2'b00;
                        reg_mux_alu_a_c = 2'b01;
                        reg_mux_alu_b_c = 0;
                    end
                    `CTRL_FUNCT_NOR:
                    begin
                        reg_dram_ena = 0;
                        reg_dram_we = 0;
                        reg_rf_we = 1;
                        reg_ext_s = 0;
                        reg_aluc = `ALUOP_NOR;
                        reg_mux_pc_c = 2'b10;
                        reg_mux_rf_wdata_c = 2'b01;
                        reg_mux_rf_waddr_c = 2'b00;
                        reg_mux_alu_a_c = 2'b01;
                        reg_mux_alu_b_c = 0;
                    end
                    `CTRL_FUNCT_SLT:
                    begin
                        reg_dram_ena = 0;
                        reg_dram_we = 0;
                        reg_rf_we = 1;
                        reg_ext_s = 0;
                        reg_aluc = `ALUOP_SLT;
                        reg_mux_pc_c = 2'b10;
                        reg_mux_rf_wdata_c = 2'b01;
                        reg_mux_rf_waddr_c = 2'b00;
                        reg_mux_alu_a_c = 2'b01;
                        reg_mux_alu_b_c = 0;
                    end
                    `CTRL_FUNCT_SLTU:
                    begin
                        reg_dram_ena = 0;
                        reg_dram_we = 0;
                        reg_rf_we = 1;
                        reg_ext_s = 0;
                        reg_aluc = `ALUOP_SLTU;
                        reg_mux_pc_c = 2'b10;
                        reg_mux_rf_wdata_c = 2'b01;
                        reg_mux_rf_waddr_c = 2'b00;
                        reg_mux_alu_a_c = 2'b01;
                        reg_mux_alu_b_c = 0;
                    end
                    `CTRL_FUNCT_SLL:
                    begin
                        reg_dram_ena = 0;
                        reg_dram_we = 0;
                        reg_rf_we = 1;
                        reg_ext_s = 0;
                        reg_aluc = `ALUOP_SLL_SLA;
                        reg_mux_pc_c = 2'b10;
                        reg_mux_rf_wdata_c = 2'b01;
                        reg_mux_rf_waddr_c = 2'b00;
                        reg_mux_alu_a_c = 2'b00;
                        reg_mux_alu_b_c = 0;
                    end
                    `CTRL_FUNCT_SRL:
                    begin
                        reg_dram_ena = 0;
                        reg_dram_we = 0;
                        reg_rf_we = 1;
                        reg_ext_s = 0;
                        reg_aluc = `ALUOP_SRL;
                        reg_mux_pc_c = 2'b10;
                        reg_mux_rf_wdata_c = 2'b01;
                        reg_mux_rf_waddr_c = 2'b00;
                        reg_mux_alu_a_c = 2'b00;
                        reg_mux_alu_b_c = 0;
                    end
                    `CTRL_FUNCT_SRA:
                    begin
                        reg_dram_ena = 0;
                        reg_dram_we = 0;
                        reg_rf_we = 1;
                        reg_ext_s = 0;
                        reg_aluc = `ALUOP_SRA;
                        reg_mux_pc_c = 2'b10;
                        reg_mux_rf_wdata_c = 2'b01;
                        reg_mux_rf_waddr_c = 2'b00;
                        reg_mux_alu_a_c = 2'b00;
                        reg_mux_alu_b_c = 0;
                    end
                    `CTRL_FUNCT_SLLV:
                    begin
                        reg_dram_ena = 0;
                        reg_dram_we = 0;
                        reg_rf_we = 1;
                        reg_ext_s = 0;
                        reg_aluc = `ALUOP_SLL_SLA;
                        reg_mux_pc_c = 2'b10;
                        reg_mux_rf_wdata_c = 2'b01;
                        reg_mux_rf_waddr_c = 2'b00;
                        reg_mux_alu_a_c = 2'b01;
                        reg_mux_alu_b_c = 0;
                    end
                    `CTRL_FUNCT_SRLV:
                    begin
                        reg_dram_ena = 0;
                        reg_dram_we = 0;
                        reg_rf_we = 1;
                        reg_ext_s = 0;
                        reg_aluc = `ALUOP_SRL;
                        reg_mux_pc_c = 2'b10;
                        reg_mux_rf_wdata_c = 2'b01;
                        reg_mux_rf_waddr_c = 2'b00;
                        reg_mux_alu_a_c = 2'b01;
                        reg_mux_alu_b_c = 0;
                    end
                    `CTRL_FUNCT_SRAV:
                    begin
                        reg_dram_ena = 0;
                        reg_dram_we = 0;
                        reg_rf_we = 1;
                        reg_ext_s = 0;
                        reg_aluc = `ALUOP_SRA;
                        reg_mux_pc_c = 2'b10;
                        reg_mux_rf_wdata_c = 2'b01;
                        reg_mux_rf_waddr_c = 2'b00;
                        reg_mux_alu_a_c = 2'b01;
                        reg_mux_alu_b_c = 0;
                    end
                    `CTRL_FUNCT_JR:
                    begin
                        reg_dram_ena = 0;
                        reg_dram_we = 0;
                        reg_rf_we = 0;
                        reg_ext_s = 0;
                        reg_aluc = 4'b0000;
                        reg_mux_pc_c = 2'b00;
                        reg_mux_rf_wdata_c = 2'b00;
                        reg_mux_rf_waddr_c = 2'b00;
                        reg_mux_alu_a_c = 2'b00;
                        reg_mux_alu_b_c = 0;
                    end
                    default:
                    begin
                    end
                endcase
            end
            `CTRL_OP_ADDI:
            begin
                reg_dram_ena = 0;
                reg_dram_we = 0;
                reg_rf_we = ~i_alu_o;
                reg_ext_s = 1;
                reg_aluc = `ALUOP_ADD;
                reg_mux_pc_c = 2'b10;
                reg_mux_rf_wdata_c = 2'b01;
                reg_mux_rf_waddr_c = 2'b01;
                reg_mux_alu_a_c = 2'b01;
                reg_mux_alu_b_c = 1;
            end
            `CTRL_OP_ADDIU:
            begin
                reg_dram_ena = 0;
                reg_dram_we = 0;
                reg_rf_we = 1;
                reg_ext_s = 1;
                reg_aluc = `ALUOP_ADDU;
                reg_mux_pc_c = 2'b10;
                reg_mux_rf_wdata_c = 2'b01;
                reg_mux_rf_waddr_c = 2'b01;
                reg_mux_alu_a_c = 2'b01;
                reg_mux_alu_b_c = 1;
            end
            `CTRL_OP_ANDI:
            begin
                reg_dram_ena = 0;
                reg_dram_we = 0;
                reg_rf_we = 1;
                reg_ext_s = 0;
                reg_aluc = `ALUOP_AND;
                reg_mux_pc_c = 2'b10;
                reg_mux_rf_wdata_c = 2'b01;
                reg_mux_rf_waddr_c = 2'b01;
                reg_mux_alu_a_c = 2'b01;
                reg_mux_alu_b_c = 1;
            end
            `CTRL_OP_ORI:
            begin
                reg_dram_ena = 0;
                reg_dram_we = 0;
                reg_rf_we = 1;
                reg_ext_s = 0;
                reg_aluc = `ALUOP_OR;
                reg_mux_pc_c = 2'b10;
                reg_mux_rf_wdata_c = 2'b01;
                reg_mux_rf_waddr_c = 2'b01;
                reg_mux_alu_a_c = 2'b01;
                reg_mux_alu_b_c = 1;
            end
            `CTRL_OP_XORI:
            begin
                reg_dram_ena = 0;
                reg_dram_we = 0;
                reg_rf_we = 1;
                reg_ext_s = 0;
                reg_aluc = `ALUOP_XOR;
                reg_mux_pc_c = 2'b10;
                reg_mux_rf_wdata_c = 2'b01;
                reg_mux_rf_waddr_c = 2'b01;
                reg_mux_alu_a_c = 2'b01;
                reg_mux_alu_b_c = 1;
            end
            `CTRL_OP_LW:
            begin
                reg_dram_ena = 1;
                reg_dram_we = 0;
                reg_rf_we = 1;
                reg_ext_s = 1;
                reg_aluc = `ALUOP_ADD;
                reg_mux_pc_c = 2'b10;
                reg_mux_rf_wdata_c = 2'b00;
                reg_mux_rf_waddr_c = 2'b01;
                reg_mux_alu_a_c = 2'b01;
                reg_mux_alu_b_c = 1;
            end
            `CTRL_OP_SW:
            begin
                reg_dram_ena = 1;
                reg_dram_we = 1;
                reg_rf_we = 0;
                reg_ext_s = 1;
                reg_aluc = `ALUOP_ADD;
                reg_mux_pc_c = 2'b10;
                reg_mux_rf_wdata_c = 2'b00;
                reg_mux_rf_waddr_c = 2'b00;
                reg_mux_alu_a_c = 2'b01;
                reg_mux_alu_b_c = 1;
            end
            `CTRL_OP_BEQ:
            begin
                reg_dram_ena = 0;
                reg_dram_we = 0;
                reg_rf_we = 0;
                reg_ext_s = 1;
                reg_aluc = `ALUOP_SUB;
                reg_mux_pc_c = (i_alu_z ? 2'b11 : 2'b10);
                reg_mux_rf_wdata_c = 2'b00;
                reg_mux_rf_waddr_c = 2'b00;
                reg_mux_alu_a_c = 2'b01;
                reg_mux_alu_b_c = 0;
            end
            `CTRL_OP_BNE:
            begin
                reg_dram_ena = 0;
                reg_dram_we = 0;
                reg_rf_we = 0;
                reg_ext_s = 1;
                reg_aluc = `ALUOP_SUB;
                reg_mux_pc_c = (i_alu_z ? 2'b10 : 2'b11);
                reg_mux_rf_wdata_c = 2'b00;
                reg_mux_rf_waddr_c = 2'b00;
                reg_mux_alu_a_c = 2'b01;
                reg_mux_alu_b_c = 0;
            end
            `CTRL_OP_SLTI:
            begin
                reg_dram_ena = 0;
                reg_dram_we = 0;
                reg_rf_we = 1;
                reg_ext_s = 1;
                reg_aluc = `ALUOP_SLT;
                reg_mux_pc_c = 2'b10;
                reg_mux_rf_wdata_c = 2'b01;
                reg_mux_rf_waddr_c = 2'b01;
                reg_mux_alu_a_c = 2'b01;
                reg_mux_alu_b_c = 1;
            end
            `CTRL_OP_SLTIU:
            begin
                reg_dram_ena = 0;
                reg_dram_we = 0;
                reg_rf_we = 1;
                reg_ext_s = 1;
                reg_aluc = `ALUOP_SLTU;
                reg_mux_pc_c = 2'b10;
                reg_mux_rf_wdata_c = 2'b01;
                reg_mux_rf_waddr_c = 2'b01;
                reg_mux_alu_a_c = 2'b01;
                reg_mux_alu_b_c = 1;
            end
            `CTRL_OP_LUI:
            begin
                reg_dram_ena = 0;
                reg_dram_we = 0;
                reg_rf_we = 1;
                reg_ext_s = 0;
                reg_aluc = `ALUOP_SLL_SLA;
                reg_mux_pc_c = 2'b10;
                reg_mux_rf_wdata_c = 2'b01;
                reg_mux_rf_waddr_c = 2'b01;
                reg_mux_alu_a_c = 2'b10;
                reg_mux_alu_b_c = 1;
            end
            `CTRL_OP_J:
            begin
                reg_dram_ena = 0;
                reg_dram_we = 0;
                reg_rf_we = 0;
                reg_ext_s = 0;
                reg_aluc = 4'b0000;
                reg_mux_pc_c = 2'b01;
                reg_mux_rf_wdata_c = 2'b00;
                reg_mux_rf_waddr_c = 2'b00;
                reg_mux_alu_a_c = 2'b00;
                reg_mux_alu_b_c = 0;
            end
            `CTRL_OP_JAL:
            begin
                reg_dram_ena = 0;
                reg_dram_we = 0;
                reg_rf_we = 1;
                reg_ext_s = 0;
                reg_aluc = 4'b0000;
                reg_mux_pc_c = 2'b01;
                reg_mux_rf_wdata_c = 2'b10;
                reg_mux_rf_waddr_c = 2'b10;
                reg_mux_alu_a_c = 2'b00;
                reg_mux_alu_b_c = 0;
            end
            default:
            begin
            end
        endcase
    end

    assign o_dram_ena = reg_dram_ena;
    assign o_dram_we = reg_dram_we;
    assign o_rf_we = reg_rf_we;
    assign o_ext_s = reg_ext_s;
    assign o_aluc = reg_aluc;
    assign o_mux_pc_c = reg_mux_pc_c;
    assign o_mux_rf_wdata_c = reg_mux_rf_wdata_c;
    assign o_mux_rf_waddr_c = reg_mux_rf_waddr_c;
    assign o_mux_alu_a_c = reg_mux_alu_a_c;
    assign o_mux_alu_b_c = reg_mux_alu_b_c;

endmodule
