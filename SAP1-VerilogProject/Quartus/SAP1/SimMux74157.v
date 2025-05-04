`timescale 1ns/1ps

module SimMux74157;

    // Entradas
    reg SELECT;
    reg [3:0] A;
    reg [3:0] D;

    // Saída
    wire [3:0] Out;

    // Instancia o módulo mux
    mux74157 DUT (
        .select(SELECT),
        .a(A),
        .d(D),
        .out(Out)
    );

    initial begin
        // Inicializa entradas
        A = 4'b0000;
        D = 4'b0000;
        SELECT = 0;

        // Aguarda 20ns e começa a simulação
        #20 A = 4'b1010;
            D = 4'b0101;
            SELECT = 0;   // Espera-se que Saida = EntradaA
        #20 SELECT = 1;   // Espera-se que Saida = EntradaD

        #20 A = 4'b1111;
            D = 4'b0000;
            SELECT = 0;   // Saida deve ir para 1111
        #20 SELECT = 1;   // Saida deve ir para 0000

        #20 A = 4'b0011;
            D = 4'b1100;
            SELECT = 0;
        #20 SELECT = 1;

    end

endmodule
