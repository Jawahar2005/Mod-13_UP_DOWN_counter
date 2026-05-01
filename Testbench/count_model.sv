class count_model;
  
  count_trans count_h;
  
  static logic [3:0] ref_count = 0;
  
  mailbox #(count_trans) mon2rm;
  mailbox #(count_trans) rm2sb;
  
  function new(mailbox #(count_trans) mon2rm, mailbox #(count_trans) rm2sb);
    this.mon2rm = mon2rm;
    this.rm2sb  = rm2sb;
  endfunction
  
  virtual task count_mod(count_trans model_count);
    if (!model_count.resetn) 
      ref_count <= 4'd0;
    else if(model_count.load)
      ref_count <= model_count.data_in;
    else if(!model_count.up_down)
      begin
        if(ref_count == 12)
          ref_count <= 4'd0;
        else 
          ref_count <= ref_count+1'b1;
      end
    else if(model_count.up_down)
      begin
        if(ref_count == 0)
          ref_count <= 4'd12;
        else
          ref_count <= ref_count - 1'b1;
      end
    
    $display ("%0t Count - %0d - From Ref Model", $time,ref_count);
  endtask
  
  virtual task start();
    fork
      begin
        forever 
          begin
            mon2rm.get(count_h);
            count_mod(count_h);
            count_h.count = ref_count;
            rm2sb.put (count_h);
          end
      end
    join_none
  endtask
  
  
endclass
