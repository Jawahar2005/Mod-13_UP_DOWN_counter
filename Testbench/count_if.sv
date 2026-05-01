interface count_if(input bit clock);

  // Interface signals
  logic resetn; 
  logic up_down;
  logic load;
  logic [3:0] data_in;
  logic [3:0] count;

  // Driver CB
  clocking drv_cb@(posedge clock);
    default input #1 output #1;
    output load;
    output up_down;
    output resetn;
    output data_in;
  endclocking

  // Write_mon CB
  clocking wr_cb@(posedge clock);
    default input #1 output #1;
    input data_in;
    input load;
    input up_down;
    input resetn;
  endclocking

  // Read_mon CB
  clocking rd_cb@(posedge clock);
    default input #1 output #1;
    input count;
  endclocking

  // Driver 
  modport DRV_MP(clocking drv_cb);

  // Write Mon
  modport WR_MON_MP(clocking wr_cb);

  // Read Mon
  modport RD_MON_MP(clocking rd_cb);  
endinterface
