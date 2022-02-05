`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.03.2021 15:18:37
// Design Name: 
// Module Name: seven_segment_counter
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


module seven_segment_counter(
    input CLOCK,
    output reg [7:0] COUNT = 0
    );
    
    
    always @ (posedge CLOCK)
    begin
        COUNT <= (COUNT == 8'b00000100) ? 8'b00000001 : COUNT + 1;
    end
endmodule
