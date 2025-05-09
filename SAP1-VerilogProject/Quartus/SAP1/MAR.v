module MAR (
    input CLK,			// Clock
    input Lm,        // Load MAR - Vindo da unidade de Controle
    input SELECT,    // 0 = modo programação, 1 = execução normal
    input [3:0] A,   // entrada do mux (modo programação)
    input [3:0] D,   // entrada do registrador (vindo do barramento central)
    output [3:0] Out // saída para a RAM (endereço efetivo)
);

    wire [3:0] Q;
	 
	 // Instância do CI 74173 (registrador de 4 bits)
    Ci74173 registrador (
        .clk(CLK),
        .load(Lm),
        .o(D),
        .q(Q)
    );

    // Lógica de seleção (mux simples embutido)
    assign Out = (SELECT == 1'b0) ? A : Q;

endmodule 
