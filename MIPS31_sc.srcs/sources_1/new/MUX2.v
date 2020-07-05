`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/14 11:46:17
// Design Name: 
// Module Name: MUX2
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


module MUX2(
    input wire [31:0] i_data_0,
    input wire [31:0] i_data_1,
    input wire i_mux_c,
    output wire [31:0] o_data
    );

    assign o_data = (i_mux_c ? i_data_1 : i_data_0);
    
endmodule
