module FSM_struc (out, E, W, clk);
	input E,W,clk;
	output out;
	wire Q1, Q2, L1, L2, L3, L4, Q1B, Q2B, D1, D2;

		NOT N1(Q2B, Q2);
		NOT N2(Q1B, Q1);

		AND A1(L1, Q1, Q2B);
		AND A2(L2, Q1, W);
		AND A3(L3, Q2, Q1B);
		AND A4(L4, Q2, E);

		NOR R1(out, Q1, Q2);

		OR O1(D1, E, L1, L2);
		OR O2(D2, W, L3, L4);

		DFF F1(Q1, D1, clk);
		DFF F2(Q2, D2, clk);
endmodule

//Test bench module for FSM_struc
module FSM_Struc_Test;
	reg E, W, Clk;
	FSM_struc T1 (Out, E, W, Clk);

	initial
	begin
		Clk=0;
		E=0;
		W=0;

		#20 E=1;
		#5 Clk = 1;
		#5 Clk = 0;

		#20 W=1;
		#5 Clk = 1;
		#5 Clk = 0;

		#20 E=0;
		#5 Clk = 1;
		#5 Clk = 0;


		#100 $finish;
	end
endmodule

//NOT module
module NOT(out, in);
	input in;
	output out;
	
	assign out = ~in;
endmodule

//AND module
module AND(out, in1, in2);
	input in1, in2;
	output out;

	assign out = in1 & in2;
endmodule

//3-input OR module
module OR(out, in1, in2, in3);
	input in1, in2, in3;
	output out;

	assign out = in1 | in2 | in3;
endmodule

//NOR module
module NOR(out, in1, in2);
	input in1, in2;
	output out;

	assign out = ~(in1 | in2);
endmodule
	

//D Flip Flop module
module DFF(Q, D, clk);
	input D, clk;
	output Q;
	reg z;

	initial
	begin
		z=0;
	end

	always @(posedge clk)
		z=D;

	assign Q = z;
endmodule
