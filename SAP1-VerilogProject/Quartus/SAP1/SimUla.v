`timescale 1ns/1ps
module SimULA;

    // Entradas
    reg [7:0] A;
    reg [7:0] B;
    reg Eu;
    reg Add, Sub, AndOp, OrOp, XorOp, NotOp;

    // Saída
    wire [7:0] Out;

    // Instancia a ULA
    ula DUT (
        .A(A),
        .B(B),
        .Eu(Eu),
        .Add(Add),
        .Sub(Sub),
        .AndOp(AndOp),
        .OrOp(OrOp),
        .XorOp(XorOp),
        .NotOp(NotOp),
        .Out(Out)
    );

    // Procedimento de teste
    initial begin
        // Inicializa sinais
        A = 8'b00001111;
        B = 8'b11110000;
        Eu = 0;
        Add = 0; Sub = 0; AndOp = 0; OrOp = 0; XorOp = 0; NotOp = 0;

        #20 Eu = 1;

        // Testa soma
        #20 Add = 1;
        #20 Add = 0;

        // Testa subtração
        #20 Sub = 1;
        #20 Sub = 0;

        // Testa AND
        #20 AndOp = 1;
        #20 AndOp = 0;

        // Testa OR
        #20 OrOp = 1;
        #20 OrOp = 0;

        // Testa XOR
        #20 XorOp = 1;
        #20 XorOp = 0;

        // Testa NOT (sobre A)
        #20 NotOp = 1;
        #20 NotOp = 0;

        // Desativa a ULA
        #20 Eu = 0;

    end

endmodule
