`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2021 11:23:40
// Design Name: 
// Module Name: snake_logic
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

module snake_logic(
    input clk,
    input start,
    input reset,
    input pause,
    input [1:0] direction,
    input [6:0] x,
    input [5:0] y,
    input [31:0] speed,
    output [15:0] oled_data,
    output reg game_over = 0
    );
    
    reg [6:0] snakeX[0:127];
    reg [5:0] snakeY[0:127];
    reg [127:0] snakeBody;
    reg [6:0] size;
    reg [6:0] appleX = 40;
    reg [5:0] appleY = 10;
    reg [6:0] randX = 0;
    reg [5:0] randY = 0;
    
    reg update;
    integer count;
    
    reg [31:0] counter = 0;
    
    always @ (posedge clk)
    begin
        if (counter >= speed)
            begin
                counter <= 0;
                update <= 1;
            end
        else
            begin
                counter <= counter + 1;
                update <=0;
            end
    end
    
    always @ (posedge clk)
    begin
        if (start || reset)
            begin
                snakeX[0] <= 47;
                snakeY[0] <= 22;

                for (count = 1; count < 128; count = count + 1)
                    begin
                        snakeX[count] <= 95;
                        snakeY[count] <= 63;
                    end
                size <= 1;
                game_over <= 0;
            end
        else if (pause)
            begin
            end
        else if (~game_over)
            begin
                if (update)
                    begin
                        for (count = 1; count < 128; count = count + 1)
                            begin
                                if (size > count)
                                    begin
                                        snakeX[count] <= snakeX[count - 1];
                                        snakeY[count] <= snakeY[count - 1];
                                    end
                            end
                   
                        if (direction == 0)
                            snakeY[0] <= (snakeY[0] - 1); //up
                        else if (direction == 1)
                            snakeX[0] <= (snakeX[0] - 1); //left
                        else if (direction == 2)
                            snakeY[0] <= (snakeY[0] + 1); //down
                        else if (direction == 3)
                            snakeX[0] <= (snakeX[0] + 1); //right   
                    end 
                else
                    begin
                        if ((snakeX[0] <= appleX + 1) && (snakeX[0] >= appleX - 1) && (snakeY[0] <= appleY + 1) && (snakeY[0] >= appleY - 1))
                            begin
                                appleX <= randX;
                                appleY <= randY;
                                if (size < 127)
                                    size <= size + 1;
                            end   
                        else if ((snakeX[0] <= 2) || (snakeX[0] >= 93) || (snakeY[0] <= 2) || (snakeY[0] >= 61))     
                            game_over <= 1;
                        else if (|snakeBody[127:1] && snakeBody[0])
                            game_over <= 1;  
                    end                               
            end
    end
    
    always @ (posedge clk)
    begin
        randX <= ((randX + 3) % 75) + 10;
        randY <= ((randY + 5) % 43) + 10;
    end
    
    reg apple;
    reg [127:0] snake_show;
    
    always @ (posedge clk)
        begin
            apple <= ((x <= appleX + 1) && (x >= appleX - 1)) && ((y <= appleY + 1) && (y >= appleY - 1));
            for (count = 0; count < 128; count = count + 1)
                begin
                    snakeBody[count] <= (x == snakeX[count]) && (y == snakeY[count]);
                    snake_show[count] <= (x <= snakeX[count] + 1) && (x >= snakeX[count] - 1) && (y <= snakeY[count] + 1) && (y >= snakeY[count] - 1);
                end
        end
   
    
    assign oled_data = (apple) ? `RED : (|snake_show ? `GREEN : `BLACK);

endmodule
