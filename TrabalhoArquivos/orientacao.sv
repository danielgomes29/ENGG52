module orientacao ( // precisa ir para o norte?? quando reseta??
    input girar, clockc2, reset,
    output reg [0:2] orientacao
);

    reg [0:2] state;

// Estados
parameter
    Norte = 3'b001,
    Oeste = 3'b010,
    Leste = 3'b011,
    Sul = 3'b100;

initial begin
    state = Norte;
  orientacao = Norte;
end

always @(posedge clockc2 or posedge reset) begin
    if (reset) begin
        state <= Norte;
        orientacao <= Norte;
    end else if (girar) begin

        case (state)
          Norte: state = Oeste; 
            Oeste: state = Sul;
            Sul: state = Leste;
            Leste: state = Norte;
            default: state = Norte;
        endcase
        orientacao <= state;
    end

end

endmodule

//module avanco (
//    input avancar, c3, reset,
//    input [2:0] orientacao,
//    output reg [2:0] acao
//);
//
//reg [2:0] state;
//
//// Parâmetros dos estados
//parameter parado = 3'b000,
//          acaoN = 3'b001,
//          acaoO = 3'b010,
//          acaoL = 3'b011,
//          acaoS = 3'b100;
//
//initial begin
//    state = parado;
//  acao = 3'b000;
//end
//
//always @(posedge c3 or posedge reset) begin
//    if (reset) begin
//        state = parado;
//    end else if (avancar) begin
//        case (orientacao)
//            3'b001: state = acaoN;
//            3'b010: state = acaoO;
//            3'b011: state = acaoL;
//            3'b100: state = acaoS;
//            default: state = parado;
//        endcase
//    end else begin
//      state = parado;
//    end
//    acao <= state;
//
//end
//
//endmodule
