`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/15 16:24:37
// Design Name: 
// Module Name: IRAM
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

module IRAM(
    input wire [10:0] i_addr,
    output wire [31:0] o_data
    );

    reg [31:0] instrMem[2047:0];

    initial
    begin
        $readmemh(`_MEM_FILE_NAME, instrMem);
    end

    assign o_data = instrMem[i_addr];

endmodule
