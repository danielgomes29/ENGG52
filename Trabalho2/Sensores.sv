module Sensores (
    input head,
    input left,
    input clockc2,
    input reset,
    input under,
    input barreira,
    output reg avancar,
    output reg girar,
    output reg remover
);

// Registrador de estado
    reg [2:0] state;
    reg [2:0] state_reg;

// Codificação dos estados
parameter procurandoMuro = 3'b000,
          Standby = 3'b111,
          AcompanhandoMuro = 3'b010,
          RemovendoEntulho = 3'b011,
          Gira = 3'b100,
          Gira2 = 3'b101,
          Gira3 = 3'b001;

// Inicialização da máquina
initial begin
    state = Standby;
    state_reg = Standby;
    avancar = 1'b0;
    girar = 1'b0;
end

// Estado próximo
always @(posedge clockc2) begin
    if (reset) begin
        state <= Standby;
        state_reg <= Standby;
    end else begin
        state_reg <= state;
        case (state)
            procurandoMuro: begin
                if ({head, under, barreira} == 3'b100) begin
                    state <= procurandoMuro;
                end else if ({head, under, barreira} == 3'b101) begin
                    state <= Standby;
                end else if ({head, under, barreira} == 3'b000) begin
                    state <= AcompanhandoMuro;
                end else if (under) begin
                    state <= Standby;
                end
            end
            RemovendoEntulho: begin
                if ({head, under, barreira} == 3'b001) begin
                    state <= RemovendoEntulho;
                end else if ({head, under, barreira} == 3'b000) begin
                    state <= AcompanhandoMuro;
                end else if (head || under) begin
                    state <= Standby;
                end
            end
            AcompanhandoMuro: begin
                if ({head, left, under, barreira} == 4'b0100) begin
                    state <= AcompanhandoMuro;
                end else if ({head, left} == 2'b10) begin
                    state <= Gira;
                end else if ({left, under, barreira} == 3'b000) begin
                    state <= procurandoMuro;
                end else if ({head, left, under, barreira} == 4'b1100) begin
                    state <= Gira;
                end else if ({head, under, barreira} == 3'b101) begin
                    state <= Standby;
                end else if (under) begin
                    state <= Standby;
                end
            end
            Gira: begin
                if ({head, left} == 2'b00) begin
                    state <= AcompanhandoMuro;
                end else begin
                    state <= Gira2;
                end
            end
            Gira2: begin
                if ({head, left} == 2'b00) begin
                    state <= Gira3;
                end else begin
                    state <= AcompanhandoMuro;
                end
            end
            Gira3: begin
                state <= AcompanhandoMuro;
            end
            default: begin
                state <= procurandoMuro;
                state_reg <= procurandoMuro;
            end
        endcase
    end
end

// Valor da saída
always @(head , left , state) begin
    $display("Head:%b Left:%b Estado_anterior:%b Estado_atual:%b", head, left, state_reg, state);
    case (state)
        procurandoMuro: begin
            if ({head, left} == 2'b00 || {head, left} == 2'b01) begin
                avancar = 1'b1;
                girar = 1'b0;
            end else if ({head, left} == 2'b10 || {head, left} == 2'b11) begin
                avancar = 1'b0;
                girar = 1'b1;
            end
        end
        RemovendoEntulho: begin
            if ({head, left} == 2'b00 || {head, left} == 2'b10) begin
                avancar = 1'b0;
                girar = 1'b1;
            end else if ({head, left} == 2'b01) begin
                avancar = 1'b1;
                girar = 1'b0;
            end else if ({head, left} == 2'b11) begin
                avancar = 1'b0;
                girar = 1'b1;
                $display("status ");
            end
        end
        AcompanhandoMuro: begin
            if ({head, left} == 2'b00 || {head, left} == 2'b01) begin
                avancar = 1'b1;
                girar = 1'b0;
            end else if ({head, left} == 2'b10 || {head, left} == 2'b11) begin
                avancar = 1'b0;
                girar = 1'b1;
            end
        end
        Gira: begin
            if ({head, left} == 2'b00) begin
                avancar = 1'b1;
                girar = 1'b0;
            end else begin
                avancar = 1'b0;
                girar = 1'b1;
            end
        end
        Gira2: begin
	$display("status Gira 2 ");
            if ({head, left} == 2'b00) begin
                avancar = 1'b0;
                girar = 1'b1;
            end else if ({head, left} == 2'b01) begin
                avancar = 1'b1;
                girar = 1'b0;
            end else
		avancar = 1'b0;
		girar = 1'b1;
	
        end
        Gira3: begin
	$display("status Gira 3 ");
            if ({head, left} == 2'b00) begin
                avancar = 1'b0;
                girar = 1'b1;
            end else begin
                avancar = 1'b1;
                girar = 1'b0;
            end
        end
        default: begin
            avancar = 1'b0;
            girar = 1'b0;
        end
    endcase
end

endmodule

