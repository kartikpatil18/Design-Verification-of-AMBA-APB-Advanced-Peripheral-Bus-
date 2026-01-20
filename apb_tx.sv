// Transaction 
class apb_tx;
  rand bit penable;
  rand bit pwrite;
  rand bit [31:0] pwdata;
  rand bit [31:0] paddr;
  rand bit pselx;
  bit pready;
  bit pslverr;
  bit [31:0] prdata;

  constraint c1 { paddr < 10; pwdata < 100; }

  function void display(string name);
    $display("[%0t] [%s] penable=%0d, pwrite=%0d, paddr=%0d, pwdata=%0d, prdata=%0d", 
             $time, name, penable, pwrite, paddr, pwdata, prdata);
  endfunction
endclass

