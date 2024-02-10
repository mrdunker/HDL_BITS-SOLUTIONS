module top_module(
    input clk,
    input areset,    // Asynchronous reset to OFF
    input j,
    input k,
    output out); //  

    parameter OFF=1'b0, ON=1'b1; 
    reg state, next_state;

    always @(*) begin
        // State transition logic
        begin : FSM
            next_state =  OFF;
            case (state)
                OFF : next_state = j?ON:OFF;
                ON :  next_state = k?OFF:ON;
                default: next_state = ON;
            endcase
                    	
        end
    end

    always @(posedge clk, posedge areset) begin
        // State flip-flops with asynchronous reset
        if (areset == 1)
            state <= OFF;
        else 
            state <= next_state;
    end

    // Output logic
    assign out = state?1'b1:1'b0;
    //or this logic
    /*always @(*) begin
        // Assign output based on the current state
        case(state)
            OFF: out = 1'b0; // output for state OFF
            ON: out = 1'b1;   // output for state ON
        endcase
    end */

endmodule
