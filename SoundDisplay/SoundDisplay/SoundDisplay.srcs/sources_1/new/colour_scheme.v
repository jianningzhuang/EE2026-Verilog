`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 17.03.2021 23:54:01
// Design Name: 
// Module Name: colour_scheme
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

module colour_scheme(
    input sw1,
    input sw2,
    output reg [15:0] background,
    output reg [15:0] border,
    output reg [15:0] low,
    output reg [15:0] mid,
    output reg [15:0] high
    );
    
    always @ (*)
    begin
        if (sw1 && sw2) //new colour and vol bar
            begin
                background <= `BLUE;
                border <= `ORANGE;
                low <= `BLACK;
                mid <= `GREY;
                high <= `WHITE;
            end
        else if (sw1 && ~sw2) //new colour and no vol bar
            begin
                background <= `BLUE;
                border <= `ORANGE;
                low <= `BLUE;
                mid <= `BLUE;
                high <= `BLUE;
            end
        else if (~sw1 && sw2) //normal colour and vol bar
            begin
                background <= `BLACK;
                border <= `WHITE;
                low <= `GREEN;
                mid <= `YELLOW;
                high <= `RED;
            end
        else if (~sw1 && ~sw2) //normal colour and no vol bar
            begin
                background <= `BLACK;
                border <= `WHITE;
                low <= `BLACK;
                mid <= `BLACK;
                high <= `BLACK;
            end
    end
endmodule
