`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.03.2021 23:05:24
// Design Name: 
// Module Name: oled_volume
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


module oled_volume(
    input [11:0] peak,
    input [6:0] x,
    input [5:0] y,
    input [7:0] shift,
    input [15:0] background,
    input [15:0] low,
    input [15:0] mid,
    input [15:0] high,
    output reg [15:0] oled
    );
    
    wire x_bar;
    wire [15:0] y_bar;
    
    assign x_bar = (x >= (40 + shift - 48) && x <= (55 + shift - 48));
    
    assign y_bar[0] = 0;
    assign y_bar[1] = (y >= 57 && y <= 58);
    assign y_bar[2] = (y >= 54 && y <= 55);
    assign y_bar[3] = (y >= 51 && y <= 52);
    assign y_bar[4] = (y >= 48 && y <= 49);
    assign y_bar[5] = (y >= 45 && y <= 46);
    assign y_bar[6] = (y >= 42 && y <= 43);
    assign y_bar[7] = (y >= 39 && y <= 40);
    assign y_bar[8] = (y >= 36 && y <= 37);
    assign y_bar[9] = (y >= 33 && y <= 34);
    assign y_bar[10] = (y >= 30 && y <= 31);
    assign y_bar[11] = (y >= 27 && y <= 28);
    assign y_bar[12] = (y >= 24 && y <= 25);
    assign y_bar[13] = (y >= 21 && y <= 22);
    assign y_bar[14] = (y >= 18 && y <= 19);
    assign y_bar[15] = (y >= 15 && y <= 16);
    
    always @ (*)
    begin
        if (peak < 2048)
            begin
                oled <= background;
            end
        else if (peak < 2176)
            begin
                if (x_bar && y_bar[0])
                    oled <= low;
                else
                    oled <= background;
            end
        else if (peak < 2304)
            begin
                if (x_bar && y_bar[1])
                    oled <= low;
                else
                    oled <= background;
            end
        else if (peak < 2432)
            begin
                if (x_bar && y_bar[2:1])
                    oled <= low;
                else
                    oled <= background;
            end
        else if (peak < 2560)
            begin
                if (x_bar && y_bar[3:1])
                    oled <= low;
                else
                    oled <= background;
            end
        else if (peak < 2688)
            begin
                if (x_bar && y_bar[4:1])
                    oled <= low;
                else
                    oled <= background;
            end
        else if (peak < 2816)
            begin
                if (x_bar && y_bar[5:1])
                    oled <= low;
                else
                    oled <= background;
            end
        else if (peak < 2944)
            begin
                if (x_bar && y_bar[5:1])
                    oled <= low;
                else if (x_bar && y_bar[6])
                    oled <= mid;
                else
                    oled <= background;
            end
        else if (peak < 3072)
            begin
                if (x_bar && y_bar[5:1])
                    oled <= low;
                else if (x_bar && y_bar[7:6])
                    oled <= mid;
                else
                    oled <= background;
            end
        else if (peak < 3200)
            begin
                if (x_bar && y_bar[5:1])
                    oled <= low;
                else if (x_bar && y_bar[8:6])
                    oled <= mid;
                else
                    oled <= background;
            end
        else if (peak < 3328)
            begin
                if (x_bar && y_bar[5:1])
                    oled <= low;
                else if (x_bar && y_bar[9:6])
                    oled <= mid;
                else
                    oled <= background;
            end
        else if (peak < 3456)
            begin
                if (x_bar && y_bar[5:1])
                    oled <= low;
                else if (x_bar && y_bar[10:6])
                    oled <= mid;
                else
                    oled <= background;
            end
        else if (peak < 3584)
            begin
                if (x_bar && y_bar[5:1])
                    oled <= low;
                else if (x_bar && y_bar[10:6])
                    oled <= mid;
                else if (x_bar && y_bar[11])
                    oled <= high;
                else
                    oled <= background;
            end
        else if (peak < 3712)
            begin
                if (x_bar && y_bar[5:1])
                    oled <= low;
                else if (x_bar && y_bar[10:6])
                    oled <= mid;
                else if (x_bar && y_bar[12:11])
                    oled <= high;
                else
                    oled <= background;
            end
        else if (peak < 3840)
            begin
                if (x_bar && y_bar[5:1])
                    oled <= low;
                else if (x_bar && y_bar[10:6])
                    oled <= mid;
                else if (x_bar && y_bar[13:11])
                    oled <= high;
                else
                    oled <= background;
            end
        else if (peak < 3968)
            begin
                if (x_bar && y_bar[5:1])
                    oled <= low;
                else if (x_bar && y_bar[10:6])
                    oled <= mid;
                else if (x_bar && y_bar[14:11])
                    oled <= high;
                else
                    oled <= background;
            end
        else if (peak <= 4095)
            begin
                if (x_bar && y_bar[5:1])
                    oled <= low;
                else if (x_bar && y_bar[10:6])
                    oled <= mid;
                else if (x_bar && y_bar[15:11])
                    oled <= high;
                else
                    oled <= background;
            end
        else
            oled <= background;
    end

endmodule
