`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2021 14:18:19
// Design Name: 
// Module Name: seven_segment_controller
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


module seven_segment_controller(
    input CLOCK,
    input clk_20khz,
    input [11:0] mic_in,
    input sw,
    output reg [3:0] an,
    output reg [7:0] seg
    );
    
    wire [11:0] peak;
        
    peak_algorithm peak_value (clk_20khz, mic_in, peak);
    
    reg [1:0] count = 0;
    
    always @ (posedge CLOCK)
    begin
        count <= count + 1;
        an <= ~(1 << count);
        if (count == 0)
            begin
                if (peak < 2176)
                    seg <= 8'b11000000;
                else if (peak < 2304)
                    seg <= 8'b11111001;
                else if (peak < 2432)
                    seg <= 8'b10100100;
                else if (peak < 2560)
                    seg <= 8'b10110000;
                else if (peak < 2688)
                    seg <= 8'b10011001;
                else if (peak < 2816)
                    seg <= 8'b10010010;
                else if (peak < 2944)
                    seg <= 8'b10000010;
                else if (peak < 3022)
                    seg <= 8'b11111000;
                else if (peak < 3200)
                    seg <= 8'b10000000;
                else if (peak < 3328)
                    seg <= 8'b10010000;
                else if (peak < 3456)
                    seg <= 8'b11000000;
                else if (peak < 3584)
                    seg <= 8'b11111001;
                else if (peak < 3712)
                    seg <= 8'b10100100;
                else if (peak < 3841)
                    seg <= 8'b10110000;
                else if (peak < 3968)
                    seg <= 8'b10011001;
                else if (peak <= 4095)
                    seg <= 8'b10010010;
                else 
                    seg <= 8'b11111111;
            end
        else if (count == 1)
            begin
                if (peak < 3328)
                    seg <= 8'b11111111;
                else if (peak <= 4095)
                    seg <= 8'b11111001;
                else 
                    seg <= 8'b11111111;
            end
        else if (count == 2)
            seg <= 8'b11111111;
        else if (count == 3)
            begin
                if (sw == 1)
                    begin
                        if (peak < 2688)
                            seg <= 8'b11000111; //L
                        else if (peak < 3456)
                            seg <= 8'b11101010; //M
                        else if (peak <= 4095)
                            seg <= 8'b10001001; //H
                        else
                            seg <= 8'b11000111; //L
                    end
                else
                    seg <= 8'b11111111;
            end
        
    end
endmodule
