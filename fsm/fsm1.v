module top_module(
    input clk,
    input areset,    // Asynchronous reset to state B
    input in,
    output out);//  

    parameter A=1'b0, B=1'b1; 
    reg state, next_state;

    always @(*)   // This is a combinational always block
        // State transition logic
		begin : FSM_COMBO
        	next_state = 1'b0;
            case(state)
                A : /*if (in == 1'b0)
                    	next_state = B;
                	else
                        next_state = A;*/
                	next_state = in?A:B;
                B : /*if (in == 1'b0)
                    	next_state = A;
                	else
                        next_state = B;*/
                    next_state = in?B:A;
                default : next_state = B;     
            endcase
		    
    end

    always @(posedge clk, posedge areset) begin    // This is a sequential always block
        // State flip-flops with asynchronous reset
         begin : FSM_SEQ
             if (areset == 1'b1) begin
      			state <=  B;
    		end else begin
      			state <=  next_state;
    			end
    	 end
    end

    // Output logic
    always @(*) begin
        case(state)
            A: out = 1'b0; //  output for state A
            B: out = 1'b1;   // output for state B
        endcase
    end       

endmodule
