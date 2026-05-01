`include "count_if.sv"
`include "count_pkg.sv"

module top;

  import count_pkg::*;

  bit clock;
  always #5 clock = ~clock;

  count_if DUV_IF(clock);

  counter duv (
    .clock   (clock),
    .din     (DUV_IF.data_in),
    .load    (DUV_IF.load),
    .up_down (DUV_IF.up_down),
    .resetn  (DUV_IF.resetn),
    .count   (DUV_IF.count)
  );

  test t_h;

  initial begin
    no_of_transactions = 100;
    t_h = new(DUV_IF, DUV_IF, DUV_IF);
    t_h.build();
    t_h.run();
    $finish;
  end
  
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0);
  end

endmodule
