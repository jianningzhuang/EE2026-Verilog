`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2021 13:18:30
// Design Name: 
// Module Name: led_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module led_controller(
    input CLOCK,
    input clk_20khz,
    input sw,
    input [11:0] mic_in,
    output reg [15:0] LED
    );
    
    wire [11:0] peak;
    
    peak_algorithm peak_value (clk_20khz, mic_in, peak);
    
    always @ (posedge CLOCK)
    begin
        if (sw == 1)
            begin
                if (peak < 2048)
                    LED <= 16'b0000000000000000;
                else if (peak < 2176)
                    LED <= 16'b0000000000000001;
                else if (peak < 2304)
                    LED <= 16'b0000000000000011;
                else if (peak < 2432)
                    LED <= 16'b0000000000000111;
                else if (peak < 2560)
                    LED <= 16'b0000000000001111;
                else if (peak < 2688)
                    LED <= 16'b0000000000011111;
                else if (peak < 2816)
                    LED <= 16'b0000000000111111;
                else if (peak < 2944)
                    LED <= 16'b0000000001111111;
                else if (peak < 3072)
                    LED <= 16'b0000000011111111;
                else if (peak < 3200)
                    LED <= 16'b0000000111111111;
                else if (peak < 3328)
                    LED <= 16'b0000001111111111;
                else if (peak < 3456)
                    LED <= 16'b0000011111111111;
                else if (peak < 3584)
                    LED <= 16'b0000111111111111;
                else if (peak < 3712)
                    LED <= 16'b0001111111111111;
                else if (peak < 3840)
                    LED <= 16'b0011111111111111;
                else if (peak < 3968)
                    LED <= 16'b0111111111111111;
                else if (peak <= 4095)
                    LED <= 16'b1111111111111111;
                else
                    LED <= 16'b0000000000000000;
            end
        else
            LED <= mic_in;
    end
endmodule
