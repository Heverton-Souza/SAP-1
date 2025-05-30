module unidadeDeControle(
    input wire CLK,
    input wire CLR,
    input wire [3:0] opcode,

    // Contador de Programa
    output reg Cp,      // Incrementa PC
    output reg Ep,      // Enable saída PC
    output reg Ej,      // Enable JUMP (carrega novo endereço no PC)

    // ULA
    output reg Eu,      // Enable ULA (ativa saída)
    output reg Add,     // Operação soma
    output reg Sub,     // Operação subtração
    output reg AndOp,   // Operação AND
    output reg OrOp,    // Operação OR
    output reg XorOp,   // Operação XOR
    output reg NotOp,   // Operação NOT

    // Acumulador
    output reg La,      // Load acumulador
    output reg Ea,      // Enable saída acumulador

    // Registrador B
    output reg Lb,      // Load registrador B

    // MAR
    output reg Lm,      // Load MAR

    // RAM
    output reg CE,      // Chip Enable memória

    // Registrador de Instruções
    output reg L1,      // Load IR
    output reg Ei,      // Enable Instrução (para barramento)

    // Registrador de saída
    output reg L0       // Load saída
);

    // Estado de tempo (T0 a T6)
    reg [2:0] t_state;

    // Avança o tempo de máquina
    always @(posedge CLK or posedge CLR) begin
		if (CLR)
			 t_state <= 3'd0;
		else if (t_state == 3'd6)
			 t_state <= 3'd0; // Reinicia após T6
		else
			 t_state <= t_state + 3'd1;
    end
	 

    // Gera os sinais de controle com base no estado e opcode
    always @(*) begin
        // Zera todos os sinais
        {Cp, Ep, Ej, Eu, Add, Sub, AndOp, OrOp, XorOp, NotOp,
         La, Ea, Lb, Lm, CE, L1, Ei, L0} = 18'b0;

        case (t_state)
            // T0: PC -> MAR
            3'd0: begin
                Ep = 1; // Enable sída de programa
                Lm = 1; // Load MAR
            end

            // T1: RAM -> IR
            3'd1: begin
                CE = 1; // Enable RAM
                L1 = 1; // Load IR
            end

            // T2: PC++
            3'd2: begin
                Cp = 1; // Incrementa Contador
            end

            // T3: Decodificação e preparação
            3'd3: begin
                case (opcode)
						  4'b0001, // LDA
                    4'b0100, // ADD
                    4'b0101, // SUB
                    4'b0110, // AND
                    4'b0111, // OR
                    4'b1000, // XOR
                    4'b1001, // NOT
						  4'b1010, // JUMP
 						  4'b1110: begin  // OUT 
                        Ei = 1; // Enable Instrução
                        Lm = 1; // Load MAR
                    end
                endcase
            end

            // T4: Execução
            3'd4: begin
                case (opcode)
						  4'b0001: begin // LDA 
								CE = 1; // Enable RAM
								La = 1; // Load A
						  end
                    4'b0100, 4'b0101, 4'b0110, 4'b0111, 4'b1000: begin  // ADD, SUB, AND, OR, XOR
								
                        CE = 1; // Enable RAM
                        Lb = 1; // Load B
                    end
                    4'b1001: begin // NOT
                        Eu = 1;    // Enable ULA
                        NotOp = 1; // Controle NOT
								Ea = 1;    // Enable saida final
                    end
                    4'b1010: begin // JUMP
                        Ej = 1;    // Enable jump
                    end
                endcase
            end

            // T5: Execução final de operações binárias
            3'd5: begin // Caso operação da ULA
                case (opcode) //Enable ULA para todos
                    4'b0100: begin Eu = 1; Add   = 1; end // Controle ADD
                    4'b0101: begin Eu = 1; Sub   = 1; end // Controle SUB
                    4'b0110: begin Eu = 1; AndOp = 1; end // Controle And
                    4'b0111: begin Eu = 1; OrOp  = 1; end // Controle Or
                    4'b1000: begin Eu = 1; XorOp = 1; end // Controle Xor
                endcase
            end
        endcase
    end

endmodule