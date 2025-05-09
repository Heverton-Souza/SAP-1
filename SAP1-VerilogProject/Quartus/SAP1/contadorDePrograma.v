module contadorDePrograma(
	 // inputs de controle 
    input wire Cp,             // Ligar (contar)
    input wire CLK,            // Clock
    input wire CLR,            // Reset
    input wire Ep,             // Enable saída
    input wire Ej,             // Enable Jump
	 // input de dado
    input wire [3:0] Addr,     // Endereço de Jump
	 // output
    output reg [3:0] Out       // Saída do contador (vetor de 4 bits)
);
    reg [3:0] pc; // Registrador interno do contador

    always @(posedge CLK or posedge CLR) begin
        if (CLR)
            pc <= 4'b0000;           // Reset
        else if (Ej)
            pc <= Addr;              // Jump
        else if (Cp)
            pc <= pc + 1;            // Incremento normal
    end

    always @(*) begin
        if (Ep)
            Out = pc;                // Exibe valor atual do contador
        else
            Out = 4'bzzzz;           // Tri-state simulado
    end

endmodule
