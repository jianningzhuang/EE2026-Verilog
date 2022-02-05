`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.03.2021 22:03:31
// Design Name: 
// Module Name: x_y_converter
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


module x_y_converter(
    input [12:0] pixel_index,
    output [6:0] x,
    output [5:0] y
    );
    
    assign x = pixel_index % 96;
    assign y = pixel_index / 96;
endmodule
