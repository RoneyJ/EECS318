module freecellPlayer(
	input clock,
	input [3:0] source,dest,
	output win
);
	//4 bits for card value (1,2,3,4,5,6,7,8,9,10,J,Q,K)
	//Card value matches the value bit value
	//6'b000000 is an empty space
	//2 bits for suit value (Heart,Diamond,Spade,Club)
	//00 = Heart
	//01 = Diamond
	//10 = Spade
	//11 = Club
	
	reg [5:0] col0 [6:0];	//columns of tableau (array for 6-bit registers)
	reg [5:0] col1 [6:0];	
	reg [5:0] col2 [6:0];
	reg [5:0] col3 [6:0];
	reg [5:0] col4 [5:0];
	reg [5:0] col5 [5:0];
	reg [5:0] col6 [5:0];
	reg [5:0] col7 [5:0];
	reg [5:0] home [3:0];	//homecells
	reg [5:0] free [3:0];	//freecells

	initial //initialize the board of game 8321
	begin
		//homecells and freecells initiall empty
		home(0) = 0;
		home(1) = 0;
		home(2) = 0;
		home(3) = 0;
		free(0) = 0;
		free(1) = 0;
		free(2) = 0;
		free(3) = 0;
	
		//initial state of c0
		col0(0) = 6'b100100; //4 of spades
		col0(1) = 6'b011011; //jack of diamonds
		col0(2) = 6'b011010; //10 of diamonds
		col0(3) = 6'b010110; //6 of diamonds
		col0(4) = 6'b100011; //3 of spades
		col0(5) = 6'b010001; //ace of diamonds
		col0(6) = 6'b000001; //ace of hearts
		//initial state of c1
		col1(0) = 6'b100101; //5 of spades
		col1(1) = 6'b101010; //10 of spades
		col1(2) = 6'b001000; //8 of hearts
		col1(3) = 6'b110100; //4 of clubs
		col1(4) = 6'b000110; //6 of hearts
		col1(5) = 6'b001101; //king of hearts
		col1(6) = 6'b000010; //2 of hearts
		//initial state of c2
		col2(0) = 6'b101011; //jack of spades
		col2(1) = 6'b110111; //7 of clubs
		col2(2) = 6'b111001; //9 of clubs
		col2(3) = 6'b110110; //6 of clubs
		col2(4) = 6'b110010; //2 of clubs
		col2(5) = 6'b101101; //king of spades
		col2(6) = 6'b110001; //ace of clubs
		//initial state of c3
		col3(0) = 6'b000100; //4 of hearts
		col3(1) = 6'b100001; //ace of spades
		col3(2) = 6'b111100; //queen of clubs
		col3(3) = 6'b110101; //5 of clubs
		col3(4) = 6'b100111; //7 of spades
		col3(5) = 6'b001001; //9 of hearts
		col3(6) = 6'b101000; //8 of spades
		//initial state of c4
		col4(0) = 6'b011100; //queen of diamonds
		col4(1) = 6'b001011; //jack of hearts
		col4(2) = 6'b101100; //queen of spades
		col4(3) = 6'b100110; //6 of spades
		col4(4) = 6'b010010; //2 of diamonds
		col4(5) = 6'b101001; //9 of spades
		//initial state of c5
		col5(0) = 6'b010101; //5 of diamonds
		col5(1) = 6'b011101; //king of diamonds
		col5(2) = 6'b110011; //3 of clubs
		col5(3) = 6'b011001; //9 of diamonds
		col5(4) = 6'b000011; //3 of hearts
		col5(5) = 6'b100010; //2 of spades
		//initial state of c6
		col6(0) = 6'b000101; //5 of hearts
		col6(1) = 6'b010011; //3 of diamonds
		col6(2) = 6'b001100; //queen of hearts
		col6(3) = 6'b010111; //seven of diamonds
		col6(4) = 6'b111101; //king of clubs
		col6(5) = 6'b111010; //10 of clubs
		//initial state of c7
		col7(0) = 6'b111011; //jack of clubs
		col7(1) = 6'b010100; //4 of diamonds
		col7(2) = 6'b001010; //10 of hearts
		col7(3) = 6'b111000; //8 of clubs
		col7(4) = 6'b000111; //7 of hearts
		col7(5) = 6'b011000; //8 of diamonds
	end

	always @(posedge clock)
	begin
	end




endmodule
