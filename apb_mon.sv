// Monitor 
class apb_mon;
  virtual apb_intrf vif;
  mailbox mon2scb;

  function new(virtual apb_intrf vif, mailbox mon2scb);
    this.vif = vif;
    this.mon2scb = mon2scb;
  endfunction

  task main;
    apb_tx trans;
    forever begin
      trans = new();
      @(posedge vif.pclk);
      if (vif.pselx && vif.penable) begin
        trans.paddr   = vif.paddr;
        trans.pwrite  = vif.pwrite;
        trans.pwdata  = vif.pwdata;
        trans.penable = vif.penable;
        trans.pselx   = vif.pselx;
        trans.prdata  = vif.prdata;
        mon2scb.put(trans);
        trans.display("MON");
      end
    end
  endtask
endclass

