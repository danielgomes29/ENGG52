module orientacao ( // precisa ir para o norte?? quando reseta??
    input girar, clockc3, reset,
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

always @(posedge clockc3 or posedge reset) begin
$display("Girar = %b",girar);
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

