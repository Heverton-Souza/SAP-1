module acumulador (
    input CLK,
    input La,                    // Load do acumulador
    input Ea,                    // Enable para o barramento
    input [7:0] entrada,         // Vindo do barramento
    output [7:0] para_ula,       // Sempre ativo
    output [7:0] para_barramento // Tri-state controlado por Ea
);

    wire [3:0] q_low, q_high;

    // Instâncias dos dois CI74173
    Ci74173 low_reg (				//Reg de bits menos significativos
        .clk(CLK),
        .load(La),
        .o(entrada[3:0]),
        .q(q_low)
    );

    Ci74173 high_reg (				//Reg de bits mais significativos
        .clk(CLK),
        .load(La),
        .o(entrada[7:4]),
        .q(q_high)
    );

    // Saída direta para ULA (sempre ativa)
    assign para_ula = {q_high, q_low};

    // Saída para barramento: controlada por Ea com lógica tri-state
    assign para_barramento = Ea ? {q_high, q_low} : 8'bz;

endmodule
