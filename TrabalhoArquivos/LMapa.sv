module LMapa (
   input clock,
   input [2:0] acao,
   input [2:0] orientacao,
   input reset,
	
   output reg head,
   output reg left
);

  reg [19:0] Mapa [19:0];
  reg [7:0] Linha_Robo;
  reg [7:0] Coluna_Robo;

initial begin
    Linha_Robo = 8'd1;
    Coluna_Robo = 8'd1;
    $readmemb("Mapa.txt", Mapa);
end

  
always @(posedge clock or posedge reset) begin
    if (reset) begin
        head <= 0;
        left <= 0;

    end else if (acao) begin
        case (acao)
            3'b001 : Linha_Robo = Linha_Robo - 1;
            3'b010 : Coluna_Robo = Coluna_Robo - 1;
            3'b011 : Linha_Robo = Linha_Robo + 1;
            3'b100 : Coluna_Robo = Coluna_Robo + 1;
            default: ; // No action
        endcase
    end

    case (orientacao)
        3'b001: begin
            if (Linha_Robo > 0 && Coluna_Robo < 20)
                head <= Mapa[Linha_Robo-1][Coluna_Robo];
            else
                head <= 1;

            if (Linha_Robo < 20 && Coluna_Robo > 0)
                left <= Mapa[Linha_Robo][Coluna_Robo-1];
            else
                left <= 1;
        end
        3'b010: begin
            if (Linha_Robo < 20 && Coluna_Robo > 0)
                head <= Mapa[Linha_Robo][Coluna_Robo-1];
            else
                head <= 1;

            if (Linha_Robo < 19)
                left <= Mapa[Linha_Robo+1][Coluna_Robo];
            else
                left <= 1;
        end
        3'b011: begin
            if (Linha_Robo < 20 && Coluna_Robo < 19)
                head <= Mapa[Linha_Robo][Coluna_Robo+1];
            else
                head <= 1;

            if (Linha_Robo > 0)
                left <= Mapa[Linha_Robo-1][Coluna_Robo];
            else
                left <= 1;
        end
        3'b100: begin
            if (Linha_Robo < 19)
                head <= Mapa[Linha_Robo+1][Coluna_Robo];
            else
                head <= 1;

            if (Coluna_Robo < 19)
                left <= Mapa[Linha_Robo][Coluna_Robo+1];
            else
                left <= 1;
        end
        default: begin
            head <= 0;
            left <= 0;
        end
    endcase
end

endmodule