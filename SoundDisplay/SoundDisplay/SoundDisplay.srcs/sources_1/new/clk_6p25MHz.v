`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2021 15:05:59
// Design Name: 
// Module Name: clk_6p25MHz
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


module clk_6p25MHz(
    input basys_clk,
    output reg clk_6p25mhz
    );
    
    reg [2:0] count = 0;
        
    always @ (posedge basys_clk)
    begin
        clk_6p25mhz <= (count == 0) ? ~clk_6p25mhz : clk_6p25mhz;
    end
endmodule
