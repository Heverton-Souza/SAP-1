module ula (
    input wire [7:0] A,
    input wire [7:0] B,
    input wire Eu,        // Enable geral da ULA
    input wire Add,       // Sinal para soma
    input wire Sub,       // Sinal para subtração
    input wire AndOp,     // Sinal para AND
    input wire OrOp,      // Sinal para OR
    input wire XorOp,     // Sinal para XOR
    input wire NotOp,     // Sinal para NOT

    output reg [7:0] Out
);
    always @(*) begin
        if (Eu) begin
            if (Add)
                Out = A + B;
            else if (Sub)
                Out = A + (~B + 1);
            else if (AndOp)
                Out = A & B;
            else if (OrOp)
                Out = A | B;
            else if (XorOp)
                Out = A ^ B;
            else if (NotOp)
                Out = ~A;
            else
                Out = 8'b00000000; // Nenhuma operação válida
        end else begin
            Out = 8'b00000000; // ULA desabilitada
        end
    end
endmodule
