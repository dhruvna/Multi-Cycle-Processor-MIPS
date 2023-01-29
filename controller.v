// ucsbece154a_controller.v
// All Rights Reserved
// Copyright (c) 2022 UCSB ECE
// Distribution Prohibited


// TODO: Implement controller
//  • Replace all `z` values with the correct value
//  • BE SURE TO SET YOUR CONTROL AND STATE VALUES WITH THE PARAMS IN THE "defines.vh" FILE!
module ucsbece154a_controller (
    input               clk, reset,
    input         [5:0] op_i, funct_i,
    output reg          PCWrite_o,
    output reg          MemWrite_o,
    output reg          IRWrite_o,
    output reg          RegWrite_o,
    output reg          ALUSrcA_o,
    output reg          Branch_o,
    output reg          IorD_o,
    output reg          MemToReg_o,
    output reg          RegDst_o,
    output reg    [1:0] ALUSrcB_o,
    output reg    [1:0] PCSrc_o,
    output reg    [2:0] ALUControl_o,
    output reg          ZeroExtImm_o
);


`include "ucsbece154a_defines.vh"


// state machine
reg [3:0] state, state_next;

always @ * begin
    if (reset) begin
        state_next = state_Fetch;
    end else begin
        state_next = 4'bxxxx; // defualt value
        case (state)
            state_Fetch: state_next = state_Decode;
            state_Decode: begin
                case (op_i)
                    instr_lw_op: state_next = state_MemAdr;
                    instr_sw_op: state_next = state_MemAdr;
                    instr_Rtype_op: state_next = state_RtypeEx;
                    instr_beq_op: state_next = state_BeqEx;
                    instr_addi_op: state_next = state_ItypeEx;
                    instr_ori_op: state_next = state_ItypeEx;
                    instr_lui_op: state_next = state_ItypeEx;
                    instr_j_op: state_next = state_JEx;
                    default:;
                endcase
            end
            state_MemAdr: begin
                case (op_i)
                    instr_lw_op: state_next = state_MemRd;
                    instr_sw_op: state_next = state_MemWr;
                    default:;
                endcase
            end
            state_MemRd: state_next = state_MemWB;
            state_MemWB: state_next = state_Fetch;
            state_MemWr: state_next = state_Fetch;
            state_RtypeEx: state_next = state_RtypeWB;
            state_RtypeWB: state_next = state_Fetch;
            state_BeqEx: state_next = state_Fetch;
            state_ItypeEx: state_next = state_ItypeWB;
            state_ItypeWB: state_next = state_Fetch;
            state_JEx: state_next = state_Fetch;
            default:;
        endcase
    end
end


// control signals
reg         Branch_next;
reg         PCWrite_next;
reg         IRWrite_next;
reg         MemWrite_next;
reg         RegWrite_next;
reg         ALUSrcA_next;
reg         IorD_next;
reg         MemToReg_next;
reg         RegDst_next;
reg   [1:0] ALUSrcB_next;
reg   [1:0] PCSrc_next;
reg   [2:0] ALUControl_next;
reg         ZeroExtImm_next;

always @ * begin
    // set default values
    PCWrite_next = 1'b0;
    MemWrite_next = 1'b0;
    IRWrite_next = 1'b0;
    RegWrite_next = 1'b0;
    ALUSrcA_next = 1'bx;
    Branch_next = 1'b0;
    IorD_next = 1'bx;
    MemToReg_next = 1'bx;
    RegDst_next = 1'bx;
    ALUSrcB_next = 2'bxx;
    PCSrc_next = 2'bxx;
    ALUControl_next = 3'bxxx;
    ZeroExtImm_next = 1'bx;

    case (state_next)
        state_Fetch: begin
            IorD_next = IorD_I;
            ALUSrcA_next = ALUSrcA_pc;
            ALUSrcB_next = ALUSrcB_4;
            ALUControl_next = ALUOp_add;
            PCSrc_next = PCSrc_aluresult;
            PCWrite_next = 1'b1;
            IRWrite_next = 1'b1;
        end
        state_Decode: begin
            ALUSrcA_next = ALUSrcA_pc;
            ALUSrcB_next = ALUSrcB_pcoffset;
            ALUControl_next = ALUOp_add;
        end
        state_MemAdr: begin
            ALUSrcA_next = ALUSrcA_rf;
            ALUSrcB_next = ALUSrcB_immext;
            ALUControl_next = ALUOp_add;
        end
        state_MemRd: begin
            IorD_next = IorD_D;
        end
        state_MemWB: begin
            RegDst_next = RegDst_I;
            MemToReg_next = 1'b1;
            RegWrite_next = 1'b1;
        end
        state_MemWr: begin
            IorD_next = IorD_D;
            MemWrite_next = 1'b1;
        end
        state_RtypeEx: begin
            ALUSrcA_next = ALUSrcA_rf;
            ALUSrcB_next = ALUSrcB_rf;
            case (funct_i)
                instr_add_funct: ALUControl_next = ALUOp_add;
                instr_sub_funct: ALUControl_next = ALUOp_sub;
                instr_and_funct: ALUControl_next = ALUOp_and;
                instr_or_funct:  ALUControl_next = ALUOp_or;
                instr_slt_funct: ALUControl_next = ALUOp_slt;
                default:;
            endcase
        end
        state_RtypeWB: begin
            RegDst_next = RegDst_R;
            MemToReg_next = 1'b0;
            RegWrite_next = 1'b1;
        end
        state_BeqEx: begin
            ALUSrcA_next = ALUSrcA_rf;
            ALUSrcB_next = ALUSrcB_rf;
            ALUControl_next = ALUOp_sub;
            PCSrc_next = PCSrc_aluout;
            Branch_next = 1'b1;
        end
        state_ItypeEx: begin
            ALUSrcA_next = ALUSrcA_rf;
            ALUSrcB_next = ALUSrcB_immext;
            case (op_i)
                instr_addi_op: begin
                    ALUControl_next = ALUOp_add;
                    ZeroExtImm_next = 1'b0;
                end
                instr_ori_op: begin
                    ALUControl_next = ALUOp_or;
                    ZeroExtImm_next = 1'b1;
                end
                instr_lui_op: begin
                    ALUControl_next = ALUOp_lu;
                    ZeroExtImm_next = 1'b0;
                end
                default:;
            endcase
        end
        state_ItypeWB: begin
            RegDst_next = RegDst_I;
            MemToReg_next = 1'b0;
            RegWrite_next = 1'b1;
        end
        state_JEx: begin
            PCSrc_next = PCSrc_jump;
            PCWrite_next = 1'b1;
        end
        default:;
    endcase
end

// flip flops
always @(posedge clk) begin
    state <= state_next;
    Branch_o <= Branch_next;
    PCWrite_o <= PCWrite_next;
    IRWrite_o <= IRWrite_next;
    MemWrite_o <= MemWrite_next;
    RegWrite_o <= RegWrite_next;
    ALUSrcA_o <= ALUSrcA_next;
    IorD_o <= IorD_next;
    MemToReg_o <= MemToReg_next;
    RegDst_o <= RegDst_next;
    ALUSrcB_o <= ALUSrcB_next;
    PCSrc_o <= PCSrc_next;
    ALUControl_o <= ALUControl_next;
    ZeroExtImm_o <= ZeroExtImm_next;
end


endmodule
