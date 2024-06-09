module counter(clkup,up,down,reset,pcount,full_flag,empty_flag);
  input clkup,up,down,reset;
  output [3:0]pcount;
  output full_flag, empty_flag;
  
  reg [3:0]pcount=0;

  reg full_flag=0;
  reg empty_flag=0;
  
  always @(posedge clkup or  posedge reset)
  begin 
    if(reset)
      begin
        pcount<=0;
        full_flag<=0;
        empty_flag<=1;

      end

    else if(up==1)
    begin 
		if(clkup)
		begin
         if(pcount==7)
           begin

           full_flag<=1;
            end
         else
          begin
             pcount<=pcount+1;

             empty_flag<=0;
           if(pcount==7)
               full_flag<=1;
           else
              full_flag<=0;
          end
		  end
      end
      else if(down==1) 
		begin 
        if(pcount==0)
          begin

           empty_flag<=1;
           end
        else
        begin
          pcount<=pcount-1;

          full_flag<=0;
          if(pcount==0)
             empty_flag<=1;
          else
             empty_flag<=0;
         end
      end
  end
endmodule
            

//Test-Case//

module counter_dut();
  reg clkup,up,down,reset;
wire [3:0]pcount;
wire full_flag,empty_flag;

initial
begin
clkup=0;
up=1;
down=0;
reset=1; #100;
reset=0;
end
always 
#50 clkup=~clkup;
always
#900 up=~up;
always
#900 down=~down;
  
counter cc(clkup,up,down,reset,pcount,full_flag,empty_flag);

endmodule
    
    
              
  
  
