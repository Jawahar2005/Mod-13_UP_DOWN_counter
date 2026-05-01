class count_rd_mon;
  
  virtual count_if.RD_MON_MP rdmon_if;
  
  count_trans data2sb;
  count_trans wr_data;
  
  mailbox #(count_trans) mon2sb;
  
  function new(virtual count_if.RD_MON_MP rdmon_if, 
               mailbox #(count_trans) mon2sb);
    this.rdmon_if = rdmon_if;
    this.mon2sb   = mon2sb;
    this.wr_data  = new;
  endfunction
  
  virtual task monitor();
   // wait(mon.triggered);
    @(rdmon_if.rd_cb);  
    wr_data.count = rdmon_if.rd_cb.count;
    wr_data.display ("From Read Monitor");
    
  endtask
  
  virtual task start();
  	fork
      begin
        forever 
          begin
            monitor();
            data2sb = new wr_data;
            mon2sb.put(data2sb);
          end
      end
    join_none
  endtask
  
endclass
