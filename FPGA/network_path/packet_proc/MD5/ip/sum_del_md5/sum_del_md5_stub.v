// Copyright 1986-2019 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2019.1 (lin64) Build 2552052 Fri May 24 14:47:09 MDT 2019
// Date        : Wed Nov 20 14:05:42 2019
// Host        : fpga01-fg.sth.netnod.se running 64-bit CentOS Linux release 7.7.1908 (Core)
// Command     : write_verilog -force -mode synth_stub
//               /home/joachim/Sandbox/repos/FPGA_NTP_SERVER/FPGA/network_path/packet_proc/MD5/ip/sum_del_md5/sum_del_md5_stub.v
// Design      : sum_del_md5
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7vx690tffg1761-2
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "c_shift_ram_v12_0_13,Vivado 2019.1" *)
module sum_del_md5(D, CLK, CE, Q)
/* synthesis syn_black_box black_box_pad_pin="D[127:0],CLK,CE,Q[127:0]" */;
  input [127:0]D;
  input CLK;
  input CE;
  output [127:0]Q;
endmodule