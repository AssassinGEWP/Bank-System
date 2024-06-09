module ff(clk, d, q);
  
  input clk, d;
  output reg q;
  
  always @(posedge clk)
  q <= d;
  
endmodule


module ff_dut();
  
  reg d;
  reg clk;
  wire q;
  
  initial
  begin
    d = 0;
    clk = 0;
  end
  
  always
  #50
  clk = ~clk;
  
  always
  #100
  d = ~d;
  
  ff f(clk, d, p);
  
endmodule
