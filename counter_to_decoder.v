module counter_to_decoder(clkup,up,down,reset,tcount,clk,pcount,wtime1,wtime2,full_flag,empty_flag);
  
  input clkup,up,down,reset,clk;
  input [1:0]tcount;
  output full_flag,empty_flag;
  output [6:0]pcount,wtime1,wtime2;
  
  wire [7:0]wtime;
  wire [3:0]count;
  
  counter counter1(clk,up,down,reset,count,full_flag,empty_flag);
  rom rom1(count,tcount,wtime);
  decoder_to_7seg decode1(count[3],count[2],count[1],count[0],pcount[6],pcount[5],pcount[4],pcount[3],pcount[2],pcount[1],pcount[0]);
  decoder_to_7seg decode2(wtime[3],wtime[2],wtime[1],wtime[0],wtime1[6],wtime1[5],wtime1[4],wtime1[3],wtime1[2],wtime1[1],wtime1[0]);
  decoder_to_7seg decode3(wtime[7],wtime[6],wtime[5],wtime[4],wtime2[6],wtime2[5],wtime2[4],wtime2[3],wtime2[2],wtime2[1],wtime2[0]);
  
endmodule

module counter_to_decoder_dut();
  
  reg clkup,up,down,clk,reset;
  reg  [1:0] tcount;
  
  wire [6:0] pcount; //output on sevensegment 1
  wire [6:0]wtime1;  //output on sevensegment 2
  wire [6:0]wtime2;  //output on sevensegment 3
  wire full_flag, empty_flag;
  
  initial
  begin
    clk = 0;
    tcount = 2'b01;//tailer equal 1
    clkup = 0;
    up= 1;
    down=0;
    reset=1; #100;//reset is on and delay 100
    reset=0;//reset is off
    tcount=2'b01;
  end
  
  always
  #50
  clkup = ~clkup;
  always
  #900
  up= ~up; //up =1 after 900 down=0
  always
  #900
  down= ~down; //down =0 after 900 down=1
  always
  #50
  clk = ~clk;
  
  counter_to_decoder top(clkup,up,down,reset,tcount,clk,pcount,wtime1,wtime2,full_flag,empty_flag);
  
endmodule
  