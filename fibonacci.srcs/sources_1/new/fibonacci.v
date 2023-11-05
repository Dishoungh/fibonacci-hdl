`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/04/2023 12:32:16 AM
// Design Name: 
// Module Name: fibonacci
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


module fibonacci
(
    input wire clk,
    input wire rst,
    output reg[31:0] out
);

//Internal Registers
reg[1:0] current_state;
reg[1:0] next_state;
reg[31:0] prev;

//State Parameters
parameter INIT                          = 2'd0;
parameter OUTPUT_ZERO                   = 2'd1;
parameter OUTPUT_ONE                    = 2'd2;
parameter ADD                           = 2'd3;

//Min-Max Parameters
parameter MAXIMUM_FIBONACCI_NUMBER      = 32'd1134903170; //Last Fibonacci Sequence for 32 bit unsigned before overflow

//State Logic
always @(posedge clk or posedge rst)
begin
    if (rst)
        current_state <= INIT;
    else
        current_state <= next_state;
end

//Next State Logic
always @(posedge clk or posedge rst)
begin
    if (rst)
        next_state <= INIT;
    else
        begin
            case (current_state)
                INIT:
                    next_state <= OUTPUT_ZERO;
                OUTPUT_ZERO:
                    next_state <= OUTPUT_ONE;
                OUTPUT_ONE:
                    next_state <= ADD;
                ADD:
                    begin
                        if (out < MAXIMUM_FIBONACCI_NUMBER)
                            next_state <= ADD;
                        else
                            next_state <= OUTPUT_ZERO;
                    end
                default:
                    next_state <= OUTPUT_ZERO;
            endcase
        end
end

//Output Logic
always @(posedge clk or posedge rst)
begin
    if (rst)
        begin
            out   <= 32'd0;
            prev  <= 32'd0;
        end
    else
        begin
            case (current_state)
                INIT:
                    begin
                        out   <= 32'd0;
                        prev  <= 32'd0;
                    end
                OUTPUT_ZERO:
                    begin
                        out   <= 32'd0;
                        prev  <= 32'd0;
                    end
                OUTPUT_ONE:
                    begin
                        out   <= 32'd1;
                        prev  <= 32'd0;
                    end
                ADD:
                    begin
                        out   <= out + prev;
                        prev  <= out;
                    end
                default:
                    begin
                        out   <= out;
                        prev  <= prev;
                    end
            endcase
        end
end

endmodule
