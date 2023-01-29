// ucsbece154a_datapath.v
// All Rights Reserved
// Copyright (c) 2022 UCSB ECE
// Distribution Prohibited


// TODO: Implement datapath
//  • fill flip-flop D values
//  • fill rf and alu
//  • add the rest of your code
//  • BE SURE TO HANDLE YOUR CONTROL VALUES WITH THE PARAMS IN THE "defines.vh" FILE!
module ucsbece154a_datapath (
    input               clk, reset,
    input               PCWrite_i,
    input         [1:0] PCSrc_i,
    input               ALUSrcA_i,
    input         [1:0] ALUSrcB_i,
    input               RegWrite_i,
    input               IorD_i,
    input               IRWrite_i,
    input               RegDst_i,
    input               Branch_i,
    input               MemToReg_i,
    input         [2:0] ALUControl_i,
    input               ZeroExtImm_i,
    output reg   [31:0] a_o,
    output wire  [31:0] wd_o,
    input        [31:0] rd_i,
    output wire   [5:0] op_o,
    output wire   [5:0] funct_o
);

`include "ucsbece154a_defines.vh"

// flip flops
reg [31:0] pc;
reg [31:0] instr;
reg [31:0] data;
reg [31:0] a;
reg [31:0] b;
reg [31:0] aluout;

wire aluzero;
wire [4:0] a3;
wire [31:0] wd3, rd_1, rd_2, aluresult, immext, ALUSrcA, ALUSrcB, PCSrc;

wire pcen = (PCWrite_i || (Branch_i && aluzero));

always @(posedge clk) begin
    if (reset) begin
        pc <= pc_start;
        instr <= {32{1'bx}};
        data <= {32{1'bx}};
        a <= {32{1'bx}};
        b <= {32{1'bx}};
        aluout <= {32{1'bx}};
    end else begin
        // FILL FLIP FLOP D VALUES
        if (pcen) pc <= PCSrc;
        if (IRWrite_i) instr <= rd_i;
        data <= rd_i;
        a <= rd_1;
        b <= rd_2;
        aluout <= aluresult;
    end
end


always @(*) begin
    case (IorD_i)
        IorD_I: a_o = pc;
        IorD_D: a_o = aluout;
        default: a_o = {32{1'bx}};
    endcase

end

assign wd_o = b;
assign op_o = instr[31:26];
assign funct_o = instr[5:0];


assign immext = 
    ZeroExtImm_i ? {{16{1'b0}}, instr[15:0]} : 
    {{16{instr[15]}}, instr[15:0]};
assign PCSrc = 
    (PCSrc_i == PCSrc_aluresult) ? aluresult : 
    (PCSrc_i == PCSrc_aluout) ? aluout : 
    (PCSrc_i == PCSrc_jump) ? {pc[31:28], instr[25:0], 2'b00} : 
    {32{1'bx}};
assign a3 = 
    (RegDst_i == RegDst_I) ? instr[20:16] : 
    (RegDst_i == RegDst_R) ? instr[15:11] : 
    {5{1'bx}};
assign wd3 = MemToReg_i ? data : aluout;
assign ALUSrcA = 
    (ALUSrcA_i == ALUSrcA_pc) ? pc : 
    (ALUSrcA_i == ALUSrcA_rf) ? a : 
    {32{1'bx}};
assign ALUSrcB = 
    (ALUSrcB_i == ALUSrcB_rf) ? b : 
    (ALUSrcB_i == ALUSrcB_4) ? 4 : 
    (ALUSrcB_i == ALUSrcB_immext) ? immext : 
    (ALUSrcB_i == ALUSrcB_pcoffset) ? immext << 2 : 
    {32{1'bx}};


ucsbece154a_rf rf (
    .clk(clk), .a1_i(instr[25:21]), .a2_i(instr[20:16]), .a3_i(a3),
    .rd1_o(rd_1), .rd2_o(rd_2),
    .we3_i(RegWrite_i),
    .wd3_i(wd3)
);

ucsbece154a_alu alu (
    .a_i(ALUSrcA),
    .b_i(ALUSrcB),
    .f_i(ALUControl_i),
    .y_o(aluresult),
    .zero_o(aluzero)
);

endmodule
