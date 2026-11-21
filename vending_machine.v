module vending_machine (
    input clk,
    input reset,
    input coin_5,
    input coin_10,
    output reg dispense
);
    localparam S0 = 0, S5 = 1, S10 = 2, S15 = 3, S20 = 4, S25 = 5;
    reg [2:0] state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset) state <= S0;
        else state <= next_state;
    end

    always @(*) begin
        next_state = state;
        dispense = 0;
        case(state)
            S0: if (coin_5) next_state = S5; else if (coin_10) next_state = S10;
            S5: if (coin_5) next_state = S10; else if (coin_10) next_state = S15;
            S10: if (coin_5) next_state = S15; else if (coin_10) next_state = S20;
            S15: if (coin_5) next_state = S20; else if (coin_10) next_state = S25;
            S20: if (coin_5) next_state = S25; else if (coin_10) next_state = S0; // (overshoot simplified)
            S25: begin
                dispense = 1;
                next_state = S0;
            end
        endcase
    end
endmodule
