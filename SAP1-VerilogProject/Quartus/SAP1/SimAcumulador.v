`timescale 1ns/1ps
module SimAcumulador;

    // Entradas
    reg CLK;
    reg La;
    reg Ea;
    reg [7:0] Entrada;

    // Saídas
    wire [7:0] ParaULA;
    wire [7:0] ParaBarramento;

    // Instancia o módulo do acumulador
    acumulador DUT (
        .CLK(CLK),
        .La(La),
        .Ea(Ea),
        .entrada(Entrada),
        .para_ula(ParaULA),
        .para_barramento(ParaBarramento)
    );

    // Geração de clock (20ns período)
    initial begin
        CLK = 0;
        forever #10 CLK = ~CLK;
    end

    // Sequência de teste
    initial begin
        // Inicializa sinais
        La = 0;
        Ea = 0;
        Entrada = 8'b00000000;

        // Aguarda 20ns
        #20 Entrada = 8'b10101010;
            La = 1;   // Habilita carga na próxima borda de subida
				
		  // Ativa saída para o barramento 
        #20 Ea = 1;


        // Troca a entrada, mas como La = 0, o valor não deve mudar
        #20 Entrada = 8'b01010101;
		  #20 Ea = 0;

        // Ativa saída para o barramento 
        #20 Ea = 1;

    end

endmodule
