module room_fsm (
    input  logic clk,
    input  logic reset,
    input  logic N, S, E, W,
    input  logic has_sword,  
    output logic in_stash,   
    output logic WIN,
    output logic DIE
);

    typedef enum logic [2:0] {
        CAVE      = 3'b000,
        TUNNEL    = 3'b001,
        RIVER     = 3'b010,
        STASH     = 3'b011,
        DRAGON    = 3'b100,
        VICTORY   = 3'b101,
        GRAVEYARD = 3'b110
    } state_t;

    state_t curr_state, next_state;

    // State Register
    always_ff @(posedge clk or posedge reset) begin
        if (reset) curr_state <= CAVE;
        else       curr_state <= next_state;
    end

    // Next State Logic
    always_comb begin
		next_state = curr_state;
        case (curr_state)
            CAVE:      if (E) next_state = TUNNEL;    else next_state = CAVE;
            TUNNEL:    if (W) next_state = CAVE;
                       else if (S) next_state = RIVER; 
                       else next_state = TUNNEL;
            RIVER:     if (N) next_state = TUNNEL;
                       else if (W) next_state = STASH;
                       else if (E) next_state = DRAGON;
                       else next_state = RIVER;
            STASH:     if (E) next_state = RIVER;     else next_state = STASH;
            
            DRAGON:    if (has_sword) next_state = VICTORY;
                       else           next_state = GRAVEYARD;
            
            VICTORY:   next_state = VICTORY;   
            GRAVEYARD: next_state = GRAVEYARD; 
            default:   next_state = CAVE;
        endcase
    end

    // Output Logic
    assign in_stash = (curr_state == STASH);
    assign WIN      = (curr_state == VICTORY);
    assign DIE      = (curr_state == GRAVEYARD);

endmodule