`default_nettype none
`timescale 1ns / 1ps

module tb ();

  // Dump waveform
  initial begin
    $dumpfile("tb.fst");
    $dumpvars(0, tb);
  end

  // Inputs
  reg clk;
  reg rst_n;
  reg ena;
  reg [7:0] ui_in;
  reg [7:0] uio_in;

  // Outputs
  wire [7:0] uo_out;
  wire [7:0] uio_out;
  wire [7:0] uio_oe;

`ifdef GL_TEST
  wire VPWR = 1'b1;
  wire VGND = 1'b0;
`endif

  // DUT (Device Under Test)
  tt_um_example user_project (
`ifdef GL_TEST
      .VPWR(VPWR),
      .VGND(VGND),
`endif
      .ui_in(ui_in),
      .uo_out(uo_out),
      .uio_in(uio_in),
      .uio_out(uio_out),
      .uio_oe(uio_oe),
      .ena(ena),
      .clk(clk),
      .rst_n(rst_n)
  );

  // Clock generation (not really needed but kept)
  initial clk = 0;
  always #5 clk = ~clk;

  // Test stimulus
  initial begin
    // Initialize
    rst_n = 0;
    ena = 1;
    ui_in = 0;
    uio_in = 0;

    #10;
    rst_n = 1;

    // Test all combinations of 2-bit comparator
    repeat (16) begin
      ui_in[3:0] = $random;  // A = [1:0], B = [3:2]
      #10;

      $display("A=%b B=%b | GT=%b EQ=%b LT=%b",
        ui_in[1:0], ui_in[3:2],
        uo_out[0], uo_out[1], uo_out[2]);
    end

    #20;
    $finish;
  end

endmodule
