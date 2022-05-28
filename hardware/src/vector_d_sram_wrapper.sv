module vector_d_sram_wrapper import ara_pkg::*;  #(
  parameter int unsigned NumWords     = 32'd1024, // Number of Words in data array
  parameter int unsigned DataWidth    = 32'd128,  // Data signal width
  parameter int unsigned ByteWidth    = 32'd8,    // Width of a data byte
  parameter int unsigned NumPorts     = 32'd2,    // Number of read and write ports
  parameter int unsigned Latency      = 32'd1,    // Latency when the read data is available
  parameter              SimInit      = "none",   // Simulation initialization
  parameter bit          PrintSimCfg  = 1'b0     // Print configuration
  // DEPENDENT PARAMETERS, DO NOT OVERWRITE!
  parameter int unsigned AddrWidth = (NumWords > 32'd1) ? $clog2(NumWords) : 32'd1,
  parameter int unsigned BeWidth   = (DataWidth + ByteWidth - 32'd1) / ByteWidth, // ceil_div
  parameter type         addr_t    = logic [AddrWidth-1:0],
  parameter type         data_t    = logic [DataWidth-1:0],
  parameter type         be_t      = logic [BeWidth-1:0]
) (
  input  logic                 clk_i,      // Clock
  input  logic                 rst_ni,     // Asynchronous reset active low
  // input ports
  input  logic  [NumPorts-1:0] req_i,      // request
  input  logic  [NumPorts-1:0] we_i,       // write enable
  input  addr_t [NumPorts-1:0] addr_i,     // request address
  input  data_t [NumPorts-1:0] wdata_i,    // write data
  input  be_t   [NumPorts-1:0] be_i,       // write byte enable
  // output ports
  output data_t [NumPorts-1:0] rdata_o     // read data
);
`ifdef TARGET_SYNTHESIS
    wire we_ni = !we_i;
    wire req_ni = !req_i;
    wire [31:0] rdata_o_1, rdata_o_2;
    SRAM1RW64x32 tc_sram_inst_1 (
        .A  (addr_i ),  // Primary Read/Write Address
        .CE (clk_i  ),  // Primary Positive-Edge Clock
        .WEB(we_ni  ),  // Primary Write Enable, Active Low
        .OEB(req_ni ),  // Primary Output Enable, Active Low
        .CSB(req_ni ),  // Primary Chip Select, Active Low
        .I  (wdata_i[0][31:0]),  // Primary Input data bus
        .O  (rdata_o_1)  // Primary Output data bus
        // // for low power
        // .LS ('0   ),  // Primary Light Sleep, Active High
        // .DS ('0   ),  // Primary Deep Sleep, Active High
        // .SD ('0   )   // Primary Shut Down, Active High
    );
    SRAM1RW64x32 tc_sram_inst_2 (
        .A  (addr_i ),  // Primary Read/Write Address
        .CE (clk_i  ),  // Primary Positive-Edge Clock
        .WEB(we_ni  ),  // Primary Write Enable, Active Low
        .OEB(req_ni ),  // Primary Output Enable, Active Low
        .CSB(req_ni ),  // Primary Chip Select, Active Low
        .I  (wdata_i[0][63:32]),  // Primary Input data bus
        .O  (rdata_o_2)  // Primary Output data bus
    );
    assign rdata_o = {rdata_o_2, rdata_o_1};
`else
    tc_sram #(
      .NumWords   (NumWords ),
      .DataWidth  (DataWidth),
      .NumPorts   (NumPorts ),
      .ByteWidth  (ByteWidth),
      .Latency    (Latency  ),
      .SimInit    (SimInit  ),
      .PrintSimCfg(PrintSimCfg)
    ) tc_sram_inst (
      .clk_i  (clk_i  ),
      .rst_ni (rst_ni ),
      .req_i  (req_i  ),
      .we_i   (we_i   ),
      .rdata_o(rdata_o),
      .wdata_i(wdata_i),
      .be_i   (be_i   ),
      .addr_i (addr_i )
    );
`endif
endmodule
