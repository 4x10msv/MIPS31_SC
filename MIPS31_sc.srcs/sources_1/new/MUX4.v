`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/14 11:48:32
// Design Name: 
// Module Name: MUX4
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


module MUX4 #(
    parameter WIDTH = 32
    )(
    input wire [WIDTH-1:0] i_data_0,
    input wire [WIDTH-1:0] i_data_1,
    input wire [WIDTH-1:0] i_data_2,
    input wire [WIDTH-1:0] i_data_3,
    input wire [1:0] i_mux_c,
    output wire [WIDTH-1:0] o_data
    );

    assign o_data = (i_mux_c == 2'b00 ? i_data_0 : (i_mux_c == 2'b01 ? i_data_1 : (i_mux_c == 2'b10 ? i_data_2 : i_data_3)));

endmodule
