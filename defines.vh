// ucsbece154a_defines.vh
// All Rights Reserved
// Copyright (c) 2022 UCSB ECE
// Distribution Prohibited


// Misc
localparam   [31:0] pc_start = 32'h00400000;


// ALU Op
localparam    [2:0] ALUOp_and = 3'b000;
localparam    [2:0] ALUOp_or  = 3'b001;
localparam    [2:0] ALUOp_add = 3'b010;
localparam    [2:0] ALUOp_sub = 3'b110;
localparam    [2:0] ALUOp_slt = 3'b111;
localparam    [2:0] ALUOp_lu = 3'b011;


// PC Srcx`
localparam    [1:0] PCSrc_aluresult = 2'b00;
localparam    [1:0] PCSrc_aluout = 2'b01;
localparam    [1:0] PCSrc_jump = 2'b10;


// ALU Src A
localparam          ALUSrcA_pc = 1'b0;
localparam          ALUSrcA_rf = 1'b1;


// ALU Src B
localparam    [1:0] ALUSrcB_rf = 2'b00;
localparam    [1:0] ALUSrcB_4 = 2'b01;
localparam    [1:0] ALUSrcB_immext = 2'b10;
localparam    [1:0] ALUSrcB_pcoffset = 2'b11;


// RegDst
localparam          RegDst_I = 1'b0;
localparam          RegDst_R = 1'b1;


// Instruction or Data
localparam          IorD_I = 1'b0;
localparam          IorD_D = 1'b1;


// States
localparam    [3:0] state_Fetch = 4'd0;
localparam    [3:0] state_Decode = 4'd1;
localparam    [3:0] state_MemAdr = 4'd2;
localparam    [3:0] state_MemRd = 4'd3;
localparam    [3:0] state_MemWB = 4'd4;
localparam    [3:0] state_MemWr = 4'd5;
localparam    [3:0] state_RtypeEx = 4'd6;
localparam    [3:0] state_RtypeWB = 4'd7;
localparam    [3:0] state_BeqEx = 4'd8;
localparam    [3:0] state_ItypeEx = 4'd9;
localparam    [3:0] state_ItypeWB = 4'd10;
localparam    [3:0] state_JEx = 4'd11;


// Instruction Op/Funct Codes
localparam    [5:0] instr_Rtype_op = 6'h00;
localparam    [5:0] instr_j_op = 6'h02;
localparam    [5:0] instr_beq_op = 6'h04;
localparam    [5:0] instr_addi_op = 6'h08;
localparam    [5:0] instr_lw_op = 6'h23;
localparam    [5:0] instr_sw_op = 6'h2b;
localparam    [5:0] instr_ori_op = 6'h0d;
localparam    [5:0] instr_lui_op = 6'h0f;

localparam    [5:0] instr_add_funct = 6'h20;
localparam    [5:0] instr_sub_funct = 6'h22;
localparam    [5:0] instr_and_funct = 6'h24;
localparam    [5:0] instr_or_funct = 6'h25;
localparam    [5:0] instr_slt_funct = 6'h2a;
