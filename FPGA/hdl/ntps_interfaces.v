//======================================================================
//
// npts_interfaces.v
// -----------------
// This module contains the external interfaces used in the
// ntps FPGA design.
//
//
// Author: Joachim Strombergson
//
// Copyright (c) 2020, The Swedish Post and Telecom Authority (PTS)
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without
// modification, are permitted provided that the following conditions
// are met:
//
// 1. Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
//
// 2. Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in
//    the documentation and/or other materials provided with the
//    distribution.
//
// THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
// "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
// LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
// FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
// COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
// INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
// BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
// LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
// CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
// LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
// ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.
//
//======================================================================

`default_nettype none

module ntps_interfaces #(
                         parameter BUILD_INFO = 0,
                         parameter GIT_HASH   = 0
                         )
                       (
                       input wire            reset,

                       // PCI-AXI interface and bridge.
                       input wire            pcie_perst,
                       input wire            pcie_clk,
                       input wire [7:0]      pci_exp_rxn,
                       input wire [7:0]      pci_exp_rxp,
                       output wire [7:0]     pci_exp_txn,
                       output wire [7:0]     pci_exp_txp,

                       output wire           user_link_up,

                       input wire            clk50,
                       input wire            pmbus_alert,
                       inout wire            pmbus_clk,
                       inout wire            pmbus_data,

                       output wire           clk156,
                       output wire           areset_clk156,

                       // Port 0.
                       input wire            xphy_refclk_n,
                       input wire            xphy_refclk_p,

                       input wire  [2 : 0]   xphy_config_0,
                       output wire [4 : 0]   xphy_status_0,
                       input wire            sfp_module_detect_n_0,
                       input wire            sfp_signal_lost_0,
                       input wire            sfp_tx_fault_0,
                       output wire           sfp_tx_disable_0,
                       input wire            xphy_rxp_0,
                       input wire            xphy_rxn_0,
                       output wire           xphy_txp_0,
                       output wire           xphy_txn_0,
                       input wire [63  : 0]  xgmii_txd_0,
                       input wire [7   : 0]  xgmii_txc_0,
                       output wire [63 : 0]  xgmii_rxd_0,
                       output wire [7  : 0]  xgmii_rxc_0,


                       // Port 1.
                       input wire  [2 : 0]   xphy_config_1,
                       output wire [4 : 0]   xphy_status_1,
                       input wire            sfp_module_detect_n_1,
                       input wire            sfp_signal_lost_1,
                       input wire            sfp_tx_fault_1,
                       output wire           sfp_tx_disable_1,
                       input wire            xphy_rxp_1,
                       input wire            xphy_rxn_1,
                       output wire           xphy_txp_1,
                       output wire           xphy_txn_1,
                       input wire  [63 : 0]  xgmii_txd_1,
                       input wire  [7  : 0]  xgmii_txc_1,
                       output wire [63 : 0]  xgmii_rxd_1,
                       output wire [7  : 0]  xgmii_rxc_1,


                       // Port 2.
                       input wire  [2 : 0]   xphy_config_2,
                       output wire [4 : 0]   xphy_status_2,
                       input wire            sfp_module_detect_n_2,
                       input wire            sfp_signal_lost_2,
                       input wire            sfp_tx_fault_2,
                       output wire           sfp_tx_disable_2,
                       input wire            xphy_rxp_2,
                       input wire            xphy_rxn_2,
                       output wire           xphy_txp_2,
                       output wire           xphy_txn_2,
                       input wire  [63 : 0]  xgmii_txd_2,
                       input wire  [7  : 0]  xgmii_txc_2,
                       output wire [63 : 0]  xgmii_rxd_2,
                       output wire [7  : 0]  xgmii_rxc_2,


                       // Port 3.
                       input wire  [2 : 0]   xphy_config_3,
                       output wire [4 : 0]   xphy_status_3,
                       input wire            sfp_module_detect_n_3,
                       input wire            sfp_signal_lost_3,
                       input wire            sfp_tx_fault_3,
                       output wire           sfp_tx_disable_3,
                       input wire            xphy_rxp_3,
                       input wire            xphy_rxn_3,
                       output wire           xphy_txp_3,
                       output wire           xphy_txn_3,
                       input wire  [63 : 0]  xgmii_txd_3,
                       input wire  [7  : 0]  xgmii_txc_3,
                       output wire [63 : 0]  xgmii_rxd_3,
                       output wire [7  : 0]  xgmii_rxc_3


                       output wire           axi_aclk,
                       output wire           axi_aresetn,

                       output wire [383 : 0] m_axi_awaddr,
                       output wire [35 : 0]  m_axi_awprot,
                       output wire [11 : 0]  m_axi_awvalid,
                       input  wire [11 : 0]  m_axi_awready,
                       output wire [383 : 0] m_axi_wdata,
                       output wire [47 : 0]  m_axi_wstrb,
                       output wire [11 : 0]  m_axi_wvalid,
                       input  wire [11 : 0]  m_axi_wready,
                       input  wire [23 : 0]  m_axi_bresp,
                       input  wire [11 : 0]  m_axi_bvalid,
                       output wire [11 : 0]  m_axi_bready,
                       output wire [383 : 0] m_axi_araddr,
                       output wire [35 : 0]  m_axi_arprot,
                       output wire [11 : 0]  m_axi_arvalid,
                       input  wire [11 : 0]  m_axi_arready,
                       input  wire [383 : 0] m_axi_rdata,
                       input  wire [23 : 0]  m_axi_rresp,
                       input  wire [11 : 0]  m_axi_rvalid,
                       output wire [11 : 0]  m_axi_rready,

                       input wire            PPS_INA_N,
                       input wire            PPS_INA_P,
                       output wire           PPS_OUTA,
                       input wire            TEN_MHZ_INA_N,
                       input wire            TEN_MHZ_INA_P,
                       output wire           TEN_MHZ_OUTA,
                       output wire [63 : 0]  NTP_TIMEA,
                       output wire           NTP_TIME_UPDA,
                       output wire           NTP_LED1A,
                       output wire           NTP_LED2A,
                       output wire           SYNC_OKA,
                       output wire           PLL_LOCKEDA,

                       input wire            PPS_INB_N,
                       input wire            PPS_INB_P,
                       output wire           PPS_OUTB,
                       input wire            TEN_MHZ_INB_N,
                       input wire            TEN_MHZ_INB_P,
                       output wire           TEN_MHZ_OUTB,
                       output wire [63 : 0]  NTP_TIMEB,
                       output wire           NTP_TIME_UPDB,
                       output wire           NTP_LED1B,
                       output wire           NTP_LED2B,
                       output wire           SYNC_OKB,
                       output wire           PLL_LOCKEDB
                      );


  //----------------------------------------------------------------
  // Local parameters.
  //----------------------------------------------------------------
  localparam AXI_NTPA_INDEX    = 0;
  localparam AXI_NTPB_INDEX    = 1;
  localparam AXI_PVT_INDEX     = 7;
  localparam AXI_ETHLITE_INDEX = 2;


  //----------------------------------------------------------------
  // Internal wires.
  //----------------------------------------------------------------
  wire mdc;
  wire mdio_in;
  wire mdio_out;


  //----------------------------------------------------------------
  // PCI-AXI instantiation.
  //----------------------------------------------------------------
  pcie_axi pcie_axi_0 (
    .reset         (reset),
    .pcie_perst    (pcie_perst),
    .pcie_clk      (pcie_clk),
    .pci_exp_rxn   (pci_exp_rxn),
    .pci_exp_rxp   (pci_exp_rxp),
    .pci_exp_txn   (pci_exp_txn),
    .pci_exp_txp   (pci_exp_txp),
    .axi_aresetn   (axi_aresetn),
    .axi_aclk      (axi_aclk),
    .m_axi_awaddr  (m_axi_awaddr),
    .m_axi_awprot  (m_axi_awprot),
    .m_axi_awvalid (m_axi_awvalid),
    .m_axi_awready (m_axi_awready),
    .m_axi_wdata   (m_axi_wdata),
    .m_axi_wstrb   (m_axi_wstrb),
    .m_axi_wvalid  (m_axi_wvalid),
    .m_axi_wready  (m_axi_wready),
    .m_axi_bresp   (m_axi_bresp),
    .m_axi_bvalid  (m_axi_bvalid),
    .m_axi_bready  (m_axi_bready),
    .m_axi_araddr  (m_axi_araddr),
    .m_axi_arprot  (m_axi_arprot),
    .m_axi_arvalid (m_axi_arvalid),
    .m_axi_arready (m_axi_arready),
    .m_axi_rdata   (m_axi_rdata),
    .m_axi_rresp   (m_axi_rresp),
    .m_axi_rvalid  (m_axi_rvalid),
    .m_axi_rready  (m_axi_rready),
    .user_link_up  (user_link_up)
   );


  //----------------------------------------------------------------
  // NTP clocks.
  //----------------------------------------------------------------
  ntp_clock_top ntp_clock_topA (
    .reset        (reset),
    .TEN_MHZ_IN_N (TEN_MHZ_INA_N),
    .TEN_MHZ_IN_P (TEN_MHZ_INA_P),
    .TEN_MHZ_OUT  (TEN_MHZ_OUTA),
    .PPS_IN_N     (PPS_INA_N),
    .PPS_IN_P     (PPS_INA_P),
    .PPS_OUT      (PPS_OUTA),
    .axi_aclk     (axi_aclk),
    .axi_aresetn  (axi_aresetn),
    .axi_araddr   (m_axi_araddr [(AXI_NTPA_INDEX * 32) +: 5]),
    .axi_arprot   (m_axi_arprot [(AXI_NTPA_INDEX * 3) +: 3]),
    .axi_arready  (m_axi_arready[(AXI_NTPA_INDEX * 1) +: 1]),
    .axi_arvalid  (m_axi_arvalid[(AXI_NTPA_INDEX * 1) +: 1]),
    .axi_awaddr   (m_axi_awaddr [(AXI_NTPA_INDEX * 32) +: 5]),
    .axi_awprot   (m_axi_awprot [(AXI_NTPA_INDEX * 3) +: 3]),
    .axi_awready  (m_axi_awready[(AXI_NTPA_INDEX * 1) +: 1]),
    .axi_awvalid  (m_axi_awvalid[(AXI_NTPA_INDEX * 1) +: 1]),
    .axi_bready   (m_axi_bready [(AXI_NTPA_INDEX * 1) +: 1]),
    .axi_bresp    (m_axi_bresp  [(AXI_NTPA_INDEX * 2) +: 2]),
    .axi_bvalid   (m_axi_bvalid [(AXI_NTPA_INDEX * 1) +: 1]),
    .axi_rdata    (m_axi_rdata  [(AXI_NTPA_INDEX * 32) +: 32]),
    .axi_rready   (m_axi_rready [(AXI_NTPA_INDEX * 1) +: 1]),
    .axi_rresp    (m_axi_rresp  [(AXI_NTPA_INDEX * 2) +: 2]),
    .axi_rvalid   (m_axi_rvalid [(AXI_NTPA_INDEX * 1) +: 1]),
    .axi_wdata    (m_axi_wdata  [(AXI_NTPA_INDEX * 32) +: 32]),
    .axi_wready   (m_axi_wready [(AXI_NTPA_INDEX * 1) +: 1]),
    .axi_wstrb    (m_axi_wstrb  [(AXI_NTPA_INDEX * 32/8) +: 32/8]),
    .axi_wvalid   (m_axi_wvalid [(AXI_NTPA_INDEX * 1) +: 1]),
    .NTP_TIME     (NTP_TIMEA),
    .NTP_TIME_UPD (NTP_TIME_UPDA),
    .PLL_locked   (PLL_LOCKEDA),
    .LED1         (NTP_LED1A),
    .LED2         (NTP_LED2A),
    .LED3         (),
    .LED4         (),
    .LED5         (),
    .LED6         (),
    .LED7         (),
    .LED8         (),
    .SYNC_OK      (SYNC_OKA),
    .test         ()
    );


  ntp_clock_top ntp_clock_topB (
    .reset        (reset),
    .TEN_MHZ_IN_N (TEN_MHZ_INB_N),
    .TEN_MHZ_IN_P (TEN_MHZ_INB_P),
    .TEN_MHZ_OUT  (TEN_MHZ_OUTB),
    .PPS_IN_N     (PPS_INB_N),
    .PPS_IN_P     (PPS_INB_P),
    .PPS_OUT      (PPS_OUTB),
    .axi_aclk     (axi_aclk),
    .axi_aresetn  (axi_aresetn),
    .axi_araddr   (m_axi_araddr [(AXI_NTPB_INDEX * 32) +: 5]),
    .axi_arprot   (m_axi_arprot [(AXI_NTPB_INDEX * 3) +: 3]),
    .axi_arready  (m_axi_arready[(AXI_NTPB_INDEX * 1) +: 1]),
    .axi_arvalid  (m_axi_arvalid[(AXI_NTPB_INDEX * 1) +: 1]),
    .axi_awaddr   (m_axi_awaddr [(AXI_NTPB_INDEX * 32) +: 5]),
    .axi_awprot   (m_axi_awprot [(AXI_NTPB_INDEX * 3) +: 3]),
    .axi_awready  (m_axi_awready[(AXI_NTPB_INDEX * 1) +: 1]),
    .axi_awvalid  (m_axi_awvalid[(AXI_NTPB_INDEX * 1) +: 1]),
    .axi_bready   (m_axi_bready [(AXI_NTPB_INDEX * 1) +: 1]),
    .axi_bresp    (m_axi_bresp  [(AXI_NTPB_INDEX * 2) +: 2]),
    .axi_bvalid   (m_axi_bvalid [(AXI_NTPB_INDEX * 1) +: 1]),
    .axi_rdata    (m_axi_rdata  [(AXI_NTPB_INDEX * 32) +: 32]),
    .axi_rready   (m_axi_rready [(AXI_NTPB_INDEX * 1) +: 1]),
    .axi_rresp    (m_axi_rresp  [(AXI_NTPB_INDEX * 2) +: 2]),
    .axi_rvalid   (m_axi_rvalid [(AXI_NTPB_INDEX * 1) +: 1]),
    .axi_wdata    (m_axi_wdata  [(AXI_NTPB_INDEX * 32) +: 32]),
    .axi_wready   (m_axi_wready [(AXI_NTPB_INDEX * 1) +: 1]),
    .axi_wstrb    (m_axi_wstrb  [(AXI_NTPB_INDEX * 32/8) +: 32/8]),
    .axi_wvalid   (m_axi_wvalid [(AXI_NTPB_INDEX * 1) +: 1]),
    .NTP_TIME     (NTP_TIMEB),
    .NTP_TIME_UPD (NTP_TIME_UPDB),
    .PLL_locked   (PLL_LOCKEDB),
    .LED1         (NTP_LED1B),
    .LED2         (NTP_LED2B),
    .LED3         (),
    .LED4         (),
    .LED5         (),
    .LED6         (),
    .LED7         (),
    .LED8         (),
    .SYNC_OK      (SYNC_OKB),
    .test         ()
    );


  //----------------------------------------------------------------
  // Ethernet lite module for MDIO control only.
  //----------------------------------------------------------------
  ntps_top_axi_ethernetlite_0_0 mdio_ctrl_0 (
    .phy_col       (1'b0),
    .phy_crs       (1'b0),
    .phy_dv        (1'b0),
    .phy_mdc       (mdc),
    .phy_mdio_i    (mdio_out),
    .phy_mdio_o    (mdio_in),
    .phy_rx_clk    (1'b0),
    .phy_rx_data   (4'b0),
    .phy_rx_er     (1'b0),
    .phy_tx_clk    (1'b0),
    .s_axi_aclk    (axi_aclk),
    .s_axi_aresetn (axi_aresetn),
    .s_axi_araddr  (m_axi_araddr [(AXI_ETHLITE_INDEX * 32) +: 13]),
    .s_axi_arready (m_axi_arready[(AXI_ETHLITE_INDEX * 1) +: 1]),
    .s_axi_arvalid (m_axi_arvalid[(AXI_ETHLITE_INDEX * 1) +: 1]),
    .s_axi_awaddr  (m_axi_awaddr [(AXI_ETHLITE_INDEX * 32) +: 13]),
    .s_axi_awready (m_axi_awready[(AXI_ETHLITE_INDEX * 1) +: 1]),
    .s_axi_awvalid (m_axi_awvalid[(AXI_ETHLITE_INDEX * 1) +: 1]),
    .s_axi_bready  (m_axi_bready [(AXI_ETHLITE_INDEX * 1) +: 1]),
    .s_axi_bresp   (m_axi_bresp  [(AXI_ETHLITE_INDEX * 2) +: 2]),
    .s_axi_bvalid  (m_axi_bvalid [(AXI_ETHLITE_INDEX * 1) +: 1]),
    .s_axi_rdata   (m_axi_rdata  [(AXI_ETHLITE_INDEX * 32) +: 32]),
    .s_axi_rready  (m_axi_rready [(AXI_ETHLITE_INDEX * 1) +: 1]),
    .s_axi_rresp   (m_axi_rresp  [(AXI_ETHLITE_INDEX * 2) +: 2]),
    .s_axi_rvalid  (m_axi_rvalid [(AXI_ETHLITE_INDEX * 1) +: 1]),
    .s_axi_wdata   (m_axi_wdata  [(AXI_ETHLITE_INDEX * 32) +: 32]),
    .s_axi_wready  (m_axi_wready [(AXI_ETHLITE_INDEX * 1) +: 1]),
    .s_axi_wstrb   (m_axi_wstrb  [(AXI_ETHLITE_INDEX * 32/8) +: 32/8]),
    .s_axi_wvalid  (m_axi_wvalid [(AXI_ETHLITE_INDEX * 1) +: 1])
  );


  //----------------------------------------------------------------
  // pvtmon
  // Status registers for board power and temperature.
  // Also includes registers for build info to ID the FPGA design.
  //----------------------------------------------------------------
  pvtmon_top #(
               .BUILD_INFO(BUILD_INFO),
               .GIT_HASH(GIT_HASH)
               )
  pvtmon_top_0 (
    .clk50          (clk50),
    .rst            (reset),
    .pcie_link_up   (user_link_up),
    .pmbus_alert    (pmbus_alert),
    .pmbus_clk      (pmbus_clk),
    .pmbus_data     (pmbus_data),
    .s_axi_clk      (axi_aclk),
    .s_axi_aresetn  (axi_aresetn),
    .s_axi_araddr   (m_axi_araddr [(AXI_PVT_INDEX * 32) +: 32]),
    .s_axi_arready  (m_axi_arready[(AXI_PVT_INDEX * 1) +: 1]),
    .s_axi_arvalid  (m_axi_arvalid[(AXI_PVT_INDEX * 1) +: 1]),
    .s_axi_awaddr   (m_axi_awaddr [(AXI_PVT_INDEX * 32) +: 32]),
    .s_axi_awready  (m_axi_awready[(AXI_PVT_INDEX * 1) +: 1]),
    .s_axi_awvalid  (m_axi_awvalid[(AXI_PVT_INDEX * 1) +: 1]),
    .s_axi_bready   (m_axi_bready [(AXI_PVT_INDEX * 1) +: 1]),
    .s_axi_bresp    (m_axi_bresp  [(AXI_PVT_INDEX * 2) +: 2]),
    .s_axi_bvalid   (m_axi_bvalid [(AXI_PVT_INDEX * 1) +: 1]),
    .s_axi_rdata    (m_axi_rdata  [(AXI_PVT_INDEX * 32) +: 32]),
    .s_axi_rready   (m_axi_rready [(AXI_PVT_INDEX * 1) +: 1]),
    .s_axi_rresp    (m_axi_rresp  [(AXI_PVT_INDEX * 2) +: 2]),
    .s_axi_rvalid   (m_axi_rvalid [(AXI_PVT_INDEX * 1) +: 1]),
    .s_axi_wdata    (m_axi_wdata  [(AXI_PVT_INDEX * 32) +: 32]),
    .s_axi_wready   (m_axi_wready [(AXI_PVT_INDEX * 1) +: 1]),
    .s_axi_wstrb    (m_axi_wstrb  [(AXI_PVT_INDEX * 32/8) +: 32/8]),
    .s_axi_wvalid   (m_axi_wvalid [(AXI_PVT_INDEX * 1) +: 1])
    );


  //----------------------------------------------------------------
  // Ethernet PHYs.
  //----------------------------------------------------------------
  ntps_phys phys(
                 .reset                 (reset),
                 .clk156                (clk156),
                 .areset_clk156         (areset_clk156),

                 .mdc                   (mdc),
                 .mdio_in               (mdio_in),
                 .mdio_out              (mdio_out),

                 .xphy_refclk_n         (xphy_refclk_n),
                 .xphy_refclk_p         (xphy_refclk_p),

                 .xphy_config_0         (xphy_config_0),
                 .xphy_status_0         (xphy_status_0),
                 .sfp_module_detect_n_0 (sfp_module_detect_n_0),
                 .sfp_signal_lost_0     (sfp_signal_lost_0),
                 .sfp_tx_fault_0        (sfp_tx_fault_0),
                 .sfp_tx_disable_0      (sfp_tx_disable_0),
                 .xphy_rxp_0            (xphy_rxp_0),
                 .xphy_rxn_0            (xphy_rxn_0),
                 .xphy_txp_0            (xphy_txp_0),
                 .xphy_txn_0            (xphy_txn_0),
                 .xgmii_txd_0           (xgmii_txd_0),
                 .xgmii_txc_0           (xgmii_txc_0),
                 .xgmii_rxd_0           (xgmii_rxd_0),
                 .xgmii_rxc_0           (xgmii_rxc_0),

                 .xphy_config_1         (xphy_config_1),
                 .xphy_status_1         (xphy_status_1),
                 .sfp_module_detect_n_1 (sfp_module_detect_n_1),
                 .sfp_signal_lost_1     (sfp_signal_lost_1),
                 .sfp_tx_fault_1        (sfp_tx_fault_1),
                 .sfp_tx_disable_1      (sfp_tx_disable_1),
                 .xphy_rxp_1            (xphy_rxp_1),
                 .xphy_rxn_1            (xphy_rxn_1),
                 .xphy_txp_1            (xphy_txp_1),
                 .xphy_txn_1            (xphy_txn_1),
                 .xgmii_txd_1           (xgmii_txd_1),
                 .xgmii_txc_1           (xgmii_txc_1),
                 .xgmii_rxd_1           (xgmii_rxd_1),
                 .xgmii_rxc_1           (xgmii_rxc_1),

                 .xphy_config_2         (xphy_config_2),
                 .xphy_status_2         (xphy_status_2),
                 .sfp_module_detect_n_2 (sfp_module_detect_n_2),
                 .sfp_signal_lost_2     (sfp_signal_lost_2),
                 .sfp_tx_fault_2        (sfp_tx_fault_2),
                 .sfp_tx_disable_2      (sfp_tx_disable_2),
                 .xphy_rxp_2            (xphy_rxp_2),
                 .xphy_rxn_2            (xphy_rxn_2),
                 .xphy_txp_2            (xphy_txp_2),
                 .xphy_txn_2            (xphy_txn_2),
                 .xgmii_txd_2           (xgmii_txd_2),
                 .xgmii_txc_2           (xgmii_txc_2),
                 .xgmii_rxd_2           (xgmii_rxd_2),
                 .xgmii_rxc_2           (xgmii_rxc_2),

                 .xphy_config_3         (xphy_config_3),
                 .xphy_status_3         (xphy_status_3),
                 .sfp_module_detect_n_3 (sfp_module_detect_n_3),
                 .sfp_signal_lost_3     (sfp_signal_lost_3),
                 .sfp_tx_fault_3        (sfp_tx_fault_3),
                 .sfp_tx_disable_3      (sfp_tx_disable_3),
                 .xphy_rxp_3            (xphy_rxp_3),
                 .xphy_rxn_3            (xphy_rxn_3),
                 .xphy_txp_3            (xphy_txp_3),
                 .xphy_txn_3            (xphy_txn_3),
                 .xgmii_txd_3           (xgmii_txd_3),
                 .xgmii_txc_3           (xgmii_txc_3),
                 .xgmii_rxd_3           (xgmii_rxd_3),
                 .xgmii_rxc_3           (xgmii_rxc_3)
                 );

endmodule // ntps_interfaces

`default_nettype wire

//======================================================================
// EOF ntps_interfaces.v
//======================================================================
