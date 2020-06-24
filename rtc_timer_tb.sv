`timescale 10 ms / 1ps

module rtc_timer_tb;

    reg  i_sclk;
    reg  i_timerenb;
    reg  i_reset_n;
    wire o_basetick;
    
    rtc_timer UUT(.i_sclk(i_sclk),
                  .i_timerenb(i_timerenb),
                  .i_reset_n(i_reset_n),
                  .o_basetick(o_basetick));
always
#5 i_sclk = !i_sclk;
                  
initial
begin
i_sclk=0;
i_timerenb=1;                
i_reset_n=1;
#10000 s;

end


initial
begin
$monitor("time=>%0t, output=>%b",$time,o_basetick);
end





endmodule