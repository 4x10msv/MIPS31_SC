`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2020/06/14 10:40:08
// Design Name: 
// Module Name: ALU
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

module ALU(
    input wire [31:0] a,
    input wire [31:0] b,
    input wire [3:0] aluc,
    output wire [31:0] r,
    output wire zero,
    output wire carry,
    output wire negative,
    output wire overflow
    );
    

    reg Z, C, N, O;
    reg [32:0] rsl;
    
    always @ *
        begin
            case(aluc)
                `ALUOP_ADDU:
                    begin
                        rsl = a + b;
                        Z = (rsl[31:0] == 32'b0 ? 1'b1 : 1'b0);
                        C = rsl[32];
                        N = rsl[31];
                    end
                `ALUOP_ADD:
                    begin
                        rsl = a + b;
                        Z = (rsl[31:0] == 32'b0 ? 1'b1 : 1'b0);
                        N = rsl[31];
                        if($signed(a) > 0 && $signed(b) > 0 && $signed(rsl[31:0]) < 0) O = 1;
                        else if($signed(a) < 0 && $signed(b) < 0 && $signed(rsl[31:0]) > 0) O = 1;
                        else O = 0;
                    end
                `ALUOP_SUBU:
                    begin
                        rsl = a - b;
                        Z = (rsl[31:0] == 32'b0 ? 1'b1 : 1'b0);
                        C = rsl[32];
                        N = rsl[31];
                    end
                `ALUOP_SUB:
                    begin
                        rsl = a - b;
                        Z = (rsl[31:0] == 32'b0 ? 1'b1 : 1'b0);
                        N = rsl[31];
                        if($signed(a) > 0 && $signed(b) < 0 && $signed(rsl[31:0]) < 0) O = 1;
                        else if($signed(a) < 0 && $signed(b) > 0 && $signed(rsl[31:0]) > 0) O = 1;
                        else O = 0;
                    end
                `ALUOP_AND:
                    begin
                        rsl = a & b;
                        Z = (rsl[31:0] == 32'b0 ? 1'b1 : 1'b0);
                        N = rsl[31];
                    end
                `ALUOP_OR:
                    begin
                        rsl = a | b;
                        Z = (rsl[31:0] == 32'b0 ? 1'b1 : 1'b0);
                        N = rsl[31];
                    end
                `ALUOP_XOR:
                    begin
                        rsl = a ^ b;
                        Z = (rsl[31:0] == 32'b0 ? 1'b1 : 1'b0);
                        N = rsl[31];
                    end
                `ALUOP_NOR:
                    begin
                        rsl = ~(a | b);
                        Z = (rsl[31:0] == 32'b0 ? 1'b1 : 1'b0);
                        N = rsl[31];
                    end
                `ALUOP_LUI:
                    begin
                        rsl = {b[15:0], 16'b0};
                        Z = (rsl[31:0] == 32'b0 ? 1'b1 : 1'b0);
                        N = rsl[31];
                    end
                `ALUOP_SLT:
                    begin
                        rsl = ($signed(a) < $signed(b) ? 32'b1 : 32'b0);
                        Z = (a == b ? 1'b1 : 1'b0);
                        N = ($signed(a) < $signed(b) ? 1'b1 : 1'b0);
                    end
                `ALUOP_SLTU:
                    begin
                        rsl = (a < b ? 32'b1 : 32'b0);
                        Z = (a == b ? 1'b1 : 1'b0);
                        C = (a < b ? 1'b1 : 1'b0);
                        N = rsl[31];
                    end
                `ALUOP_SRA:
                    begin
                        rsl[31:0] = ($signed(b)) >>> a;
                        Z = (rsl[31:0] == 32'b0 ? 1'b1 : 1'b0);
                        C = (a == 0 ? 0 : b[a - 1]);
                        N = rsl[31];
                    end
                `ALUOP_SLL_SLA:
                    begin
                        rsl[31:0] = b << a;
                        Z = (rsl[31:0] == 32'b0 ? 1'b1 : 1'b0);
                        C = (a == 0 ? 0 : b[31 - a + 1]);
                        N = rsl[31];
                    end
                `ALUOP_SRL:
                    begin
                        rsl[31:0] = b >> a;
                        Z = (rsl[31:0] == 32'b0 ? 1'b1 : 1'b0);
                        C = b[a - 1];
                        N = rsl[31];
                    end
                default:
                    begin
                    end
            endcase            
        end
        
        assign r = rsl[31:0];
        assign zero = Z;
        assign carry = C;
        assign negative = N;
        assign overflow = O;

endmodule
