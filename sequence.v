`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 01/23/2024 02:58:48 PM
// Design Name:
// Module Name: sequence
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


module SequenceDetector(
  input wire clk,
  input wire reset,
  input wire data_in,
  output reg sequence_detected
);

// Define states
typedef enum logic [2:0] {
  S0,
  S1,
  S2,
  S3,
  S4
} state_t;

// Define state register and next state logic
reg [2:0] state, next_state;

// State transition and output logic
always_ff @(posedge clk or posedge reset) begin
  if (reset) begin
    state <= S0;
  end else begin
    state <= next_state;
  end
end

always_comb begin
  case (state)
    S0: begin
      if (data_in) begin
        next_state = S1;
      end else begin
        next_state = S0;
      end
    end
    S1: begin
      if (data_in) begin
        next_state = S2;
      end else begin
        next_state = S0;
      end
    end
    S2: begin
      if (data_in) begin
        next_state = S3;
      end else begin
        next_state = S0;
      end
    end
    S3: begin
      if (data_in) begin
        next_state = S4;
      end else begin
        next_state = S0;
      end
    end
    S4: begin
      if (data_in) begin
        next_state = S0;
      end else begin
        next_state = S0;
      end
    end
    default: next_state = S0;
  endcase
end

// Output logic
always_comb begin
  sequence_detected = (state == S4);
end

endmodule