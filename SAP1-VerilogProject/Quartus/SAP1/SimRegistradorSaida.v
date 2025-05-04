`timescale 1ns/1ps
module SimRegistradorSaida;

    // Entradas
    reg CLK;
    reg Lo;
    reg [7:0] Entrada;

    // Saída
    wire [7:0] Saida;

    // Instancia o módulo do registrador de Saída
    registradorSaida DUT (
        .CLK(CLK),
        .Lo(Lo),
        .entrada(Entrada),
        .saida(Saida)
    );

    // Geração de clock (20ns de período)
    initial begin
        CLK = 0;
        forever #10 CLK = ~CLK;
    end

    // Sequência de teste
    initial begin
        // Inicialização
        Lo = 0;
        Entrada = 8'b00000000;

        // Aguarda 20ns
        #20 Entrada = 8'b11110000;
        Lo = 1;

        // Troca a entrada
        #20 Entrada = 8'b00001111;
		  
		  #20 Entrada = 8'b11110000;

    end

endmodule
