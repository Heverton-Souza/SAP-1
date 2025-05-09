module contadorDePrograma(
    input wire Cp,  // Ligar Contador de programa
    input wire CLK, // Clock
    input wire CLR, // Clear (Reset)
    input wire Ep,  // Enable saida Contador de programa
    input wire Ej, //Enable Jump
    input wire [3:0] Addr, // Endereço de 4 bits para Jump
    output Out0,
    output Out1,
    output Out2,
    output Out3
);
    reg [3:0] pc; // Contador de programa (4 bits)

    always @(posedge CLK or posedge CLR) begin
        if (CLR) begin
            pc <= 4'b0000; // Zera o contador de programa (Reset)
        end else if (Ej) begin
            pc <= Addr; // Carrega o endereço de Jump
        end else if (Cp) begin
            pc <= pc + 1; // Incrementa o contador de programa
        end
    end

    // Saidas dos tri-state : só sai valor quando Ep = 1
    assign Out0 = Ep ? pc[0] : 1'b0;
    assign Out1 = Ep ? pc[1] : 1'b0;
    assign Out2 = Ep ? pc[2] : 1'b0;
    assign Out3 = Ep ? pc[3] : 1'b0;

endmodule