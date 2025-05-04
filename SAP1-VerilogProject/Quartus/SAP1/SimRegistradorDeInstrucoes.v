`timescale 1ns/1ps
module SimRegistradorDeInstrucoes;

    // Entradas do módulo registradorDeInstrucoes
    reg CLK;
    reg L1;
    reg CLR;
    reg Ei;
    reg [7:0] ENTRADA_INSTRUCAO;

    // Saída do módulo registradorDeInstrucoes
    wire [7:0] SAIDA_INSTRUCAO;

    // Instancia o módulo registradorDeInstrucoes
    registradorDeInstrucoes DUT (
        .clk(CLK),
        .load(L1),
        .clr_msb(CLR),
        .ei_lsb(Ei),
        .entrada_instrucao(ENTRADA_INSTRUCAO),
        .saida_instrucao(SAIDA_INSTRUCAO)
    );

    // Geração de clock (20ns período)
    initial begin
        CLK = 0;
        forever #10 CLK = ~CLK;
    end

    // Sequência de teste
    initial begin
        // Inicializa sinais
        L1 = 0;
        CLR = 0;
        Ei = 0;
        ENTRADA_INSTRUCAO = 8'b00000000;

        // Aguarda um período de clock
        #20;

        // Carrega uma instrução completa (LSB e MSB habilitados)
        ENTRADA_INSTRUCAO = 8'b10110011;
        L1 = 1;
        Ei = 1;
        #20;
        L1 = 0;
        Ei = 0;

        // Aguarda um período para verificar a saída
        #20;

        // Tenta carregar apenas os LSB (EI_LSB = 1, LOAD = 1, CLR_MSB = 0)
        ENTRADA_INSTRUCAO = 8'b11110000;
        L1 = 1;
        Ei = 1;
        CLR = 0;
        #20;
        L1 = 0;
        Ei = 0;
        CLR = 0;

        // Aguarda um período para verificar a saída (MSB deve permanecer o mesmo)
        #20;

        // Tenta carregar apenas os MSB (EI_LSB = 0, LOAD = 1, CLR_MSB = 0)
        ENTRADA_INSTRUCAO = 8'b00001111;
        L1 = 1;
        Ei = 0;
        CLR = 0;
        #20;
        L1 = 0;
        Ei = 0;
        CLR = 0;

        // Aguarda um período para verificar a saída (LSB deve permanecer o mesmo)
        #20;

        // Limpa os MSB (CLR_MSB = 1)
        CLR = 1;
        #20;
        CLR = 0;

        // Aguarda para verificar se os MSB foram zerados
        #20;

        // Tenta carregar com LOAD desativado
        ENTRADA_INSTRUCAO = 8'b10101010;
        L1 = 0;
        Ei = 1;
        CLR = 0;
        #20;

    end

endmodule 