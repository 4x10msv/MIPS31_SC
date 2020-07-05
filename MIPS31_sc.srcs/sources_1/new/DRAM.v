`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/15 16:42:01
// Design Name: 
// Module Name: DRAM
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


module DRAM(
    input wire clk,
    input wire i_we,
    input wire [10:0] i_addr,
    input wire [31:0] i_data,
    output wire [31:0] o_data
    );

    reg [31:0] dataMem[2047:0];

    initial
    begin
    end

    always @ (posedge clk)
    begin
        if(i_we)
        begin
            dataMem[i_addr] <= i_data;
        end
    end

    assign o_data = dataMem[i_addr];

endmodule
