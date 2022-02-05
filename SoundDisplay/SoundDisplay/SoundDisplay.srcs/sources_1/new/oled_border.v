`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.03.2021 23:01:03
// Design Name: 
// Module Name: oled_border
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


module oled_border(
    input [1:0] border_width,
    input [6:0] x,
    input [5:0] y,
    input [15:0] background,
    input [15:0] border,
    output reg [15:0] oled_data
    );
    
    always @ (*)
    begin
        if (border_width)
            begin
                oled_data <= (x < border_width || x >= (96 - border_width) || y < border_width || y >= (64 - border_width)) ? border : background;
            end
        else
            oled_data <= background;
            
    end

endmodule
