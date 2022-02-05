`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 18.03.2021 09:30:03
// Design Name: 
// Module Name: menu
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

module menu(
    input clk_50hz,
    input up,
    input down,
    input [6:0] x,
    input [5:0] y,
    output reg [15:0] oled_data = `BLACK,
    output reg [2:0] state = 0
    );
    
    wire M, E, N, U, menu;
    
    assign M = (((x >= 26 && x <= 27) || (x >= 38 && x <= 39)) && (y >= 3 && y <= 16)) || (x == 28 && (y >= 5 && y <= 6))
            || (x == 29 && (y >= 6 && y <= 7)) || (x == 30 && (y >= 7 && y <= 8)) || (x == 31 && (y >= 8 && y <= 9)) || ((x >= 32 && x <= 33) && (y >= 9 && y <= 10))
            || (x == 34 && (y >= 8 && y <= 9)) || (x == 35 && (y >= 7 && y <= 8)) || (x == 36 && (y >= 6 && y <= 7)) || (x == 37 && (y >= 5 && y <= 6));
    
    assign E = ((x >= 42 && x <= 43) && (y >= 3 && y <= 16)) || ((x >= 44 && x <= 49) && (y == 3 || y == 4 || y == 9 || y == 10 || y == 15 || y == 16));
    
    assign N = (((x >= 52 && x <= 53) || (x >= 60 && x <= 61)) && (y >= 3 && y <= 16)) || ((x == 53 && (y >= 6 && y <= 7)) 
            || (x == 54 && (y >= 7 && y <= 8)) || (x == 55 && (y >= 8 && y <= 9)) || (x == 56 && (y >= 9 && y <= 10)) 
            || (x == 57 && (y >= 10 && y <= 11)) || (x == 58 && (y >= 11 && y <= 12)));
    
    assign U = (((x >= 64 && x <= 65) || (x >= 70 && x <= 71)) && (y >= 3 && y <= 14)) || ((x >= 66 && x <= 69) && (y >= 15 && y <= 16));
    
    assign menu = M || E || N || U;
    
    wire v, o, l, u, m, e, volume;
    
    assign v = ((y >= 22 && y <= 26) && (x == 12 || x == 16)) || ((x == 13 || x == 15) && y == 27) || (x == 14 && y == 28);
    assign o = ((y >= 23 && y <= 27) && (x == 18 || x == 22)) || ((y == 22 || y == 28) && (x >= 19 && x <= 21));
    assign l = ((y >= 22 && y <= 28) && (x == 24)) || ((x >= 25 && x <= 27) && y == 28);
    assign u = ((y >= 22 && y <= 27) && (x == 29 || x == 32)) || ((x >= 30 && x <= 31) && y == 28);
    assign m = ((y >= 22 && y <= 27) && (x == 34 || x == 38)) || ((x == 35 || x == 37) && y == 23) || (y == 24 && x == 36);
    assign e = ((y >= 22 && y <= 27) && (x == 40)) || ((x >= 40 && x <= 42) && (y == 22 || y == 25 || y == 28));
    
    assign volume = v || o || l || u || m || e;
    
    wire arrow1, arrow2, arrow3, arrow4;
    
    assign arrow1 = (x == 3 && (y >= 23 && y <= 27)) || (x == 4 && (y == 23 || y == 27))  || (x == 5 && (y == 24 || y == 26)) || (x == 6 && y == 25);
    assign arrow2 = (x == 3 && (y >= 33 && y <= 37)) || (x == 4 && (y == 33 || y == 37))  || (x == 5 && (y == 34 || y == 36)) || (x == 6 && y == 35);
    assign arrow3 = (x == 3 && (y >= 43 && y <= 47)) || (x == 4 && (y == 43 || y == 47))  || (x == 5 && (y == 44 || y == 46)) || (x == 6 && y == 45);
    assign arrow4 = (x == 3 && (y >= 53 && y <= 57)) || (x == 4 && (y == 53 || y == 57))  || (x == 5 && (y == 54 || y == 56)) || (x == 6 && y == 55);
    
    wire highlight1, highlight2, highlight3, highlight4;
    
    assign highlight1 = (y >= 21 && y <= 29) && (x >= 0 && x <= 95) && ~volume && ~arrow1;
    assign highlight2 = (y >= 31 && y <= 39) && (x >= 0 && x <= 95) && ~arrow2;
    assign highlight3 = (y >= 41 && y <= 49) && (x >= 0 && x <= 95) && ~arrow3;
    assign highlight4 = (y >= 51 && y <= 59) && (x >= 0 && x <= 95) && ~arrow4;
    
    always @ (posedge clk_50hz)
    begin
        if (state > 0 && up)
            state <= state - 1;
        else if (state < 4 && down)
            state <= state + 1;
        else
            state <= state;
    end
    
    always @ (*)
    begin
        if (state == 0)
            oled_data <= (menu || volume) ? `WHITE : `BLACK;
        else if (state == 1)
            oled_data <= (menu || highlight1) ? `WHITE : `BLACK;
        else if (state == 2)
            oled_data <= (menu || volume || highlight2) ? `WHITE : `BLACK;
        else if (state == 3)
            oled_data <= (menu || volume || highlight3) ? `WHITE : `BLACK;
        else if (state == 4)
            oled_data <= (menu || volume || highlight4) ? `WHITE : `BLACK;
    end
    
endmodule
