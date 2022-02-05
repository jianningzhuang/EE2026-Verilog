`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2021 14:33:09
// Design Name: 
// Module Name: test_clk_20khz
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


module test_clk_20khz(

    );
    
    reg basys_clk;
    wire clk_20khz;
    
    clk_20kHz t1 (basys_clk, clk_20khz);
    
    initial
    begin
        basys_clk = 0;
    end
    
    always
    begin
        #5 basys_clk = ~basys_clk;
    end
endmodule
