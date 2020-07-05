`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/14 10:57:53
// Design Name: 
// Module Name: PCReg
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


module PCReg(
    input wire clk,
    input wire [31:0] i_data,
    input wire i_rst,
    output wire [31:0] o_data
    );
    
    reg [31:0] reg_data;

    always @ (posedge clk or posedge i_rst)
    begin
        if(i_rst) reg_data <= 32'b0000_0000_0100_0000_0000_0000_0000_0000;
        else reg_data <= i_data;
    end

    assign o_data = reg_data;

endmodule
