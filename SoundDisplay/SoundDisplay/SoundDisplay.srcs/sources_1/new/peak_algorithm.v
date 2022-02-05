`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.03.2021 15:44:18
// Design Name: 
// Module Name: peak_algorithm
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


module peak_algorithm(
    input clk_20khz,
    input [11:0] mic_in,
    output reg [11:0] peak_output = 0
    );
    
    reg [11:0] peak_value = 0;
    reg [31:0] counter = 0;
    
    always @ (posedge clk_20khz)
    begin
        counter <= (counter == 4000) ? 0 : counter + 1;
        if (counter == 0)
            begin
                peak_output <= peak_value;
                peak_value <= 0;
            end
        else
            begin
                if (mic_in > peak_value)
                    peak_value <= mic_in;
            end
    end
    
    
endmodule
