`timescale 1ns/1ps

module SimContadorDePrograma;

    // Entradas
    reg Cp;
    reg CLK;
    reg CLR;
    reg Ep;
    reg Ej;
    reg [3:0] Addr;

    // Saídas
    wire Out0, Out1, Out2, Out3;

    // Instancia o módulo
    contadorDePrograma DUT (
        .Cp(Cp),
        .CLK(CLK),
        .CLR(CLR),
        .Ep(Ep),
        .Ej(Ej),
        .Addr(Addr),
        .Out0(Out0),
        .Out1(Out1),
        .Out2(Out2),
        .Out3(Out3)
    );

    // Geração de clock
    initial begin
        CLK = 0;
        forever #10 CLK = ~CLK; // Clock de 20ns
    end

    // Sequência de teste
    initial begin
        // Inicialização
        CLR = 1; Cp = 0; Ep = 0; Ej = 0; Addr = 4'b0000;
        #25 CLR = 0;

        // Incremento normal do PC
        Cp = 1; Ep = 1;
        #40; // 2 ciclos de clock

        // Pausa no incremento
        Cp = 0;
        #20;

        // JUMP para endereço 1010
        Addr = 4'b1010;
        Ej = 1;
        #20 Ej = 0;

        // Incrementa a partir do endereço novo
        Cp = 1;
        #40;

        // Teste de tri-state (Ep = 0)
        Ep = 0;
        #20;

        // Volta Ep para 1 para ver a saída novamente
        Ep = 1;
        #20;

        $stop; // Encerra a simulação
    end

endmodule
