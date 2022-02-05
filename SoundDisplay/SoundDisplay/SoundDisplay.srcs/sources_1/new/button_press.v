`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.03.2021 11:58:52
// Design Name: 
// Module Name: button_press
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


module button_press(
    input DFF_CLOCK,
    input pushbutton,
    output single_pulse
    );
    
    wire Q1;
    wire Q2;
    
    my_dff DFF1 (DFF_CLOCK, pushbutton, Q1);
    my_dff DFF2 (DFF_CLOCK, Q1, Q2);
        
    assign single_pulse = Q1 & ~Q2;
endmodule
