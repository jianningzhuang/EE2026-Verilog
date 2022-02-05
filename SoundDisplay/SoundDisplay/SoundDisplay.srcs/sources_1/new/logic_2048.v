`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2021 22:16:38
// Design Name: 
// Module Name: logic_2048
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

module logic_2048(
    input clk,
    input clk_50hz,
    input start,
    input reset,
    input undo,
    input up,
    input down,
    input left,
    input right,
    input [6:0] x,
    input [5:0] y,
    output [15:0] oled_data,
    output reg game_over,
    output reg win,
    output reg [31:0] score
    );
    
    reg [12:0] grid[0:15];
    reg [12:0] prev[0:15];
    
    integer count;
    integer counter;
    integer i;
    integer j;
        
    reg [3:0] randGrid = 0;
    reg different = 0;
    
    reg [31:0] prev_score = 0;
    
    
    always @ (posedge clk_50hz)
    begin
        if (start || reset)
            begin
                for (count = 0; count < 16; count = count + 1)
                    begin
                        grid[count] <= 0;
                        prev[count] <= 0;
                    end
                grid[randGrid] <= 2;
                grid[(randGrid + 9)%16] <= 2;
                game_over <= 0;
                win <= 0;
                different <= 0;
                score <= 0;
            end
        else if (~game_over)
            begin
                if (up == 1)
                    begin
                        for (count = 0; count < 16; count = count + 1)
                            begin
                                prev[count] <= grid[count];
                            end
                        prev_score <= score;
                        counter = 0;
                        for (i = 0; i < 4; i = i + 1)
                            begin
                                for (j = 0; j < 4; j = j + 1)
                                    begin
                                        if (grid[i + 4*j] == 0)
                                            counter = counter + 1;
                                        else if (counter !== 0)
                                            begin
                                                grid[i + 4*j - 4*counter] = grid[i + 4*j];
                                                grid[i + 4*j] = 0;
                                            end
                                        if (j == 3)
                                            counter = 0;
                                    end
                            end
                        for (i = 0; i < 4; i = i + 1)
                            begin
                                for (j = 0; j < 3; j = j + 1)
                                    begin
                                        if (grid[i + 4*j] == grid[i + 4*j + 4] && grid[i + 4*j] !== 0)
                                            begin
                                                grid[i + 4*j] = 2*grid[i + 4*j];
                                                grid[i + 4*j + 4] = 0;
                                                score <= score + grid[i + 4*j];
                                            end
                                    end
                            end
                        counter = 0;
                        for (i = 0; i < 4; i = i + 1)
                            begin
                                for (j = 0; j < 4; j = j + 1)
                                    begin
                                        if (grid[i + 4*j] == 0)
                                            counter = counter + 1;
                                        else if (counter !== 0)
                                            begin
                                                grid[i + 4*j - 4*counter] = grid[i + 4*j];
                                                grid[i + 4*j] = 0;
                                            end
                                        if (j == 3)
                                            counter = 0;
                                    end
                            end
                        for (count = 0; count < 16; count = count + 1)
                            begin
                                if (grid[count] !== prev[count])
                                    different <= 1;
                            end

                    end
                else if (down == 1)
                    begin
                        for (count = 0; count < 16; count = count + 1)
                            begin
                                prev[count] <= grid[count];
                            end
                        prev_score <= score;
                        counter = 0;
                        for (i = 0; i < 4; i = i + 1)
                            begin
                                for (j = 3; j >= 0; j = j - 1)
                                    begin
                                        if (grid[i + 4*j] == 0)
                                            counter = counter + 1;
                                        else if (counter !== 0)
                                            begin
                                                grid[i + 4*j + 4*counter] = grid[i + 4*j];
                                                grid[i + 4*j] = 0;
                                            end
                                        if (j == 0)
                                            counter = 0;
                                    end
                            end
                        for (i = 0; i < 4; i = i + 1)
                            begin
                                for (j = 3; j > 0; j = j - 1)
                                    begin
                                        if (grid[i + 4*j] == grid[i + 4*j - 4] && grid[i + 4*j] !== 0)
                                            begin
                                                grid[i + 4*j] = 2*grid[i + 4*j];
                                                grid[i + 4*j - 4] = 0;
                                                score <= score + grid[i + 4*j];
                                            end
                                    end
                            end
                        counter = 0;
                        for (i = 0; i < 4; i = i + 1)
                            begin
                                for (j = 3; j >= 0; j = j - 1)
                                    begin
                                        if (grid[i + 4*j] == 0)
                                            counter = counter + 1;
                                        else if (counter !== 0)
                                            begin
                                                grid[i + 4*j + 4*counter] = grid[i + 4*j];
                                                grid[i + 4*j] = 0;
                                            end
                                        if (j == 0)
                                            counter = 0;
                                    end
                            end
                        for (count = 0; count < 16; count = count + 1)
                            begin
                                if (grid[count] !== prev[count])
                                    different <= 1;
                            end 
                    end
                else if (left == 1)
                    begin
                        for (count = 0; count < 16; count = count + 1)
                            begin
                                prev[count] <= grid[count];
                            end
                        prev_score <= score;
                        counter = 0;
                        for (j = 0; j < 4; j = j + 1)
                            begin
                                for (i = 0; i < 4; i = i + 1)
                                    begin
                                        if (grid[i + 4*j] == 0)
                                            counter = counter + 1;
                                        else if (counter !== 0)
                                            begin
                                                grid[i + 4*j - counter] = grid[i + 4*j];
                                                grid[i + 4*j] = 0;
                                            end
                                        if (i == 3)
                                            counter = 0;
                                    end
                            end
                        for (j = 0; j < 4; j = j + 1)
                            begin
                                for (i = 0; i < 3; i = i + 1)
                                    begin
                                        if (grid[i + 4*j] == grid[i + 4*j + 1] && grid[i + 4*j] !== 0)
                                            begin
                                                grid[i + 4*j] = 2*grid[i + 4*j];
                                                grid[i + 4*j + 1] = 0;
                                                score <= score + grid[i + 4*j];
                                            end
                                    end
                            end
                        counter = 0;
                        for (j = 0; j < 4; j = j + 1)
                            begin
                                for (i = 0; i < 4; i = i + 1)
                                    begin
                                        if (grid[i + 4*j] == 0)
                                            counter = counter + 1;
                                        else if (counter !== 0)
                                            begin
                                                grid[i + 4*j - counter] = grid[i + 4*j];
                                                grid[i + 4*j] = 0;
                                            end
                                        if (i == 3)
                                            counter = 0;
                                    end
                            end
                        for (count = 0; count < 16; count = count + 1)
                            begin
                                if (grid[count] !== prev[count])
                                    different <= 1;
                            end
                    end
                else if (right == 1)
                    begin
                        for (count = 0; count < 16; count = count + 1)
                            begin
                                prev[count] <= grid[count];
                            end
                        prev_score <= score;
                        counter = 0;
                        for (j = 0; j < 4; j = j + 1)
                            begin
                                for (i = 3; i >= 0; i = i - 1)
                                    begin
                                        if (grid[i + 4*j] == 0)
                                            counter = counter + 1;
                                        else if (counter !== 0)
                                            begin
                                                grid[i + 4*j + counter] = grid[i + 4*j];
                                                grid[i + 4*j] = 0;
                                            end
                                        if (i == 0)
                                            counter = 0;
                                    end
                            end
                        for (j = 0; j < 4; j = j + 1)
                            begin
                                for (i = 3; i > 0; i = i - 1)
                                    begin
                                        if (grid[i + 4*j] == grid[i + 4*j - 1] && grid[i + 4*j] !== 0)
                                            begin
                                                grid[i + 4*j] = 2*grid[i + 4*j];
                                                grid[i + 4*j - 1] = 0;
                                                score <= score + grid[i + 4*j];
                                            end 
                                    end
                            end
                        counter = 0;
                        for (j = 0; j < 4; j = j + 1)
                            begin
                                for (i = 3; i >= 0; i = i - 1)
                                    begin
                                        if (grid[i + 4*j] == 0)
                                            counter = counter + 1;
                                        else if (counter !== 0)
                                            begin
                                                grid[i + 4*j + counter] = grid[i + 4*j];
                                                grid[i + 4*j] = 0;
                                            end
                                        if (i == 0)
                                            counter = 0;
                                    end
                            end
                        for (count = 0; count < 16; count = count + 1)
                            begin
                                if (grid[count] !== prev[count])
                                    different <= 1;
                            end
                    end
                else if (undo == 1)
                    begin
                        for (count = 0; count < 16; count = count + 1)
                            begin
                                grid[count] <= prev[count];
                            end
                        score <= prev_score;
                    end
                else
                    begin
                        if (different == 1)
                            begin
                                grid[randGrid] <= 2;
                                different <= 0;
                            end
                        if ((grid[0] !== grid[1]) && (grid[0] !== grid[4]) && (grid[1] !== grid[5]) && (grid[1] !== grid[2]) &&(grid[2] !== grid[6]) &&
                        (grid[2] !== grid[3]) && (grid[3] !== grid[7]) && (grid[4] !== grid[5]) && (grid[4] !== grid[8]) && (grid[5] !== grid[9]) && 
                        (grid[5] !== grid[6]) && (grid[6] !== grid[7]) && (grid[6] !== grid[10]) && (grid[7] !== grid[11]) && (grid[8] !== grid[9]) && 
                        (grid[8] !== grid[12]) && (grid[9] !== grid[10]) && (grid[9] !== grid[13]) && (grid[10] !== grid[14]) && (grid[10] !== grid[11]) && 
                        (grid[11] !== grid[15]) && (grid[12] !== grid[13]) && (grid[13] !== grid[14]) && (grid[14] !== grid[15])&&
                        (grid[0] !== 0)&&(grid[1] !== 0)&&(grid[2] !== 0)&&(grid[3] !== 0)&&(grid[4] !== 0)&&(grid[5] !== 0)&&
                        (grid[6] !== 0)&&(grid[7] !== 0)&&(grid[8] !== 0)&&(grid[9] !== 0)&&(grid[10] !== 0)&&
                        (grid[11] !== 0)&&(grid[12] !== 0)&&(grid[13] !== 0)&&(grid[14] !== 0)&&(grid[15] !== 0))
                            game_over <= 1;
                        if ((grid[0] == 2048) || (grid[1] == 2048) || (grid[2] == 2048) || (grid[3] == 2048) || (grid[4] == 2048) || (grid[5] == 2048) || 
                        (grid[6] == 2048) || (grid[7] == 2048) || (grid[8] == 2048) || (grid[9] == 2048) || (grid[10] == 2048) || (grid[11] == 2048) || 
                        (grid[12] == 2048) || (grid[13] == 2048) || (grid[14] == 2048) || (grid[15] == 2048))
                            win <= 1;
                    end
                
            end
    end
    
    
    always @ (posedge clk)
    begin
        randGrid <= ((randGrid + 7) % 16);
        if (different == 1)
            begin
                for (count = 0; count < 16; count = count + 1)
                    begin   
                        if (grid[randGrid] == 0)
                            randGrid <= randGrid;
                        else
                            randGrid <= ((randGrid + 3) % 16);
                    end
            end
//    if ((grid[0] == 0)||(grid[1] == 0)||(grid[2] == 0)||(grid[3] == 0)||(grid[4] == 0)||(grid[5] == 0)||
//       (grid[6] == 0)||(grid[7] == 0)||(grid[8] == 0)||(grid[9] == 0)||(grid[10] == 0)||
//       (grid[11] == 0)||(grid[12] == 0)||(grid[13] == 0)||(grid[14] == 0)||(grid[15] == 0))
//        begin
//            if (up || down || left || right)
//                begin
//                    if (grid[randGrid] !== 0)
//                        randGrid <= ((randGrid + 7) % 16);
//                end
//            else
//                begin
//                    randGrid <= ((randGrid + 7) % 16);
//                end
//        end
    end
    
    reg two[0:15];
    reg four[0:15];
    reg eight[0:15];

    
    always @ (posedge clk)
    begin
        two[0] <= ((y == 5 || y == 9 || y == 13) && (x <= 14 && x >= 11)) || ((x == 14) && (y <= 8 && y >= 6)) || ((x == 11) && (y <= 12 && y >= 10));
        two[1] <= ((y == 5 || y == 9 || y == 13) && (x <= 37 && x >= 34)) || ((x == 37) && (y <= 8 && y >= 6)) || ((x == 34) && (y <= 12 && y >= 10));
        two[2] <= ((y == 5 || y == 9 || y == 13) && (x <= 60 && x >= 57)) || ((x == 60) && (y <= 8 && y >= 6)) || ((x == 57) && (y <= 12 && y >= 10));
        two[3] <= ((y == 5 || y == 9 || y == 13) && (x <= 83 && x >= 80)) || ((x == 83) && (y <= 8 && y >= 6)) || ((x == 80) && (y <= 12 && y >= 10));
        two[4] <= ((y == 20 || y == 24 || y == 28) && (x <= 14 && x >= 11)) || ((x == 14) && (y <= 23 && y >= 21)) || ((x == 11) && (y <= 27 && y >= 25));
        two[5] <= ((y == 20 || y == 24 || y == 28) && (x <= 37 && x >= 34)) || ((x == 37) && (y <= 23 && y >= 21)) || ((x == 34) && (y <= 27 && y >= 25));
        two[6] <= ((y == 20 || y == 24 || y == 28) && (x <= 60 && x >= 57)) || ((x == 60) && (y <= 23 && y >= 21)) || ((x == 57) && (y <= 27 && y >= 25));
        two[7] <= ((y == 20 || y == 24 || y == 28) && (x <= 83 && x >= 80)) || ((x == 83) && (y <= 23 && y >= 21)) || ((x == 80) && (y <= 27 && y >= 25));
        two[8] <= ((y == 35 || y == 39 || y == 43) && (x <= 14 && x >= 11)) || ((x == 14) && (y <= 38 && y >= 36)) || ((x == 11) && (y <= 42 && y >= 40));
        two[9] <= ((y == 35 || y == 39 || y == 43) && (x <= 37 && x >= 34)) || ((x == 37) && (y <= 38 && y >= 36)) || ((x == 34) && (y <= 42 && y >= 40));
        two[10] <= ((y == 35 || y == 39 || y == 43) && (x <= 60 && x >= 57)) || ((x == 60) && (y <= 38 && y >= 36)) || ((x == 57) && (y <= 42 && y >= 40));
        two[11] <= ((y == 35 || y == 39 || y == 43) && (x <= 83 && x >= 80)) || ((x == 83) && (y <= 38 && y >= 36)) || ((x == 80) && (y <= 42 && y >= 40));
        two[12] <= ((y == 50 || y == 54 || y == 58) && (x <= 14 && x >= 11)) || ((x == 14) && (y <= 53 && y >= 51)) || ((x == 11) && (y <= 57 && y >= 55));
        two[13] <= ((y == 50 || y == 54 || y == 58) && (x <= 37 && x >= 34)) || ((x == 37) && (y <= 53 && y >= 51)) || ((x == 34) && (y <= 57 && y >= 55));
        two[14] <= ((y == 50 || y == 54 || y == 58) && (x <= 60 && x >= 57)) || ((x == 60) && (y <= 53 && y >= 51)) || ((x == 57) && (y <= 57 && y >= 55));
        two[15] <= ((y == 50 || y == 54 || y == 58) && (x <= 83 && x >= 80)) || ((x == 83) && (y <= 53 && y >= 51)) || ((x == 80) && (y <= 57 && y >= 55));
        four[0] <= ((y <= 13 && y >= 5) && (x == 14)) || ((y == 9) && (x <= 14 && x >= 11)) || ((x == 11) && (y <= 9 && y >= 5));
        four[1] <= ((y <= 13 && y >= 5) && (x == 37)) || ((y == 9) && (x <= 37 && x >= 34)) || ((x == 34) && (y <= 9 && y >= 5));
        four[2] <= ((y <= 13 && y >= 5) && (x == 60)) || ((y == 9) && (x <= 60 && x >= 57)) || ((x == 57) && (y <= 9 && y >= 5));
        four[3] <= ((y <= 13 && y >= 5) && (x == 83)) || ((y == 9) && (x <= 83 && x >= 80)) || ((x == 80) && (y <= 9 && y >= 5));
        four[4] <= ((y <= 28 && y >= 20) && (x == 14)) || ((y == 24) && (x <= 14 && x >= 11)) || ((x == 11) && (y <= 24 && y >= 20));
        four[5] <= ((y <= 28 && y >= 20) && (x == 37)) || ((y == 24) && (x <= 37 && x >= 34)) || ((x == 34) && (y <= 24 && y >= 20));
        four[6] <= ((y <= 28 && y >= 20) && (x == 60)) || ((y == 24) && (x <= 60 && x >= 57)) || ((x == 57) && (y <= 24 && y >= 20));
        four[7] <= ((y <= 28 && y >= 20) && (x == 83)) || ((y == 24) && (x <= 83 && x >= 80)) || ((x == 80) && (y <= 24 && y >= 20));
        four[8] <= ((y <= 43 && y >= 35) && (x == 14)) || ((y == 39) && (x <= 14 && x >= 11)) || ((x == 11) && (y <= 39 && y >= 35));
        four[9] <= ((y <= 43 && y >= 35) && (x == 37)) || ((y == 39) && (x <= 37 && x >= 34)) || ((x == 34) && (y <= 39 && y >= 35));
        four[10] <= ((y <= 43 && y >= 35) && (x == 60)) || ((y == 39) && (x <= 60 && x >= 57)) || ((x == 57) && (y <= 39 && y >= 35));
        four[11] <= ((y <= 43 && y >= 35) && (x == 83)) || ((y == 39) && (x <= 83 && x >= 80)) || ((x == 80) && (y <= 39 && y >= 35));
        four[12] <= ((y <= 58 && y >= 50) && (x == 14)) || ((y == 54) && (x <= 14 && x >= 11)) || ((x == 11) && (y <= 54 && y >= 50));
        four[13] <= ((y <= 58 && y >= 50) && (x == 37)) || ((y == 54) && (x <= 37 && x >= 34)) || ((x == 34) && (y <= 54 && y >= 50));
        four[14] <= ((y <= 58 && y >= 50) && (x == 60)) || ((y == 54) && (x <= 60 && x >= 57)) || ((x == 57) && (y <= 54 && y >= 50));
        four[15] <= ((y <= 58 && y >= 50) && (x == 83)) || ((y == 54) && (x <= 83 && x >= 80)) || ((x == 80) && (y <= 54 && y >= 50));
        eight[0] <= ((y <= 13 && y >= 5) && (x == 14 || x == 11)) || ((y == 9 || y == 5 || y == 13) && (x <= 14 && x >= 11));
        eight[1] <= ((y <= 13 && y >= 5) && (x == 37 || x == 34)) || ((y == 9 || y == 5 || y == 13) && (x <= 37 && x >= 34));
        eight[2] <= ((y <= 13 && y >= 5) && (x == 60 || x == 57)) || ((y == 9 || y == 5 || y == 13) && (x <= 60 && x >= 57));
        eight[3] <= ((y <= 13 && y >= 5) && (x == 83 || x == 80)) || ((y == 9 || y == 5 || y == 13) && (x <= 83 && x >= 80));
        eight[4] <= ((y <= 28 && y >= 20) && (x == 14 || x == 11)) || ((y == 24 || y == 20 || y == 28) && (x <= 14 && x >= 11));
        eight[5] <= ((y <= 28 && y >= 20) && (x == 37 || x == 34)) || ((y == 24 || y == 20 || y == 28) && (x <= 37 && x >= 34));
        eight[6] <= ((y <= 28 && y >= 20) && (x == 60 || x == 57)) || ((y == 24 || y == 20 || y == 28) && (x <= 60 && x >= 57));
        eight[7] <= ((y <= 28 && y >= 20) && (x == 83 || x == 80)) || ((y == 24 || y == 20 || y == 28) && (x <= 83 && x >= 80));
        eight[8] <= ((y <= 43 && y >= 35) && (x == 14 || x == 11)) || ((y == 39 || y == 35 || y == 43) && (x <= 14 && x >= 11));
        eight[9] <= ((y <= 43 && y >= 35) && (x == 37 || x == 34)) || ((y == 39 || y == 35 || y == 43) && (x <= 37 && x >= 34));
        eight[10] <= ((y <= 43 && y >= 35) && (x == 60 || x == 57)) || ((y == 39 || y == 35 || y == 43) && (x <= 60 && x >= 57));
        eight[11] <= ((y <= 43 && y >= 35) && (x == 83 || x == 80)) || ((y == 39 || y == 35 || y == 43) && (x <= 83 && x >= 80));
        eight[12] <= ((y <= 58 && y >= 50) && (x == 14 || x == 11)) || ((y == 54 || y == 50 || y == 58) && (x <= 14 && x >= 11));
        eight[13] <= ((y <= 58 && y >= 50) && (x == 37 || x == 34)) || ((y == 54 || y == 50 || y == 58) && (x <= 37 && x >= 34));
        eight[14] <= ((y <= 58 && y >= 50) && (x == 60 || x == 57)) || ((y == 54 || y == 50 || y == 58) && (x <= 60 && x >= 57));
        eight[15] <= ((y <= 58 && y >= 50) && (x == 83 || x == 80)) || ((y == 54 || y == 50 || y == 58) && (x <= 83 && x >= 80));
    end
    
    reg grid_array [0:15];
    
    always @ (posedge clk)
    begin
        for (count = 0; count < 16; count = count + 1)
            begin
                if (grid[count] == 2)
                    grid_array[count] <= two[count];
                else if (grid[count] == 4)
                    grid_array[count] <= four[count];
                else if (grid[count] == 8)
                    grid_array[count] <= eight[count];
                else
                    grid_array[count] <= 0;
            end
    end
    
    
    assign oled_data = (grid_array[0] || grid_array[1] || grid_array[2] || grid_array[3] || grid_array[4] || grid_array[5] || grid_array[6] || grid_array[7] ||
    grid_array[8] || grid_array[9] || grid_array[10] || grid_array[11] || eight[12] || grid_array[13] || grid_array[14] || grid_array[15]) ? `BLACK : `WHITE;
    
   
endmodule
