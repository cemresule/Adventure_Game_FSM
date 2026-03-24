module tb_adventure_game_FSM();

    logic clk, reset;
    logic n, s, e, w;
    logic win, die;

    adventure_game_FSM dut (
        .clk(clk), .reset(reset),
        .N(n), .S(s), .E(e), .W(w),
        .WIN(win), .DIE(die)
    );

    always begin
        clk = 1; #5;
        clk = 0; #5;
    end

    initial begin
        n=0; s=0; e=0; w=0; reset=1; #10;
        reset = 0; #10;

        e = 1; #10; e = 0; 
        s = 1; #10; s = 0; 
        e = 1; #10; e = 0; 
        #20;               

        if (die == 1) 
            $display("TEST 1 (DIE) PASSED!");
        else 
            $error("TEST 1 (DIE) FAILED!");

        reset = 1; #10; reset = 0; #10;

        e = 1; #10; e = 0; 
        s = 1; #10; s = 0; 
        w = 1; #10; w = 0; 
        e = 1; #10; e = 0; 
        e = 1; #10; e = 0; 
        #20;               

        if (win == 1) 
            $display("TEST 2 (WIN) PASSED!");
        else 
            $error("TEST 2 (WIN) FAILED!");

        $display("TESTS COMPLETED!");
        $stop; 
    end

endmodule