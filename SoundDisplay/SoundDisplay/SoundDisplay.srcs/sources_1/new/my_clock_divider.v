`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08.03.2021 15:16:31
// Design Name: 
// Module Name: my_clock_divider
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


module my_clock_divider(
    input basys_clk,
    input [31:0] m_value,
    output reg new_clk
    );
    
    reg [31:0] count = 0;
        
    always @ (posedge basys_clk)
    begin
        count <= (count == m_value) ? 0 : count + 1;
        new_clk <= (count == 0) ? ~new_clk : new_clk;
    end
endmodule
