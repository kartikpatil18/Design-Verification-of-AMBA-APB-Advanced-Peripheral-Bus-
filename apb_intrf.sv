// Interface

interface apb_intrf(input logic pclk);
  logic prst;
  logic [31:0] paddr;
  logic pselx;
  logic penable;
  logic pwrite;
  logic [31:0] pwdata;
  logic pready;
  logic pslverr;
  logic [31:0] prdata;

endinterface


