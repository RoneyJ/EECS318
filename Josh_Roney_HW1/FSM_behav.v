module FSM_behav(out, reset, E, W, clk); //Case statement needed
	input E, W, clk, reset;
	output out;
	reg Q1, Q2, z;

	reg [1:0] State;
	localparam [1:0]
		S0 = 2'b00,
		S1 = 2'b01,
		S2 = 2'b11,
		S3 = 2'b10;
	

	always@(posedge clk, posedge reset)
	begin
		if(reset)
		begin
			out <= 0;
			
			State <= S0;
		end
		
		else
		begin
			case(State)
				S0:
				begin
					if(~E && W)
						State <= S1;
					else if (E && W)
						State <= S2;
					else if (E && ~W)
						State <= S3;
				end
				S1:
				begin
					if(E)
						State <= S2;
				end
				S2:
				begin
					if(~E && ~W)
						State <= S0;
				end
				S3:
				begin
					if(~W)
						State <= S2;
				end
			endcase
		end
	end


	assign out = ~State(0) & ~State(1);
	
endmodule

module FSM_behav_test;
	reg E, W, Clk;

	FSM_behav F1(Out, E, W, Clk);


	initial
	begin
		Clk = 0;
		E = 0;
		W= 0;

		#2 W = 1; //go from State 0 to State 1

		#10 E = 1; //go from State 1 to State 2

		#10 E = 0; //go from State 2 to State 0
			 W = 0;

		#10 E = 1; //go from State 0 to State 3
		
		#10 W = 0; //go from State 3 to State 2
		
		#10 E = 0; //go from State 2 to State 0

		#20 $finish();
	end
	
	always
		#5 Clk = ~Clk;
endmodule
