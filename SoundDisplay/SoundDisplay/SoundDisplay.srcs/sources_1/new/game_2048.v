`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2021 21:41:24
// Design Name: 
// Module Name: game_2048
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


module game_2048(
    input clk,
    input clk_50hz,
    input clk_381hz,
    input up,
    input down,
    input left,
    input right,
    input centre,
    input start,
    input [6:0] x,
    input [5:0] y,
    input [11:0] mic_in,
    output reg [15:0] oled_data,
    output [7:0] seg,
    output [3:0] an
    );
    
    wire [15:0] border_data;
    wire [15:0] grid_data;
    
    border_2048 border (x, y, border_data);
    
    reg reset = 0;
    reg undo = 0;
    
    wire [11:0] peak;
            
    peak_algorithm peak_value (clk, mic_in, peak);
    
    always @ (posedge clk_50hz)
    begin
        if (centre == 1)
            reset <= 1;
        else if (peak > 3840)
            undo <= 1;
        else
            begin
                reset <= 0;
                undo <= 0;
            end
    end
    
    wire game_over;
    wire win;
    wire [31:0] score;
    
    logic_2048 logic (clk, clk_50hz, start, reset, undo, up, down, left, right, x, y, grid_data, game_over, win, score);
    
    score_display (clk_381hz, score, seg, an);
    
    
    wire vert_bar1;
    wire vert_bar2;
    wire vert_bar3;
    wire vert_bar4;
    wire vert_bar5;
    wire horiz_bar1;
    wire horiz_bar2;
    wire horiz_bar3;
    wire horiz_bar4;
    wire horiz_bar5;
    
    assign vert_bar1 = (x == 0 || x == 1 || x == 2);
    assign vert_bar2 = (x == 24 || x == 25);
    assign vert_bar3 = (x == 47 || x == 48);
    assign vert_bar4 = (x == 70 || x == 71);
    assign vert_bar5 = (x == 93 || x == 94 || x == 95);
    assign horiz_bar1 = (y == 0 || y == 1 || y == 2);
    assign horiz_bar2 = (y == 16 || y == 17);
    assign horiz_bar3 = (y == 31 || y == 32);
    assign horiz_bar4 = (y == 46 || y == 47);
    assign horiz_bar5 = (y == 61 || y == 62 || y == 63);
    
    wire combined;
    
    assign combined = vert_bar1 || vert_bar2 || vert_bar3 || vert_bar4 || vert_bar5 || horiz_bar1 || horiz_bar2 || horiz_bar3 || horiz_bar4 || horiz_bar5;
    
    
    always @ (posedge clk)
    begin
        if (win)
            oled_data <= `GREEN;
        else if (game_over)
            oled_data <= `BLACK;
        else
            oled_data <= combined ? border_data : grid_data;
    end
    
endmodule
