// Generator 
class apb_gen;
  apb_tx trans;
  mailbox gen2drv;

  function new(mailbox gen2drv);
    this.gen2drv = gen2drv;
  endfunction

  task main;
    repeat (5) begin
      trans = new();
      if (!trans.randomize())
        $display("Randomization Failed");
      trans.display("GEN");
      gen2drv.put(trans);
    end
  endtask
endclass

