// Fiz um testbench global falta só por  o que a gente quer testar com o tempo :

`timescale 1ns / 1ps

module testbench;

    reg clock;
    wire c1;
    wire c2;
    wire c3;
    wire c4;

    reg reset;

    wire head;
    wire left;

    reg under;
    reg barreira;

    wire avancar;
    wire girar;
    wire remover;

    wire [2:0] orientacao;
    wire [2:0] acao;

    // módulos
    LMapa UUT_LMapa (
        .clockc1(c1),
        .acao(acao),
        .orientacao(orientacao),
        .reset(reset),
        .head(head),
        .left(left)
    );

    divisorclock UUT_divisorclock ( 
        .clock(clock),
        .c1(c1), 
        .c2(c2), 
        .c3(c3), 
        .c4(c4) 
    );

    orientacao UUT_orientacao ( 
        .girar(girar), 
        .clockc3(c2), 
        .reset(reset),
        .orientacao(orientacao)
    );

    Sensores UUT_Sensores (
        .head(head),
        .left(left),
        .clockc2(c3),
        .reset(reset),
        .under(under),
        .barreira(barreira),
        .avancar(avancar),
        .girar(girar),
        .remover(remover)
    );

    avanco UUT_avanco (
        .avancar(avancar), 
        .clockc3(c2), 
        .reset(reset),
        .orientacao(orientacao),
        .acao(acao)
    );

    // clock
    initial begin
        clock = 0;
        forever #5 clock = ~clock; 
    end

    // teste
    initial begin
        reset = 1;
        under = 0;
        barreira = 0;

        #10;
        reset = 0;
        #400 $stop;

    end

endmodule
