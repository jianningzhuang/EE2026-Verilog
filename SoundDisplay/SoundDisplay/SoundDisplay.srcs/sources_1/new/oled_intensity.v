`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.03.2021 22:11:58
// Design Name: 
// Module Name: oled_intensity
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


module oled_intensity(
    input CLOCK,
    input clk_50hz,
    input [11:0] mic_in,
    input [5:0] sw,
    input left_press,
    input right_press,
    input up_press,
    input [6:0] x,
    input [5:0] y,
    output reg [15:0] oled_data
    );
    
    wire [1:0] border_width;
    
    assign border_width = sw[5] ? (sw[4] ? 3 : 1) : 0;
    
    wire [15:0] background_colour, border_colour, low_colour, mid_colour, high_colour;
    
    colour_scheme colour (sw[3], sw[2], background_colour, border_colour, low_colour, mid_colour, high_colour);
    
    wire [15:0] border_data;
    
    oled_border border (border_width, x, y, background_colour, border_colour, border_data);
    
    wire [11:0] peak;
        
    peak_algorithm peak_value (CLOCK, mic_in, peak);
    
    wire [15:0] volume_data;
    reg [7:0] shift = 48;
    
    oled_volume volume (peak, x, y, shift, background_colour, low_colour, mid_colour, high_colour, volume_data);
    
    always @ (posedge clk_50hz)
    begin
        if (up_press == 1)
            shift <= 48;
        else if (left_press == 1)
            shift <= (shift == 13) ? shift : shift - 1;
        else if (right_press == 1)
            shift <= (shift == 83) ? shift : shift + 1;
        else
            shift <= shift;
    end
    
    always @ (*)
    begin
        oled_data <= (x < border_width || x >= (96 - border_width) || y < border_width || y >= (64 - border_width)) ? border_data : volume_data;
    end
endmodule
