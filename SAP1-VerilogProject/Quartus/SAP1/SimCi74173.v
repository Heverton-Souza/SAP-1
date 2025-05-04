`timescale 1ns/1ps
module SimReg74173;

	//Entradas
   reg CLK;
	reg Lm;
   reg [3:0] O;
	
	//Saídas
   wire [3:0] Q;      

	 // Instancia o módulo
	 Ci74173 DUT (
		   .clk(CLK),
			.load(Lm),
		   .o(O),
		   .q(Q)
	 );
	 
	     // Gera o clock
    initial begin
        CLK = 0;
        forever #10 CLK = ~CLK; // Clock de 20ns
    end
	 

    initial begin
         // Inicialização
			Lm = 1; 
         O = 4'b0000;
			

         // Escreve valor 1010 com enable ativo
         #20 O = 4'b1010;


         // Muda a entrada, sem carregar
         #20 O = 4'b0101;


    end

endmodule