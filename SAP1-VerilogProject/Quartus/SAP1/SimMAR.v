`timescale 1ns/1ps
module SimMAR;

    // Entradas
    reg CLK;
    reg Lm;
    reg SELECT;
    reg [3:0] A;
    reg [3:0] D;

    // Saída
    wire [3:0] OUT;

    // Instancia o módulo MAR
    MAR DUT (
        .CLK(CLK),
        .Lm(Lm),
        .SELECT(SELECT),
        .A(A),
        .D(D),
        .Out(OUT)
    );

    // Geração de clock
    initial begin
        CLK = 0;
        forever #10 CLK = ~CLK;
    end

    // Sequência de teste
    initial begin
        // Inicialização
        Lm = 0;
        SELECT = 0;
        A = 4'b0000;
        D = 4'b0000;

        // Teste 1: Modo programação
        #20 A = 4'b1010;
        SELECT = 0;
        #20;

        // Teste 2: Carrega valor no registrador
        D = 4'b1100;
        Lm = 1;
        #20 Lm = 0;

        // Teste 3: Modo execução
        SELECT = 1;
        #20;

        // Teste 4: Muda D mas sem LOAD, saída deve manter
        D = 4'b0011;
        #20;

        // Fim
        #40;
    end

endmodule
