`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/15 16:49:40
// Design Name: 
// Module Name: EXT
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


module EXT #(
    parameter IWIDTH = 16
    )(
    input wire [IWIDTH-1:0] i_data,
    input wire i_signed,
    output wire [31:0] o_data
    );

    assign o_data[31:0] = (i_signed ? {{(32-IWIDTH){i_data[IWIDTH-1]}}, i_data[IWIDTH-1:0]} : {{(32-IWIDTH){1'b0}}, i_data[IWIDTH-1:0]});

endmodule
