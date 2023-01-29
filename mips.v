// ucsbece154a_mips.v
// All Rights Reserved
// Copyright (c) 2022 UCSB ECE
// Distribution Prohibited


module ucsbece154a_mips (
    input               clk, reset,
    output wire         we_o,
    output wire  [31:0] a_o,
    output wire  [31:0] wd_o,
    input        [31:0] rd_i
);

wire [5:0] op, funct;

wire        PCWrite;
wire        MemWrite;
wire        IRWrite;
wire        RegWrite;
wire        ALUSrcA;
wire        Branch;
wire        IorD;
wire        MemToReg;
wire        RegDst;
wire  [1:0] ALUSrcB;
wire  [1:0] PCSrc;
wire  [2:0] ALUControl;
wire        ZeroExtImm;

assign we_o = MemWrite;

ucsbece154a_controller c (
    .clk(clk),
    .reset(reset),
    .op_i(op),
    .funct_i(funct),
    .PCWrite_o(PCWrite),
    .MemWrite_o(MemWrite),
    .IRWrite_o(IRWrite),
    .RegWrite_o(RegWrite),
    .ALUSrcA_o(ALUSrcA),
    .Branch_o(Branch),
    .IorD_o(IorD),
    .MemToReg_o(MemToReg),
    .RegDst_o(RegDst),
    .ALUSrcB_o(ALUSrcB),
    .PCSrc_o(PCSrc),
    .ALUControl_o(ALUControl),
    .ZeroExtImm_o(ZeroExtImm)
);
ucsbece154a_datapath dp (
    .clk(clk),
    .reset(reset),
    .PCWrite_i(PCWrite),
    .PCSrc_i(PCSrc),
    .ALUSrcA_i(ALUSrcA),
    .ALUSrcB_i(ALUSrcB),
    .RegWrite_i(RegWrite),
    .IorD_i(IorD),
    .IRWrite_i(IRWrite),
    .RegDst_i(RegDst),
    .Branch_i(Branch),
    .MemToReg_i(MemToReg),
    .ALUControl_i(ALUControl),
    .ZeroExtImm_i(ZeroExtImm),
    .a_o(a_o),
    .wd_o(wd_o),
    .rd_i(rd_i),
    .op_o(op),
    .funct_o(funct)
);
endmodule
