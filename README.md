# 32-bit-ALU

32‑bit ALU module with flags

module alu32 (
  input  wire [31:0] A,
  input  wire [31:0] B,
  input  wire [3:0]  ALU_Sel,
  output reg  [31:0] ALU_Out,
  output reg         Z,
  output reg         C,
  output reg         V,
  output reg         S
);

  reg [32:0] result;

  always @(*) begin
    case (ALU_Sel)
      4'b0000: result = A + B;             // ADD
      4'b0001: result = A - B;             // SUB
      4'b0010: result = A & B;             // AND
      4'b0011: result = A | B;             // OR
      4'b0100: result = A ^ B;             // XOR
      4'b0101: result = ~A;                // NOT
      4'b0110: result = A * B;             // MUL (can be large)
      4'b0111: result = A / B;             // DIV (integer)
      4'b1000: result = A << 1;            // Shift left logical
      4'b1001: result = A >> 1;            // Shift right logical
      default: result = 33'b0;
    endcase

    ALU_Out = result[31:0];
    Z       = (ALU_Out == 32'b0);
    C       = result[32];
    V       = (ALU_Sel == 4'b0000 && ((A[31] == B[31]) && (ALU_Out[31] != A[31]))) ||
              (ALU_Sel == 4'b0001 && ((A[31] != B[31]) && (ALU_Out[31] != A[31])));
    S       = ALU_Out[31];
  end

endmodule

alu32_tb.v – Testbench example

`timescale 1ns/1ps

module alu32_tb;
  reg  [31:0] A, B;
  reg  [3:0] ALU_Sel;
  wire [31:0] ALU_Out;
  wire Z, C, V, S;

  alu32 UUT (
    .A(A), .B(B), .ALU_Sel(ALU_Sel),
    .ALU_Out(ALU_Out), .Z(Z), .C(C), .V(V), .S(S)
  );

  initial begin
    $display("Time | A          | B          | Sel | Out        | Z C V S");
    $monitor("%4dns | %h | %h | %b | %h | %b %b %b %b",
      $time, A, B, ALU_Sel, ALU_Out, Z, C, V, S);

    // Test ADD
    A = 32'h0000_0001; B = 32'h0000_0002; ALU_Sel = 4'b0000;
    #10;
    // Test SUB
    A = 32'h0000_0004; B = 32'h0000_0005; ALU_Sel = 4'b0001;
    #10;
    // Test AND
    A = 32'hF0F0_F0F0; B = 32'h0F0F_0F0F; ALU_Sel = 4'b0010;
    #10;
    // Test OR
    A = 32'hAAAAAAAA; B = 32'h55555555; ALU_Sel = 4'b0011;
    #10;
    // Test XOR
    A = 32'hFFFF_0000; B = 32'h0000_FFFF; ALU_Sel = 4'b0100;
    #10;
    // Test NOT
    A = 32'h0000_0000; B = 32'h0000_0000; ALU_Sel = 4'b0101;
    #10;
    // Test MUL
    A = 32'h0000_0003; B = 32'h0000_0002; ALU_Sel = 4'b0110;
    #10;
    // Test DIV
    A = 32'h0000_0006; B = 32'h0000_0003; ALU_Sel = 4'b0111;
    #10;
    // Test SHL
    A = 32'h0000_0001; B = 32'h0000_0000; ALU_Sel = 4'b1000;
    #10;
    // Test SHR
    A = 32'h8000_0000; B = 32'h0000_0000; ALU_Sel = 4'b1001;
    #10;

    $finish;
  end
endmodule
