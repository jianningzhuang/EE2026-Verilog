`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//
//  LAB SESSION DAY (Delete where applicable): MONDAY P.M, TUESDAY P.M, WEDNESDAY P.M, THURSDAY A.M., THURSDAY P.M
//
//  STUDENT A NAME: 
//  STUDENT A MATRICULATION NUMBER: 
//
//  STUDENT B NAME: 
//  STUDENT B MATRICULATION NUMBER: 
//
//////////////////////////////////////////////////////////////////////////////////


module Top_Student (
    input  J_MIC3_Pin3,   // Connect from this signal to Audio_Capture.v
    output J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
    output J_MIC3_Pin4,    // Connect to this signal from Audio_Capture.v
    output pmodoledrgb_cs,
    output pmodoledrgb_sdin,
    output pmodoledrgb_sclk,
    output pmodoledrgb_d_cn,
    output pmodoledrgb_resn,
    output pmodoledrgb_vccen,
    output pmodoledrgb_pmoden,
    input CLK100MHZ,
    input [15:0] sw,
    input btnC,
    input btnU,
    input btnL,
    input btnR,
    input btnD,
    output reg [15:0] led,
    output reg [3:0] an,
    output reg [7:0] seg
    );
    
    wire clk_20khz;
    wire clk_6p25mhz;
    wire clk_50hz;
    wire clk_381hz;

    my_clock_divider clk20kHz (CLK100MHZ, 2499, clk_20khz);
    my_clock_divider clk6p25mHz (CLK100MHZ, 7, clk_6p25mhz);
    my_clock_divider clk50Hz (CLK100MHZ, 999999, clk_50hz);
    my_clock_divider clk381Hz (CLK100MHZ, 131232, clk_381hz);
    
    wire reset;
    wire left_press;
    wire centre_press;
    wire right_press;
    wire up_press;
    wire down_press;
    
    button_press reset_signal (clk_6p25mhz, btnC, reset);
    button_press left_signal (clk_50hz, btnL, left_press);
    button_press centre_signal (clk_50hz, btnC, centre_press);
    button_press right_signal (clk_50hz, btnR, right_press);
    button_press up_signal (clk_50hz, btnU, up_press);
    button_press down_signal (clk_50hz, btnD, down_press);
    
    
    wire [11:0] mic_in;
    wire [15:0] led_volume;
    wire [3:0] an_volume;
    wire [7:0] seg_volume;
    wire [3:0] an_2048;
    wire [7:0] seg_2048;
    
    Audio_Capture audio_capture (CLK100MHZ, clk_20khz, J_MIC3_Pin3, J_MIC3_Pin1, J_MIC3_Pin4, mic_in);
  
    led_controller led_intensity (CLK100MHZ, clk_20khz, sw[0], mic_in, led_volume);
    seven_segment_controller seven_segment_intensity (clk_381hz, clk_20khz, mic_in, sw[1], an_volume, seg_volume); 
    
    
    
    wire frame_begin, sending_pixel, sample_pixel;
    wire [12:0] pixel_index;
    reg [15:0] oled_data = 0;
    wire [4:0] teststate;
    wire [15:0] oled_volume;
    wire [15:0] oled_menu;
    wire [15:0] oled_snake;
    wire [15:0] oled_2048;
    
    
    Oled_Display oled_display (clk_6p25mhz, reset, frame_begin, sending_pixel, 
    sample_pixel, pixel_index, oled_data, pmodoledrgb_cs, pmodoledrgb_sdin,
    pmodoledrgb_sclk, pmodoledrgb_d_cn, pmodoledrgb_resn, pmodoledrgb_vccen,
    pmodoledrgb_pmoden, teststate);
    
    wire [6:0] x;
    wire [5:0] y;
    
    x_y_converter xy (pixel_index, x, y);
    
    wire [2:0] state;
    
    oled_intensity oled_volume_intensity (clk_20khz, clk_50hz, mic_in, sw[15:10], left_press, right_press, up_press, x, y, oled_volume);
    
    
    menu selection (clk_50hz, up_press, down_press, x, y, oled_menu, state);
    
    reg start_snake = 0;
    reg start_2048 = 0;
    
    snake snake_game (CLK100MHZ, clk_50hz, up_press, down_press, left_press, right_press, centre_press, start_snake, sw[8], x, y, mic_in, oled_snake);
    
    game_2048 game_2048_game (CLK100MHZ, clk_50hz, clk_381hz, up_press, down_press, left_press, right_press, centre_press, start_2048, x, y, mic_in, oled_2048, seg_2048, an_2048);
    
    reg [2:0] TASK = 0;
    
    always @ (posedge CLK100MHZ)
    begin
        if (TASK == 0)
            begin
                led <= 16'b0000000000000000;
                an <= 4'b1111;
                seg <= 8'b11111111;
                oled_data <= oled_menu;
            end
        else if (TASK == 1)
            begin
                led <= led_volume;
                an <= an_volume;
                seg <= seg_volume;
                oled_data <= oled_volume;
            end
        else if (TASK == 2)
            begin
                led <= 16'b0000000000000000;
                an <= 4'b1111;
                seg <= 8'b11111111;
                oled_data <= oled_snake;
            end
        else if (TASK == 3)
            begin
                led <= led_volume;
                an <= an_2048;
                seg <= seg_2048;
                oled_data <= oled_2048;
            end
        else if (TASK == 4)
            begin
                led <= led_volume;
                an <= an_volume;
                seg <= seg_volume;
                oled_data <= oled_volume;
            end
    end
    
    always @ (posedge clk_50hz)
    begin
        if (TASK == 0)
            begin
                if (right_press && state == 1)
                    TASK <= 1;
                else if (right_press && state == 2)
                    begin
                        TASK <= 2;
                        start_snake <= 1;
                    end
                else if (right_press && state == 3)
                    begin
                        TASK <= 3;
                        start_2048 <= 1;
                    end
                else if (right_press && state == 4)
                    TASK <= 4;
            end
        else if (TASK == 1)
            begin
                if (up_press && sw[7])
                    TASK <= 0;
            end
        else if (TASK == 2)
            begin
                start_snake <= 0;
                if (up_press && sw[7])
                    TASK <= 0;
            end
        else if (TASK == 3)
            begin
                start_2048 <= 0;
                if (up_press && sw[7])
                    TASK <= 0;
            end
        else if (TASK == 4)
            begin
                if (up_press && sw[7])
                    TASK <= 0;
            end
        else 
            TASK <= TASK;
    end
    
endmodule