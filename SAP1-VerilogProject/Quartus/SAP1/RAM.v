module RAM (
    input wire [3:0] addr,              // Endereço de 4 bits (16 posições)
    input wire [7:0] data_in,           // Entrada de dados
    input wire run_prog,                // Sinal para programar RAM
    input wire ce,                      // Chip Enable
    input wire leitura_escrita,         // 1 = leitura, 0 = escrita
    output reg [7:0] data_out           // Saída de dados
);

    // Memória com 16 posições de 8 bits
    reg [7:0] memoria [15:0];

    always @(*) begin
        if (ce && leitura_escrita) begin
            // Leitura
            data_out = memoria[addr];
        end else begin
            data_out = 8'bzzzzzzzz; // Alta impedância quando não está lendo
        end
    end

    always @(*) begin
        if (run_prog && ce && !leitura_escrita) begin
            // Escrita
            memoria[addr] = data_in;
        end
    end

endmodule
