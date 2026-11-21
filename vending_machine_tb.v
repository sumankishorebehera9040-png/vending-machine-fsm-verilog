module vending_machine_tb;
    reg clk, reset, coin_5, coin_10;
    wire dispense;

    vending_machine uut(clk, reset, coin_5, coin_10, dispense);
    always #5 clk = ~clk;

    initial begin
        clk = 0; reset = 1; coin_5 = 0; coin_10 = 0;
        #10 reset = 0;
        
        // Insert 10 + 10 + 5 = 25 cents
        coin_10 = 1; #10; coin_10 = 0; #10;
        coin_10 = 1; #10; coin_10 = 0; #10;
        coin_5 = 1; #10; coin_5 = 0; #10;
        
        $finish;
    end
endmodule
