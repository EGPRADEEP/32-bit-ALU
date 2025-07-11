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
