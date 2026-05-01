class test;

  virtual count_if.DRV_MP drv_if;
  virtual count_if.WR_MON_MP wrmon_if;
  virtual count_if.RD_MON_MP rdmon_if;

  count_env env_h;

  function new(virtual count_if.DRV_MP drv_if,
               virtual count_if.WR_MON_MP wrmon_if,
               virtual count_if.RD_MON_MP rdmon_if);
    this.drv_if = drv_if;
    this.wrmon_if = wrmon_if;
    this.rdmon_if = rdmon_if;
    env_h = new(drv_if, wrmon_if, rdmon_if);
  endfunction

  virtual task build();
    env_h.build();
  endtask

  virtual task run();
    env_h.run();
  endtask

endclass

