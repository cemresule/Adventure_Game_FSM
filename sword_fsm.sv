module sword_fsm (
    input  logic clk,
    input  logic reset,
    input  logic in_stash,   
    output logic has_sword   
);

    typedef enum logic { NO_SWORD = 1'b0, HAS_SWORD = 1'b1 } state_t;
    state_t curr_state, next_state;

    // State Register
    always_ff @(posedge clk or posedge reset) begin
        if (reset) curr_state <= NO_SWORD;
        else       curr_state <= next_state;
    end

    // Next State Logic
    always_comb begin
		next_state = curr_state;
        case (curr_state)
            NO_SWORD:  if (in_stash) next_state = HAS_SWORD;
                       else          next_state = NO_SWORD;
            HAS_SWORD: next_state = HAS_SWORD; // Reset gelene kadar burada kalır
            default:   next_state = NO_SWORD;
        endcase
    end

    assign has_sword = (curr_state == HAS_SWORD);

endmodule