`timescale 1ns / 1ps

// ================== ADDER ==================
module adder4 (
    input [3:0] a, b,
    output [4:0] sum,
    output overflow
);
    assign sum = a + b;
    assign overflow = sum[4];
endmodule

// ================== SUBTRACTOR ==================
module subtractor4 (
    input [3:0] a, b,
    output [4:0] diff,
    output borrow
);
    assign diff = a - b;
    assign borrow = (a < b);
endmodule

// ================== MULTIPLIER ==================
module multiplier4 (
    input [3:0] a, b,
    output [7:0] product,
    output overflow
);
    assign product = a * b;
    assign overflow = (product > 8'd15);
endmodule

// ================== DIVIDER ==================
module divider4 (
    input [3:0] a, b,
    output [3:0] quotient,
    output [3:0] remainder,
    output error
);
    assign error = (b == 0);
    assign quotient = (b != 0) ? a / b : 0;
    assign remainder = (b != 0) ? a % b : 0;
endmodule

// ================== TOP MODULE ==================
module calculator_top (
    input [3:0] a, b,
    input [1:0] op,
    output reg [7:0] result,
    output reg [3:0] quotient, remainder,
    output reg error
);

wire [4:0] sum, diff;
wire [7:0] product;
wire [3:0] q, r;

wire add_ov, mul_ov, sub_borrow, div_error;

// Instances
adder4 u1 (.a(a), .b(b), .sum(sum), .overflow(add_ov));
subtractor4 u2 (.a(a), .b(b), .diff(diff), .borrow(sub_borrow));
multiplier4 u3 (.a(a), .b(b), .product(product), .overflow(mul_ov));
divider4 u4 (.a(a), .b(b), .quotient(q), .remainder(r), .error(div_error));

// Logic
always @(*) begin
    result = 0;
    quotient = 0;
    remainder = 0;
    error = 0;

    case(op)
        2'b00: begin // ADD
            result = {3'b000, sum};
            error = add_ov;
        end

        2'b01: begin // SUB
            result = {3'b000, diff};
            error = sub_borrow;
        end

        2'b10: begin // MUL
            result = product;
            error = mul_ov;
        end

        2'b11: begin // DIV
            quotient = q;
            remainder = r;
            error = div_error;
        end
    endcase
end

endmodule