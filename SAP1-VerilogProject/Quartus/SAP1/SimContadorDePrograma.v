`timescale 1ns/1ps
module SimContadorDePrograma;

    // Entradas
    reg Cp;
    reg CLK;
    reg CLR;
    reg Ep;
    reg Ej;
    reg [3:0] Addr;

    // Saída
    wire [3:0] Out;

    // Instancia o módulo do contador de programa
    contadorDePrograma DUT (
        .Cp(Cp),
        .CLK(CLK),
        .CLR(CLR),
        .Ep(Ep),
        .Ej(Ej),
        .Addr(Addr),
        .Out(Out)
    );

    // Geração de clock: 20ns de período (alternando a cada 10ns)
    initial begin
        CLK = 0;
        forever #10 CLK = ~CLK;
    end

    // Sequência de teste
    initial begin
        // Inicialização
        Cp = 0;
        CLR = 0;
        Ep = 0;
        Ej = 0;
        Addr = 4'b0000;

        // Aguarda uma borda de clock e reseta
        #5 CLR = 1;
        #20 CLR = 0;

        // Ativa Cp e Ep para começar a contar
        #10 Ep = 1; Cp = 1;

        // Deixa contar por 3 ciclos
        #60;

        // Testa um jump para endereço 0b1010
        #10 Ej = 1;
            Addr = 4'b1010;
        #20 Ej = 0;

        // Continua contando por mais 2 ciclos
        #40;

        // Desativa Ep (parar de mostrar saída)
        #10 Ep = 0;
		  
		  #20;
		  
		  #10 Ep = 1;

        // Aguarda mais alguns ciclos (o valor não deve mais sair)
        #40;

    end

endmodule
