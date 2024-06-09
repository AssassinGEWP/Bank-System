module clock_divider (clk, reset, slow_clk);
  input clk, reset;
  output slow_clk;
  
  reg slow_clk;
  reg [17:0]count;
  
  always @(posedge clk or posedge reset)
  begin
    if(reset)
      begin
        count <= 0;
        slow_clk <= 0;
      end
    else
      begin
        if(count < 100_000_000)
          count <= count + 1;
        else
          begin
            slow_clk = ~slow_clk;
            count <= 0;
          end
        end
      end
    endmodule
    
module clock_divider_dut();
  reg clk, reset;
  wire slow_clk;
  
  initial
  begin
    clk = 0;
    reset = 1; #100;
    reset = 0;
  end
  always
  #100
  clk = ~clk;
  
  clock_divider cd(clk, reset, slow_clk);

endmodule
    
