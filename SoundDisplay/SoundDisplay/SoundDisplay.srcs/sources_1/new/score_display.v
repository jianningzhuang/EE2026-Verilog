`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.03.2021 09:51:22
// Design Name: 
// Module Name: score_display
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


module score_display(
    input clk_381hz,
    input [31:0] score,
    output reg [7:0] seg,
    output reg [3:0] an
    );
    
    reg [1:0] count = 0;
    
    always @ (posedge clk_381hz)
    begin
        count <= count + 1;
        an <= ~(1 << count);
        if (count == 0)
            begin
                if (score%10 == 0)
                    seg <= 8'b11000000;
                else if (score%10 == 2)
                    seg <= 8'b10100100;
                else if (score%10 == 4)
                    seg <= 8'b10011001;
                else if (score%10 == 6)
                    seg <= 8'b10000010;
                else if (score%10 == 8)
                    seg <= 8'b10000000;
            end
        else if (count == 1)
            begin
                if (((score%100)/10) == 0)
                    seg <= 8'b11000000;
                else if (((score%100)/10) == 1)
                    seg <= 8'b11111001;
                else if (((score%100)/10) == 2)
                    seg <= 8'b10100100;
                else if (((score%100)/10) == 3)
                    seg <= 8'b10110000;
                else if (((score%100)/10) == 4)
                    seg <= 8'b10011001;
                else if (((score%100)/10) == 5)
                    seg <= 8'b10010010;
                else if (((score%100)/10) == 6)
                    seg <= 8'b10000010;
                else if (((score%100)/10) == 7)
                    seg <= 8'b11111000;
                else if (((score%100)/10) == 8)
                    seg <= 8'b10000000;
                else if (((score%100)/10) == 9)
                    seg <= 8'b10010000;
            end
        else if (count == 2)
            begin
                if (((score%1000)/100) == 0)
                    seg <= 8'b11000000;
                else if (((score%1000)/100) == 1)
                    seg <= 8'b11111001;
                else if (((score%1000)/100) == 2)
                    seg <= 8'b10100100;
                else if (((score%1000)/100) == 3)
                    seg <= 8'b10110000;
                else if (((score%1000)/100) == 4)
                    seg <= 8'b10011001;
                else if (((score%1000)/100) == 5)
                    seg <= 8'b10010010;
                else if (((score%1000)/100) == 6)
                    seg <= 8'b10000010;
                else if (((score%1000)/100) == 7)
                    seg <= 8'b11111000;
                else if (((score%1000)/100) == 8)
                    seg <= 8'b10000000;
                else if (((score%1000)/100) == 9)
                    seg <= 8'b10010000;
            end
        else if (count == 3)
            begin
                if ((score/1000) == 0)
                    seg <= 8'b11000000;
                else if ((score/1000) == 1)
                    seg <= 8'b11111001;
                else if ((score/1000) == 2)
                    seg <= 8'b10100100;
                else if ((score/1000) == 3)
                    seg <= 8'b10110000;
                else if ((score/1000) == 4)
                    seg <= 8'b10011001;
                else if ((score/1000) == 5)
                    seg <= 8'b10010010;
                else if ((score/1000) == 6)
                    seg <= 8'b10000010;
                else if ((score/1000) == 7)
                    seg <= 8'b11111000;
                else if ((score/1000) == 8)
                    seg <= 8'b10000000;
                else if ((score/1000) == 9)
                    seg <= 8'b10010000;
            end
        
    end
endmodule
