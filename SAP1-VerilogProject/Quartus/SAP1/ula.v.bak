module ula (
    input wire [7:0] A,
    input wire [7:0] B,
    input wire [2:0] op, // Código da operação
    input wire En, // Habilita a ULA (Enable)

    output reg [7:0] Out
);
    reg [7:0] resultado; // Variável para armazenar o resultado da operação

    always @(*) begin
        case (op)
            3'b000: resultado = A + B;        // Soma
            3'b001: resultado = A + (~B+1);   // Subtração
            3'b010: resultado = A & B;        // AND
            3'b011: resultado = A | B;        // OR
            3'b100: resultado = A ^ B;        // XOR
            3'b101: resultado = ~A;           // NOT (somente sobre A)
            default: resultado = 8'b00000000; // Valor padrão (pode ser erro)
        endcase
    end

    // Saída tri-state: só envia o valor se En = 1
    assign Out = En ? resultado : 8'b00000000;

endmodule
