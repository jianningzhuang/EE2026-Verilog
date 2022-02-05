`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2021 11:07:49
// Design Name: 
// Module Name: snake
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
`include "colours.vh"

module snake(
    input clk,
    input clk_50hz,
    input up,
    input down,
    input left,
    input right,
    input centre,
    input start,
    input sw,
    input [6:0] x,
    input [5:0] y,
    input [11:0] mic_in,
    output reg [15:0] oled_data
    );
    
    wire [15:0] border_data;
    wire [15:0] snake_data;
    
    wire [1:0] border_width;
    wire [15:0] background_colour;
    wire [15:0] border_colour;
    
    assign border_width = 3;
    assign background_colour = `BLACK;
    assign border_colour = `WHITE;
        
    oled_border border (border_width, x, y, background_colour, border_colour, border_data);
    
    reg [1:0] direction = 0;
    reg reset = 0;
    reg pause = 0;
    wire game_over;
    
    always @ (posedge clk_50hz)
    begin
        if (up == 1)
            direction <= 0;
        else if (left == 1)
            direction <= 1;
        else if (down == 1)
            direction <= 2;
        else if (right == 1)
            direction <= 3;
        else if (centre == 1 && game_over == 1)
            reset <= 1;
        else if (centre == 1)
            pause <= ~pause;
        else
            reset <= 0;
    end
    
    wire [11:0] peak;
    reg [31:0] speed = 4999999;
                
    peak_algorithm peak_value (clk, mic_in, peak);
    
    always @ (posedge clk)
    begin
        if (sw)
            begin
                if (peak < 2176)
                    speed <= 5499999;
                else if (peak < 2304)
                    speed <= 5199999;
                else if (peak < 2304)
                    speed <= 4899999;
                else if (peak < 2432)
                    speed <= 4599999;
                else if (peak < 2560)
                    speed <= 4299999;
                else if (peak < 2688)
                    speed <= 3999999;
                else if (peak < 2816)
                    speed <= 3699999;
                else if (peak < 2944)
                    speed <= 3399999;
                else if (peak < 3072)
                    speed <= 3099999;
                else if (peak < 3200)
                    speed <= 2799999;
                else if (peak < 3328)
                    speed <= 2499999;
                else if (peak < 3456)
                    speed <= 2199999;
                else if (peak < 3584)
                    speed <= 1899999;
                else if (peak < 3712)
                    speed <= 1599999;
                else if (peak < 3840)
                    speed <= 1299999;
                else if (peak < 3968)
                    speed <= 999999;
                else if (peak <= 4095)
                    speed <= 699999;
            end
    end
    
    
    snake_logic logic (clk, start, reset, pause, direction, x, y, speed, snake_data, game_over);
    
    always @ (*)
    begin
        if (game_over)
            oled_data <= `RED;
        else
            oled_data <= (x < border_width || x >= (96 - border_width) || y < border_width || y >= (64 - border_width)) ? border_data : snake_data;
    end
    
    
endmodule
