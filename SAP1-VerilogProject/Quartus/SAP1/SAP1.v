module SAP1(
    input wire limpar_iniciar,       // botão para limpar/iniciar (reset)
    input wire run_prog,             // modo: 0 = programar | 1 = executar
    input wire leitura_escrita,      // 0 = escrever na RAM | 1 = ler da RAM
    input wire clk_in,               // clock externo

    output wire [7:0] saida_final    // saída final do registrador de saída
);

    // Clock e reset
    wire CLK_sig = clk_in;
    wire CLR_sig = limpar_iniciar;

    // Barramento de controle e dados
    wire Cp_sig, Ep_sig, Ej_sig;
    wire Eu_sig, Add_sig, Sub_sig, AndOp_sig, OrOp_sig, XorOp_sig, NotOp_sig;
    wire La_sig, Ea_sig, Lb_sig;
    wire Lm_sig, CE_sig, L1_sig, Ei_sig, L0_sig;

    wire [7:0] para_barramento_sig;
    wire [7:0] para_ula_sig;
    wire [7:0] entrada_sig;
    wire [7:0] data_out_sig;
    wire [7:0] saida_instrucao_sig;
    wire [7:0] saida_sig;
    wire [3:0] Out_sig;
    wire [3:0] Addr_sig;
    wire [3:0] opcode_sig;

    wire [7:0] A_sig;
    wire [7:0] B_sig;

    // Sinais derivados
    assign entrada_sig = data_out_sig;
    assign opcode_sig = saida_instrucao_sig[7:4];
    assign Addr_sig = saida_instrucao_sig[3:0];

    // ======== INSTANCIAMENTO DOS MÓDULOS =========

    // Unidade de Controle
    unidadeDeControle unidadeDeControle_inst (
        .CLK(CLK_sig), .CLR(CLR_sig), .opcode(opcode_sig),
        .Cp(Cp_sig), .Ep(Ep_sig), .Ej(Ej_sig),
        .Eu(Eu_sig), .Add(Add_sig), .Sub(Sub_sig),
        .AndOp(AndOp_sig), .OrOp(OrOp_sig), .XorOp(XorOp_sig), .NotOp(NotOp_sig),
        .La(La_sig), .Ea(Ea_sig), .Lb(Lb_sig),
        .Lm(Lm_sig), .CE(CE_sig), .L1(L1_sig), .Ei(Ei_sig), .L0(L0_sig)
    );

    // Contador de Programa
    contadorDePrograma contadorDePrograma_inst (
        .Cp(Cp_sig), .CLK(CLK_sig), .CLR(CLR_sig),
        .Ep(Ep_sig), .Ej(Ej_sig), .Addr(Addr_sig), .Out(Out_sig)
    );

    // MAR
    MAR MAR_inst (
        .CLK(CLK_sig), .Lm(Lm_sig),
        .SELECT(run_prog), // SELECT: 0 = execução | 1 = programação
        .A(Out_sig), .D(Addr_sig), .Out(Addr_sig)
    );

    // RAM
    RAM RAM_inst (
        .addr(Addr_sig),
        .data_in(para_barramento_sig),
        .run_prog(run_prog),
        .ce(CE_sig),
        .leitura_escrita(leitura_escrita),
        .data_out(data_out_sig)
    );

    // Registrador de Instruções
    registradorDeInstrucoes registradorDeInstrucoes_inst (
        .clk(CLK_sig), .load(L1_sig),
        .clr_msb(CLR_sig), .ei_lsb(Ei_sig),
        .entrada_instrucao(data_out_sig),
        .saida_instrucao(saida_instrucao_sig)
    );

    // Acumulador
    acumulador acumulador_inst (
        .CLK(CLK_sig), .La(La_sig), .Ea(Ea_sig),
        .entrada(entrada_sig),
        .para_ula(A_sig), .para_barramento(para_barramento_sig)
    );

    // Registrador B
    registradorB registradorB_inst (
        .CLK(CLK_sig), .Lb(Lb_sig),
        .entrada(entrada_sig),
        .para_ula(B_sig)
    );

    // ULA
    ula ula_inst (
        .A(A_sig), .B(B_sig),
        .Eu(Eu_sig), .Add(Add_sig), .Sub(Sub_sig),
        .AndOp(AndOp_sig), .OrOp(OrOp_sig),
        .XorOp(XorOp_sig), .NotOp(NotOp_sig),
        .Out(entrada_sig)
    );

    // Registrador de Saída
    registradorSaida registradorSaida_inst (
        .CLK(CLK_sig), .Lo(L0_sig),
        .entrada(entrada_sig),
        .saida(saida_final)
    );

endmodule