module counter (
  input        clock,
  input        resetn,    
  input        load,
  input        up_down,      
  input  [3:0] din,
  output reg [3:0] count
);

  always @(posedge clock or negedge resetn) begin
    if (!resetn)
      count <= 4'd0;

    else if (load)
      count <= din; 

    else if (!up_down) begin              
      if (count == 4'd12)
        count <= 4'd0;
      else
        count <= count + 1;
    end

    else begin                             
      if (count == 4'd0)
        count <= 4'd12;
      else
        count <= count - 1;
    end
  end

endmodule
