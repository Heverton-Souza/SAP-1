module registradorB (
    input CLK,
    input Lb,                    // Load do registrador B
    input [7:0] entrada,         // Vindo do barramento
    output [7:0] para_ula       // Sempre ativo
);

    wire [3:0] q_low, q_high;

    // Instâncias dos dois CI74173
    Ci74173 low_reg (				//Reg de bits menos significativos
        .clk(CLK),
        .load(Lb),
        .o(entrada[3:0]),
        .q(q_low)
    );

    Ci74173 high_reg (				//Reg de bits mais significativos
        .clk(CLK),
        .load(Lb),
        .o(entrada[7:4]),
        .q(q_high)
    );

    // Saída direta para ULA (sempre ativa)
    assign para_ula = {q_high, q_low};


endmodule
