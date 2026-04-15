`timescale 1ns/1ps

module tb_calculator;

reg [3:0] a, b;
reg [1:0] op;

wire [7:0] result;
wire [3:0] quotient, remainder;
wire error;

calculator_top uut (
    .a(a),
    .b(b),
    .op(op),
    .result(result),
    .quotient(quotient),
    .remainder(remainder),
    .error(error)
);

initial begin
    $display("===== CALCULATOR TEST START =====");

    // ADD
    a=5; b=3; op=0; #10;
    $display("ADD: %d", result);

    // ADD overflow
    a=15; b=15; op=0; #10;
    $display("ADD OV: %d ERROR=%d", result, error);

    // SUB
    a=8; b=2; op=1; #10;
    $display("SUB: %d", result);

    // SUB borrow
    a=2; b=8; op=1; #10;
    $display("SUB BORROW: %d ERROR=%d", result, error);

    // MUL
    a=4; b=3; op=2; #10;
    $display("MUL: %d", result);

    // MUL overflow
    a=15; b=15; op=2; #10;
    $display("MUL OV: %d ERROR=%d", result, error);

    // DIV
    a=7; b=3; op=3; #10;
    $display("DIV: Q=%d R=%d", quotient, remainder);

    // DIV by zero
    a=5; b=0; op=3; #10;
    $display("DIV ERROR: ERROR=%d", error);

    $display("===== TEST END =====");
    $finish;
end

endmodule