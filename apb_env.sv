// Environment
class environment;
  apb_gen gen;
  apb_drv drv;
  apb_mon mon;
  apb_scb scb;

  mailbox gen2drv;
  mailbox mon2scb;
  virtual apb_intrf vif;

  function new(virtual apb_intrf vif);
    this.vif = vif;
    gen2drv = new();
    mon2scb = new();
    gen = new(gen2drv);
    drv = new(gen2drv, vif);
    mon = new(vif, mon2scb);
    scb = new(mon2scb);
  endfunction

  task run;
    fork
      gen.main();
      drv.main();
      mon.main();
      scb.main();
    join
  endtask
endclass


