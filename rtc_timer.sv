
//////////////////////////////////////////////////////////////////////////////////
/*--------------------------------------------------------------------------------
  Project: Stopwatch
  Module: 10ms_Timer_V1
  Author:Pengfei He
  Date:June/12/2020
  Module Description:
  Clock divider takes 100Mhz system clock input and 'o_base_tick' should toggled
  every 5 milliseconds after counting a maximum count sequence when enabled.
  Clock divider resets internal counter to its initial value and outputs '0'
  when reset signal is low. 
---------------------------------------------------------------------------------*/

module rtc_timer
  #(parameter integer MAX_COUNT = 500000)/* Counter maximum counting value */
  (
    input  i_sclk,     /* 100 Mhz system clock input*/
    input  i_timerenb, /* Timer enable input signal*/
    input  i_reset_n,  /* Timer reset input signal*/
    output reg o_basetick  /* 100 Hz Output clock signal*/
    );


/* -----Internal Signals Begin-----*/ 
integer counter=1;                     /* Counter initial value*/
reg sclk=1'b0;                        /*  100 Hz initial value*/
/* -----Internal Signals End-----*/ 

always_ff@(posedge i_sclk iff i_reset_n==1'b1 or negedge i_reset_n)
begin : clock_devider
  if(~i_reset_n)
   begin :reset_condition
     counter<=1;
     sclk<=1'b0;
   end:reset_condition
    else
      begin:timer_enable
       if(i_timerenb==1'b1)
        begin:counter_enable
         if(counter==MAX_COUNT)
          begin
            counter<=1;
            sclk<=~sclk;
          end
         else
          begin
          counter<=counter+1;
          end
         end:counter_enable
       end:timer_enable
    end: clock_devider

 assign o_basetick = sclk;  /* o_basetick output*/
 
endmodule