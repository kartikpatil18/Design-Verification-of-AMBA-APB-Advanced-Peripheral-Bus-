// Driver 
class apb_drv;
  apb_tx trans;
  mailbox gen2drv;
  virtual apb_intrf vif;

  function new(mailbox gen2drv, virtual apb_intrf vif);
    this.gen2drv = gen2drv;
    this.vif = vif;
  endfunction

  task reset;
    wait (!vif.prst);
    $display("Reset started");
    vif.pselx   <= 0;
    vif.penable <= 0;
    vif.pwrite  <= 0;
    vif.paddr   <= 0;
    vif.pwdata  <= 0;
    wait (vif.prst);
    $display("Reset completed");
  endtask

  task write();
    vif.pselx   <= 1;
    @(posedge vif.pclk);
    vif.penable <= 0;
    vif.pwrite  <= 1;
    vif.paddr   <= trans.paddr;
    vif.pwdata  <= trans.pwdata;

    @(posedge vif.pclk);
    vif.penable <= 1;

    @(posedge vif.pclk);
    vif.pselx   <= 0;
    vif.penable <= 0;
  endtask

  task read();
    vif.pselx   <= 1;
    @(posedge vif.pclk);
    vif.penable <= 0;
    vif.pwrite  <= 0;
    vif.paddr   <= trans.paddr;

    @(posedge vif.pclk);
    vif.penable <= 1;

    @(posedge vif.pclk);
    vif.pselx   <= 0;
    vif.penable <= 0;
  endtask

  task drive;
    repeat (5) begin
      gen2drv.get(trans);
      write();
      read();
    end
  endtask  

  task main;
    @(posedge vif.pclk);
    drive();
  endtask
endclass

