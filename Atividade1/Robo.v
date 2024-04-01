module Robo (head, left, clock, reset, avancar, girar);

input head, left, clock, reset;
output reg avancar, girar; // Alterei para "output reg" para poder atribuir valores diretamente

// Registrador de estado
reg [1:0] state;

// Codificação dos estados
parameter procurandoMuro = 2'b00,
          Rotacionando = 2'b01,
          AcompanhandoMuro = 2'b10;

// Inicialização da máquina
initial begin
    state <= procurandoMuro;
end

// estado próximo
always @(posedge clock or posedge reset) begin
    if (reset) begin
        state <= procurandoMuro;
    end else begin
        case (state)
            procurandoMuro : begin
                if ({head,left} == 2'b00) begin
                    state <= procurandoMuro;
                end
                if ({head,left} == 2'b01) begin
                    state <= AcompanhandoMuro;
                end
                if ({head,left} == 2'b10) begin
                    state <= Rotacionando;
                end
                if ({head,left} == 2'b11) begin
                    state <= Rotacionando;
                end
            end
            Rotacionando : begin
                if ({head,left} == 2'b00) begin
                    state <= Rotacionando;
                end
                if ({head,left} == 2'b01) begin
                    state <= AcompanhandoMuro;
                end
                if ({head,left} == 2'b10) begin
                    state <= Rotacionando;
                end
                if ({head,left} == 2'b11) begin
                    state <= Rotacionando;
                end
                // pode por se for 01 a acompanhdou muro se não rotacionando
            end
            AcompanhandoMuro: begin
                if ({head,left} == 2'b00) begin
                    state <= procurandoMuro;
                end
                if ({head,left} == 2'b01) begin
                    state <= AcompanhandoMuro;
                end
                if ({head,left} == 2'b10) begin
                    state <= procurandoMuro;
                end
                if ({head,left} == 2'b11) begin
                    state <= Rotacionando;
                end
            end
            default: state <= procurandoMuro;
        endcase
    end
end

// valor da saída
always @(state, head, left) begin
    case (state)
        procurandoMuro : begin
            if ({head,left} == 2'b00) begin
                avancar = 1'b1;
                girar = 1'b0;
            end
            if ({head,left} == 2'b01) begin
                avancar = 1'b1;
                girar = 1'b0;
            end
            if ({head,left} == 2'b10) begin
                avancar = 1'b0;
                girar = 1'b1;
            end
            if ({head,left} == 2'b11) begin
                avancar = 1'b0;
                girar = 1'b1;
            end
        end
        Rotacionando : begin
            if ({head,left} == 2'b00) begin
                avancar = 1'b0;
                girar = 1'b1;
            end
            if ({head,left} == 2'b01) begin
                avancar = 1'b1;
                girar = 1'b0;
            end
            if ({head,left} == 2'b10) begin
                avancar = 1'b0;
                girar = 1'b1;
            end
            if ({head,left} == 2'b11) begin
                avancar = 1'b0;
                girar = 1'b1;
            end
        end
        AcompanhandoMuro : begin
            if ({head,left} == 2'b00) begin
                avancar = 1'b0;
                girar = 1'b1;
            end
            if ({head,left} == 2'b01) begin
                avancar = 1'b1;
                girar = 1'b0;
            end
            if ({head,left} == 2'b10) begin
                avancar = 1'b0;
                girar = 1'b1;
            end
            if ({head,left} == 2'b11) begin
                avancar = 1'b0;
                girar = 1'b1;
            end
        end
        default: begin
            avancar = 1'b0;
            girar = 1'b0;
        end
    endcase
end

endmodule