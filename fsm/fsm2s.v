module top_module(
    input clk,
    input reset,    // Synchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=1'b0, ON=1'b1; 
    reg state, next_state;

    always @(*) begin
        // State transition logic
        next_state = OFF;
        case (state)
            OFF : if (j == 0)
                	next_state = OFF;
                  else
                      next_state = ON;
            ON : if (k == 0)
                	next_state = ON;
            	else
                    next_state = OFF;
        endcase 
    end

    always @(posedge clk) begin
        // State flip-flops with synchronous reset
        if (reset == 1)
            state <= OFF;
        else
            state <= next_state;
    end

    // Output logic
    // assign out = (state == ...);
    always @(*)
        begin
            case (state)
                OFF : out = 1'b0;
                ON : out = 1'b1;
            endcase
        end

endmodule
