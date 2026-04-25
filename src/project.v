
/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_example (
    input  wire [7:0] ui_in,    
    output wire [7:0] uo_out,   
    input  wire [7:0] uio_in,   
    output wire [7:0] uio_out,  
    output wire [7:0] uio_oe,   
    input  wire       ena,      
    input  wire       clk,      
    input  wire       rst_n     
);

    wire [1:0] A;
    wire [1:0] B;

    assign A = ui_in[1:0];
    assign B = ui_in[3:2];

    // Output assignments
    assign uo_out[0] = (A > B);   // A greater than B
    assign uo_out[1] = (A == B);  // A equal to B
    assign uo_out[2] = (A < B);   // A less than B

    // Unused outputs set to zero
    assign uo_out[7:3] = 5'b00000;
    assign uio_out = 8'b00000000;
    assign uio_oe  = 8'b00000000;

    // Prevent unused warnings
    wire _unused = &{ena, clk, rst_n, uio_in, 1'b0};

endmodule
