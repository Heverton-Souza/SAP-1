`timescale 1ns/1ps

module SimUla;

    // Entradas
    reg [7:0] A;
    reg [7:0] B;
    reg [2:0] op;
    reg En;

    // Saída
    wire [7:0] Out;

    // Instancia o módulo da ULA
    ula DUT (
        .A(A),
        .B(B),
        .op(op),
        .En(En),
        .Out(Out)
    );

    initial begin
        // Inicialização
        A = 8'b00000000;
        B = 8'b00000000;
        op = 3'b000;
        En = 0;

        // Aguarda alguns ns antes de iniciar
        #10;

        // Operação: Soma
        A = 8'd10;
        B = 8'd5;
        op = 3'b000;
        En = 1;
        #20;

        // Operação: Subtração
        op = 3'b001;
        #20;

        // Operação: AND
        op = 3'b010;
        #20;

        // Operação: OR
        op = 3'b011;
        #20;

        // Operação: XOR
        op = 3'b100;
        #20;

        // Operação: NOT (somente sobre A)
        op = 3'b101;
        #20;

        // Testa disable (En = 0)
        En = 0;
        #20;

        // Teste extra com valores diferentes
        A = 8'b11110000;
        B = 8'b00001111;
        op = 3'b010; // AND
        En = 1;
        #20;

        // Finaliza simulação
        $stop;
    end

endmodule
