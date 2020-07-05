`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/15 09:45:06
// Design Name: 
// Module Name: RegFiles
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

module RegFiles(
    input wire clk,
    input wire i_rst,
    input wire i_we,
    input wire [4:0] i_raddr0,
    input wire [4:0] i_raddr1,
    input wire [4:0] i_waddr,
    input wire [31:0] i_wdata,
    output wire [31:0] o_rdata0,
    output wire [31:0] o_rdata1
    );

    reg [31:0] array_reg[31:0];
    integer i;

    `ifdef _MARS_DEBUG
    always @ (negedge clk or posedge i_rst)
    begin
        if(i_rst)
        begin
            for(i = 0; i < 32; i = i + 1)
                array_reg[i] <= 32'b0;
        end
        else if(i_we && i_waddr != 5'b0)
            array_reg[i_waddr] <= i_wdata;
    end
    `else
    always @ (posedge clk or posedge i_rst)
    begin
        if(i_rst)
        begin
            for(i = 0; i < 32; i = i + 1)
                array_reg[i] <= 32'b0;
        end
        else if(i_we && i_waddr != 5'b0)
            array_reg[i_waddr] <= i_wdata;
    end
    `endif

    assign o_rdata0 = (i_raddr0 == 5'b0 ? 32'b0 : array_reg[i_raddr0]);
    assign o_rdata1 = (i_raddr1 == 5'b0 ? 32'b0 : array_reg[i_raddr1]);

endmodule
