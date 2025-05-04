module SomadorSubtrator (
    input [7:0] A,
    input [7:0] B,
    input  wire       Eu,       // Enable
    input  wire       Su,       // 0: soma | 1: subtração
    output reg  [7:0] O
);

    reg [7:0] resultado;

    always @(*) begin
        if (Eu == 1'b1) begin
            if (Su == 1'b0) begin
                resultado = A + B;         // Soma
            end else begin
                resultado = A - B;         // Subtração
            end
            O = resultado;
        end else begin
            O = 8'b00000000;               // Saída zerada se enable for 0
        end
    end

endmodule
