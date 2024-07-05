module divisorclock ( // precisa por reset no mapa??
    input wire clock,
    output reg c1, c2, c3, c4 
);

    integer i, k;

    // Inicialização dos sinais
    initial begin
        i = 0;
        k = 0;
        c1 = 1'b0;
        c2 = 1'b0;
        c3 = 1'b0;
        c4 = 1'b0;
    end

    always @(posedge clock) begin
        if (i == 0) begin
            c1 <= 1'b1;
            c3 <= 1'b0;
            i = 1;
        end else begin 
            c1 <= 1'b0;
            c3 <= 1'b1;
            i = 0;
        end
    end
    
    always @(negedge clock) begin
        if (k == 0) begin
            c2 <= 1'b1;
            c4 <= 1'b0; 
            k = 1;
        end else begin 
            c2 <= 1'b0;
            c4 <= 1'b1; 
            k = 0;
        end
    end

endmodule
