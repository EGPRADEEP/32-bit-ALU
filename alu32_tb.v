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
