module mux74157 (
    input select,
    input [3:0] a, // entrada 0 (ex: modo programação)
    input [3:0] d, // entrada 1 (ex: modo execução)
    output [3:0] out
);
    assign out = select ? d : a;
endmodule 