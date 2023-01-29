// ucsbece154a_top_tb.v
// All Rights Reserved
// Copyright (c) 2022 UCSB ECE
// Distribution Prohibited


`define ASSERT(CONDITION, MESSAGE) if ((CONDITION)==1'b1); else begin $display($sformatf("Error: %s", $sformatf MESSAGE)); end

module ucsbece154a_top_tb ();

// test bench contents
reg clk = 1;
always #1 clk <= ~clk;
reg reset;

ucsbece154a_top top (
    .clk(clk), .reset(reset)
);

wire [31:0] reg_zero = top.mips.dp.rf.zero;
wire [31:0] reg_at = top.mips.dp.rf.at;
wire [31:0] reg_v0 = top.mips.dp.rf.v0;
wire [31:0] reg_v1 = top.mips.dp.rf.v1;
wire [31:0] reg_a0 = top.mips.dp.rf.a0;
wire [31:0] reg_a1 = top.mips.dp.rf.a1;
wire [31:0] reg_a2 = top.mips.dp.rf.a2;
wire [31:0] reg_a3 = top.mips.dp.rf.a3;
wire [31:0] reg_t0 = top.mips.dp.rf.t0;
wire [31:0] reg_t1 = top.mips.dp.rf.t1;
wire [31:0] reg_t2 = top.mips.dp.rf.t2;
wire [31:0] reg_t3 = top.mips.dp.rf.t3;
wire [31:0] reg_t4 = top.mips.dp.rf.t4;
wire [31:0] reg_t5 = top.mips.dp.rf.t5;
wire [31:0] reg_t6 = top.mips.dp.rf.t6;
wire [31:0] reg_t7 = top.mips.dp.rf.t7;
wire [31:0] reg_s0 = top.mips.dp.rf.s0;
wire [31:0] reg_s1 = top.mips.dp.rf.s1;
wire [31:0] reg_s2 = top.mips.dp.rf.s2;
wire [31:0] reg_s3 = top.mips.dp.rf.s3;
wire [31:0] reg_s4 = top.mips.dp.rf.s4;
wire [31:0] reg_s5 = top.mips.dp.rf.s5;
wire [31:0] reg_s6 = top.mips.dp.rf.s6;
wire [31:0] reg_s7 = top.mips.dp.rf.s7;
wire [31:0] reg_t8 = top.mips.dp.rf.t8;
wire [31:0] reg_t9 = top.mips.dp.rf.t9;
wire [31:0] reg_k0 = top.mips.dp.rf.k0;
wire [31:0] reg_k1 = top.mips.dp.rf.k1;
wire [31:0] reg_gp = top.mips.dp.rf.gp;
wire [31:0] reg_sp = top.mips.dp.rf.sp;
wire [31:0] reg_fp = top.mips.dp.rf.fp;
wire [31:0] reg_ra = top.mips.dp.rf.ra;

wire [31:0] MEM_10000000 = top.mem.DATA[6'h0];
wire [31:0] MEM_10000004 = top.mem.DATA[6'h1];
wire [31:0] MEM_10000008 = top.mem.DATA[6'h2];
wire [31:0] MEM_1000000c = top.mem.DATA[6'h3];
wire [31:0] MEM_10000050 = top.mem.DATA[6'h14];
wire [31:0] MEM_10000054 = top.mem.DATA[6'h15];
//

reg [31:0] i;
reg [31:0] cycle;
always @(posedge clk) cycle = cycle+1;
initial begin
$display( "Begin simulation." );
//\\ =========================== \\//

reset = 0;
@(negedge clk);
reset = 1;
cycle = 0;
@(negedge clk);
reset = 0;

for (i = 0; i < 75; i=i+1)
    @(negedge clk);

`ASSERT(reg_zero==32'b0, ("reg_zero incorrect"));
`ASSERT(reg_v0==32'h7, ("reg_v0 incorrect"));
`ASSERT(reg_v1==32'hc, ("reg_v1 incorrect"));
`ASSERT(reg_a0==32'h1, ("reg_a0 incorrect"));
`ASSERT(reg_a1==32'hb, ("reg_a1 incorrect"));
`ASSERT(reg_a3==32'h7, ("reg_a3 incorrect"));
`ASSERT(reg_s0==32'h10000000, ("reg_s0 incorrect"));
`ASSERT(reg_s1==32'h1000000c, ("reg_s1 incorrect"));
`ASSERT(MEM_10000050==32'd7, ("mem.DATA[14] incorrect"));
`ASSERT(MEM_10000054==32'd7, ("mem.DATA[15] incorrect"));

//\\ =========================== \\//
$display( "End simulation.");
$stop;
end

endmodule
