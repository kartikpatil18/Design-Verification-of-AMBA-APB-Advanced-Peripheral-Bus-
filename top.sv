//TOP

module top;

  logic pclk;
  logic prst;

  // Clock Generation
  initial begin
    pclk = 0;
    forever #5 pclk = ~pclk;
  end

  // Reset Generation
  initial begin
    prst = 0;
    #15 prst = 1;
    #2000 $finish;
  end

  // Interface Instance
  apb_intrf intf_i(pclk);
  assign intf_i.prst = prst;

  // DUT instance
  apb_mem dut (
    .pclk    (intf_i.pclk),
    .prst    (intf_i.prst),
    .paddr   (intf_i.paddr),
    .pselx   (intf_i.pselx),
    .penable (intf_i.penable),
    .pwrite  (intf_i.pwrite),
    .pwdata  (intf_i.pwdata),
    .pready  (intf_i.pready),
    .pslverr (intf_i.pslverr),
    .prdata  (intf_i.prdata)
  );

  // Environment Instance
  environment env;

  initial begin
    env = new(intf_i);
    env.run();
  end
  

endmodule
