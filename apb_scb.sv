// Scoreboard 
class apb_scb;
  mailbox mon2scb;
  bit [31:0] mem[64];

  function new(mailbox mon2scb);
    this.mon2scb = mon2scb;
    foreach (mem[i]) mem[i] = 0;
  endfunction

  task main;
    apb_tx trans;
    forever begin
      #5;
      mon2scb.get(trans);
      if (trans.pwrite) begin
        mem[trans.paddr] = trans.pwdata;
      end else begin
        if (mem[trans.paddr] !== trans.prdata)
          $display("ERROR: READ MISMATCH @%0d: Expected %0d, Got %0d", trans.paddr, mem[trans.paddr], trans.prdata);
else
  $display("PASS : READ MATCH    @%0d: %0d", trans.paddr, trans.prdata);
    end
    end
  endtask
endclass


