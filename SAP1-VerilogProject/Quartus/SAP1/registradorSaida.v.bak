module registradorSaida (
    input CLK,
    input Lo,                    // Load do acumulador
    input [7:0] entrada,         // Vindo do barramento
    output [7:0] saida      		
);

    wire [3:0] q_low, q_high;

    // Instâncias dos dois CI74173
    Ci74173 low_reg (				//Reg de bits menos significativos
        .clk(CLK),
        .load(Lo),
        .o(entrada[3:0]),
        .q(q_low)
    );

    Ci74173 high_reg (				//Reg de bits mais significativos
        .clk(CLK),
        .load(Lo),
        .o(entrada[7:4]),
        .q(q_high)
    );

	 // Saida final
    assign saida = {q_high, q_low};


endmodule
