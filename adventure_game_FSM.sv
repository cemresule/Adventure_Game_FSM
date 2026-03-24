module adventure_game_FSM (
    input  logic clk,
    input  logic reset,
    input  logic N, S, E, W,
    output logic WIN,
    output logic DIE
);

    // Ara sinyaller
    logic has_sword;
    logic in_stash;

    // Room FSM kurulumu
    room_fsm room_unit (
        .clk(clk), .reset(reset),
        .N(N), .S(S), .E(E), .W(W),
        .has_sword(has_sword),
        .in_stash(in_stash),
        .WIN(WIN), .DIE(DIE)
    );

    // Sword FSM kurulumu
    sword_fsm sword_unit (
        .clk(clk), .reset(reset),
        .in_stash(in_stash),
        .has_sword(has_sword)
    );

endmodule