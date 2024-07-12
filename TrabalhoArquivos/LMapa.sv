module LMapa (
   input clockc1,
   input [0:2] acao,
   input [0:2] orientacao,
   input reset,
	
   output reg head,
   output reg left
);

  reg [0:21] Mapa [0:11];
  reg [0:7] Linha_Robo;
  reg [0:7] Coluna_Robo;

  initial begin
    Linha_Robo = 8'd11;
    Coluna_Robo = 8'd1;
    $readmemb("Mapa.txt", Mapa);
    print_mapa();
  end

  // Task to print the map
  task print_mapa;
    integer i;
    begin
      $display("Mapa:");
      for (i = 0; i < 12; i = i + 1) begin
        $write("%b\n", Mapa[i]);
      end
    end
  endtask

  always @(posedge clockc1 or posedge reset) begin
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
        3'b011: begin // Leste
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

            if (Linha_Robo < 11)
                head <= Mapa[Linha_Robo+1][Coluna_Robo];
	
            else
                head <= 1;

            if (Coluna_Robo < 21)
                left <= Mapa[Linha_Robo][Coluna_Robo+1];
            else
                left <= 1;
//$display(" teste 1Head: %b, Left: %b LinhaRobo: %d , ColunaRobo: %d", head, left,Linha_Robo,Coluna_Robo );
        end
        default: begin
            head <= 0;
            left <= 0;
        end
    endcase
  end

endmodule
