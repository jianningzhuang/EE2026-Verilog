`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2021 21:43:33
// Design Name: 
// Module Name: border_2048
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

module border_2048(
    input [6:0] x,
    input [5:0] y,
    output [15:0] oled_data
    );
    
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
    
    assign oled_data = combined ?  `ORANGE : `GREY;
endmodule
