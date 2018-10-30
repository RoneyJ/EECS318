module FSM_behav(out, E, W, clk);
	input E, W, clk;
	output out;
	reg Q1, Q2, Q1B, Q2B, z;

	initial
	begin
		Q1 = 0;
		Q2 = 0;
	end

	always@(posedge clk)
	begin
		Q1 = E | (Q1&Q2B) | (Q1&W);
		Q2 = W | (Q2&Q1B) | (Q2&W);
	end

	//e=0, q1=0 | q2b=0, q1=0 | w=0

	always@*
	begin
		Q1B <= !(Q1);
		Q2B <= !(Q2);
		z <= (Q1B & Q2B);
	end

	assign out = z;
endmodule

module FSM_behav_test;
	reg E, W, Clk;

	FSM_behav F1(Out, E, W, Clk);


	initial
	begin
		Clk = 0;
		E = 0;
		W= 0;

		#20 E = 1;
		#5 Clk = 1;
		#5 Clk = 0;

		#20 W = 1;
		#5 Clk = 1;
		#5 Clk = 0;

		#20 E = 0;
		#5 Clk = 1;
		#5 Clk = 0;

		#20 W = 0;
		#5 Clk = 1;
		#5 Clk = 0;

		#100 $finish;
	end
endmodule
