class count_drv;
  
  virtual count_if.DRV_MP drv_if;
  
  count_trans data2drv;
  
  mailbox #(count_trans) gen2drv;
  
  function new(virtual count_if.DRV_MP drv_if, mailbox #(count_trans) gen2drv);
    this.drv_if = drv_if;
    this.gen2drv = gen2drv;
  endfunction
  
  virtual task drive();
    @(drv_if.drv_cb);
    drv_if.drv_cb.load    <= data2drv.load;
    drv_if.drv_cb.data_in <= data2drv.data_in;
    drv_if.drv_cb.up_down <= data2drv.up_down;
    drv_if.drv_cb.resetn  <= data2drv.resetn;
    data2drv.display ("DRV");
   // ->drv;
    //->mon;
   //@(drv_if.drv_cb);
  endtask
  
  virtual task start();
    fork
      begin
        forever
          begin
            gen2drv.get(data2drv);
            drive();
          end
      end
    join_none
  endtask
endclass
