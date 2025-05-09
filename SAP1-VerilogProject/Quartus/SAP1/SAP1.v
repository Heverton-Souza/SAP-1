module SAP1(
    input wire limpar_iniciar,       // botão para limpar/iniciar (reset)
    input wire run_prog,             // modo: 0 = programar | 1 = executar
    input wire leitura_escrita,      // 0 = escrever na RAM | 1 = ler da RAM
    input wire clk_in,               // clock externo

    output wire [7:0] saida_final    // saída final do registrador de saída
);

    // Clock e reset
    wire CLK = clk_in;
    wire CLR = limpar_iniciar;

    // Barramento de controle e dados
    wire Cp, Ep, Ej;
    wire Eu, Add, Sub, AndOp, OrOp, XorOp, NotOp;
    wire La, Ea, Lb;
    wire Lm, CE, L1, Ei, L0;

    wire [7:0] para_barramento;
    wire [7:0] para_ula;
    wire [7:0] entrada;
    wire [7:0] data_out;
    wire [7:0] saida_instrucao;
    wire [7:0] saida;
    wire [3:0] Out;
    wire [3:0] Addr;
    wire [3:0] opcode;

    wire [7:0] A;
    wire [7:0] B;

    // Sinais derivados
    assign entrada = data_out;
    assign opcode = saida_instrucao[7:4];
    assign Addr = saida_instrucao[3:0];

    // ======== INSTANCIAMENTO DOS MÓDULOS =========

    // Unidade de Controle
    unidadeDeControle unidadeDeControle_inst (
        .CLK(CLK), .CLR(CLR), .opcode(opcode),
        .Cp(Cp), .Ep(Ep), .Ej(Ej),
        .Eu(Eu), .Add(Add), .Sub(Sub),
        .AndOp(AndOp), .OrOp(OrOp), .XorOp(XorOp), .NotOp(NotOp),
        .La(La), .Ea(Ea), .Lb(Lb),
        .Lm(Lm), .CE(CE), .L1(L1), .Ei(Ei), .L0(L0)
    );

    // Contador de Programa
    contadorDePrograma contadorDePrograma_inst (
        .Cp(Cp), .CLK(CLK), .CLR(CLR),
        .Ep(Ep), .Ej(Ej), .Addr(Addr), .Out(Out)
    );

    // MAR
    MAR MAR_inst (
        .CLK(CLK), .Lm(Lm),
        .SELECT(run_prog), // SELECT: 0 = execução | 1 = programação
        .A(Out), .D(Addr), .Out(Addr)
    );

    // RAM
    RAM RAM_inst (
        .addr(Addr),
        .data_in(para_barramento),
        .run_prog(run_prog),
        .ce(CE),
        .leitura_escrita(leitura_escrita),
        .data_out(data_out)
    );

    // Registrador de Instruções
    registradorDeInstrucoes registradorDeInstrucoes_inst (
        .clk(CLK), .load(L1),
        .clr_msb(CLR), .ei_lsb(Ei),
        .entrada_instrucao(data_out),
        .saida_instrucao(saida_instrucao)
    );

    // Acumulador
    acumulador acumulador_inst (
        .CLK(CLK), .La(La), .Ea(Ea),
        .entrada(entrada),
        .para_ula(A), .para_barramento(para_barramento)
    );

    // Registrador B
    registradorB registradorB_inst (
        .CLK(CLK), .Lb(Lb),
        .entrada(entrada),
        .para_ula(B)
    );

    // ULA
    ula ula_inst (
        .A(A), .B(B),=
        .Eu(Eu), .Add(Add), .Sub(Sub),
        .AndOp(AndOp), .OrOp(OrOp),
        .XorOp(XorOp), .NotOp(NotOp),
        .Out(entrada)
    );

    // Registrador de Saída
    registradorSaida registradorSaida_inst (
        .CLK(CLK), .Lo(L0),
        .entrada(entrada),
        .saida(saida_final)
    );

endmodule