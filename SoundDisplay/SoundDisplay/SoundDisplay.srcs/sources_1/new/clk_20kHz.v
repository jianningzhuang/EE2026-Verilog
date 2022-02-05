`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2021 14:30:22
// Design Name: 
// Module Name: clk_20kHz
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


module clk_20kHz(
    input basys_clk,
    input [31:0] m_value,
    output reg clk_20khz = 0
    );
    
    reg [31:0] count = 0;
    
    always @ (posedge basys_clk)
    begin
        count <= (count == 2499) ? 0 : count + 1;
        clk_20khz <= (count == 0) ? ~clk_20khz : clk_20khz;
    end
endmodule
