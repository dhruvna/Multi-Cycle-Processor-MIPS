// ucsbece154a_top.v
// All Rights Reserved
// Copyright (c) 2022 UCSB ECE
// Distribution Prohibited


module ucsbece154a_top (
    input clk, reset
);

wire we;
wire [31:0] a, wd, rd;

// processor and memories are instantiated here
ucsbece154a_mips mips (
    .clk(clk), .reset(reset),
    .we_o(we),
    .a_o(a),
    .wd_o(wd),
    .rd_i(rd)
);
ucsbece154a_mem mem (
    .clk(clk),
    .we_i(we),
    .a_i(a),
    .wd_i(wd),
    .rd_o(rd)
);

endmodule
