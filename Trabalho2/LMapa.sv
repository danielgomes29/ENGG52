module LMapa (
   input clockc1,
   input [0:2] acao,
   input [0:2] orientacao,
   input reset,
	
   output reg head,
   output reg left
);

  reg [0:79] Mapa [0:9]; // 20 colunas e 10 linhas
  reg [0:7] Linha_Robo;
  reg [0:7] Coluna_Robo;
reg [0:3] Posatt;

  initial begin
    Linha_Robo = 8'd9;
    Coluna_Robo = 8'd68;
    $readmemh("Mapa.txt", Mapa);
    print_mapa();
  end

  // Task para imprimir o mapa
  task print_mapa;
    integer i;
    begin
      $display("Mapas:");
      for (i = 0; i < 10; i = i + 1) begin
        $write("%h\n", Mapa[i]);
      end
    end
  endtask

  always @(posedge clockc1 or posedge reset) begin
	Posatt = Mapa[Linha_Robo][Coluna_Robo +: 4];
 //   $display("teste Linha_Robo: %d, Coluna_Robo: %d possatt:%h", Linha_Robo, Coluna_Robo, Posatt);
    if (reset) begin
        head <= 4'b0000;
        left <= 4'b0000;

        // Reinicia a posição do robô
    end else if (acao != 3'b000) begin
        // Zera a posição atual do robô no mapa

	//print_mapa();
        case (acao)
            3'b001 : Linha_Robo = Linha_Robo - 1; // Norte
            3'b010 : Coluna_Robo = Coluna_Robo - 4; // Oeste
            3'b011 : Coluna_Robo = Coluna_Robo + 4; // Sul
            3'b100 : Linha_Robo = Linha_Robo + 1; // Leste
            default: ; // Sem ação
        endcase
    end

    case (orientacao)
        3'b001: begin // Norte
            if (Linha_Robo > 0 && Coluna_Robo < 80)
                head <= Mapa[Linha_Robo-1][Coluna_Robo +: 4];
            else
                head <= 1;

            if (Linha_Robo < 10 && Coluna_Robo >= 3)
                left <= Mapa[Linha_Robo][Coluna_Robo-4 +: 4];
            else
                left <= 1;
        end
        3'b010: begin 
            if (Linha_Robo < 10 && Coluna_Robo >= 3)
                head <= Mapa[Linha_Robo][Coluna_Robo-4 +: 4];
            else
                head <= 1;

            if (Linha_Robo < 9)
                left <= Mapa[Linha_Robo+1][Coluna_Robo +: 4];
            else
                left <= 1;
        end
        3'b011: begin 
            if (Linha_Robo < 10 && Coluna_Robo < 77)
                head <= Mapa[Linha_Robo][Coluna_Robo+4 +: 4];
            else
                head <= 1;

            if (Linha_Robo > 0)
                left <= Mapa[Linha_Robo-1][Coluna_Robo +: 4];
            else
                left <= 1;
        end
        3'b100: begin
            if (Linha_Robo < 9)
                head <= Mapa[Linha_Robo+1][Coluna_Robo +: 4];
            else
                head <= 1;

            if (Coluna_Robo < 77)
                left <= Mapa[Linha_Robo][Coluna_Robo +: 4];
            else
                left <= 1;
        end
        default: begin
            head <= 0;
            left <= 0;
        end
    endcase

	Mapa[Linha_Robo][Coluna_Robo +: 4] = 4'b1111;
	print_mapa();
        Mapa[Linha_Robo][Coluna_Robo +: 4] = 4'b0000;

$display("testes acao :%b Orientacao: %b Linha_Robo: %d, Coluna_Robo: %d ",acao,orientacao,Linha_Robo,Coluna_Robo);
  end
endmodule
