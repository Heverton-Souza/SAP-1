`timescale 1ns/1ps
module SimRAM;

    reg [3:0] Endereco;  
    reg [7:0] Dado_In;
    reg RunProg_, CE_, LeituraEscrita_;
    wire [7:0] Dado_Out;

	 
    RAM DUT(
        .addr(Endereco),
        .data_in(Dado_In),
        .run_prog(RunProg_),
        .ce(CE_),
        .leitura_escrita(LeituraEscrita_),
        .data_out(Dado_Out)
    );

    initial begin
        Endereco = 4'd0;
        Dado_In = 8'd0;
        RunProg_ = 0;
        CE_ = 0;
        LeituraEscrita_ = 0;

        // Aguarda 20ns e começa a simulação
        #20 Dado_In = 8'd42;     // Valor a ser escrito
        Endereco = 4'd2;
        RunProg_ = 1;
        CE_ = 1;
        LeituraEscrita_ = 0;     // 1 para escrita
        #20 CE_ = 0;

        // Leitura do mesmo endereço
        #20 RunProg_ = 0;
        CE_ = 1;
        LeituraEscrita_ = 1;     // 0 para leitura
        #20 CE_ = 0;

        // Teste com outro valor/endereço
        #20 Dado_In = 8'd99;
        Endereco = 4'd3;
        RunProg_ = 1;
        CE_ = 1;
        LeituraEscrita_ = 0;
        #20 CE_ = 0;

        #20 RunProg_ = 0;
        CE_ = 1;
        LeituraEscrita_ = 1;
        #20 CE_ = 0;

    end

endmodule
