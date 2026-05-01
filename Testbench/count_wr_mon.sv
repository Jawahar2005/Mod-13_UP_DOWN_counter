class count_wr_mon;
  
  virtual count_if.WR_MON_MP wrmon_if;
  
  count_trans wr_data;
  count_trans data2rm;
  
  mailbox #(count_trans) mon2rm;
  
  function new( virtual count_if.WR_MON_MP wrmon_if, mailbox #(count_trans) mon2rm);
    this.mon2rm   = mon2rm;
    this.wrmon_if = wrmon_if;
    this.wr_data  = new();
  endfunction
  
  virtual task monitor();
   // wait(drv.triggered);
    @(wrmon_if.wr_cb);
    wr_data.up_down = wrmon_if.wr_cb.up_down;
    wr_data.load    = wrmon_if.wr_cb.load;
    wr_data.data_in = wrmon_if.wr_cb.data_in;
    wr_data.resetn  = wrmon_if.wr_cb.resetn;
    
    wr_data.display ("From Write Monitor");
  endtask
  
  virtual task start();
    fork
      begin
        forever
          begin
            monitor();
            data2rm = new wr_data;
            mon2rm.put(data2rm);
          end
      end
    join_none
  endtask
endclass
