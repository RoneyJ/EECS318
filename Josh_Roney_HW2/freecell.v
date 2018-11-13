//Module for Homework Assignment 2 that plays game 8321 of freecell.
//Josh Roney (jpr87)

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
	
	reg [3:0] src,dest;
	reg [5:0] temp;
	reg illegal;
	
	reg [5:0] col0 [6:0];	//columns of tableau (array for 6-bit registers)
	reg [5:0] col1 [6:0];	
	reg [5:0] col2 [6:0];
	reg [5:0] col3 [6:0];
	reg [5:0] col4 [5:0];
	reg [5:0] col5 [5:0];
	reg [5:0] col6 [5:0];
	reg [5:0] col7 [5:0];
	reg [5:0] home [3:0];	//homecells (00 = H, 01 = D, 10 = S, 11 = C)
	reg [5:0] free [3:0];	//freecells

	initial //initialize the board of game 8321
	begin
		src = 0;
		dest = 0;
		temp = 0;
		illegal = 0;
		
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
		col6(3) = 6'b010111; //7 of diamonds
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
		src = source;
		dest = dest;
		illegal = 0;
		case(src) //check viability of source
			4'b11xx: //illegal source, do nothing
			begin
				$display("chosen source doesn't exist, no move taken");
				illegal = 1;
			end
			
			4'b1000: //source is free cell 0
			begin
				temp = free(0);
			end
			
			4'b1001: //source is free cell 1
			begin
				temp = free(1);
			end
			
			4'b1010: //source is free cell 2
			begin
				temp = free(2);
			end
			
			4'b1011: //source is free cell 3
			begin
				temp = free(3);
			end
			
			4'b0000: //source is column 0
			begin
			end
			
			4'b0001: //source is column 1
			begin
			end
			
			4'b0010: //source is column 2
			begin
			end
			
			4'b0011: //source is column 3
			begin
			end
			
			4'b0100: //source is column 4
			begin
			end
			
			4'b0101: //source is column 5
			begin
			end
			
			4'b0110: //source is column 6
			begin
			end
			
			4'b0111: //source is column 7
			begin
			end
		endcase
		
		if(~illegal)
		case(dest) //check viability of destination
			4'b1100: //destination is home cell 0
			begin 
				if(~temp[5] && ~temp[4]) //check if card is a heart
				begin
					if(home(0)[3:0] == (temp[3:0]-1'b1)) //check if card is one below source card
						home(0) = temp;
					else
						$display("homecell H is not a valid destination");
				end
				else
					$display("card is not of the heart suit");
			end
			
			4'b1101: //destination is home cell H
			begin
				if(~temp[5] && temp[4]) //check if card is a diamond
				begin
					if(home(1)[3:0] == (temp[3:0]-1'b1)) //check if card is one below source card
						home(1) = temp;
					else
						$display("homecell D is not a valid destination");
				end
				else
					$display("card is not of the diamond suit");
			end
			
			4'b1110: //destination is home cell D
			begin
				if(temp[5] && ~temp[4]) //check if card is a spade
				begin
					if(home(2)[3:0] == (temp[3:0]-1'b1)) //check if card is one below source card
						home(2) = temp;
					else
						$display("home cell S is not a valid destination");
				end
				else
					$display("card is not of the spade suit");
			end
			
			4'b1111: //destination is home cell S
			begin
				if(temp[5] && temp[4]) //check if card is a club
				begin
					if(home(3)[3:0] == (temp[3:0]-1'b1)) //check if card is one below source card
						home(3) = temp;
					else
						$display("home cell C is not a valid destination");
				end
				else
					$display("card is not of the club suit");
			end
			
			4'b1000: //destination is free cell C
			begin
				if(free(0) == 6'b000000)
					free(0) = temp;
				else
					$display("freecell a is not empty, illegal move");
			end
			
			4'b1001: //destination is free cell b
			begin
				if(free(1) == 6'b000000)
					free(1) = temp;
				else
					$display("freecell b is not empty, illegal move");
			end
			
			4'b1010: //destination is free cell c
			begin
				if(free(2) == 6'b000000)
					free(2) = temp;
				else
					$display("freecell c is not empty, illegal move");
			end
			
			4'b1011: //destination is free cell d
			begin
				if(free(3) == 6'b000000)
					free(3) = temp;
				else
					$display("freecell d is not empty, illegal move");
			end
			
			4'b0000: //destination is column 0
			begin
			end
			
			4'b0001: //destination is column 1
			begin
			end
			
			4'b0010: //destination is column 2
			begin
			end
			
			4'b0011: //destination is column 3
			begin
			end
			
			4'b0100: //destination is column 4
			begin
			end
			
			4'b0101: //destination is column 5
			begin
			end
			
			4'b0110: //destination is column 6
			begin
			end
			
			4'b0111: //destination is column 7
			begin
			end
		endcase
	end

	assign win = 0;
	

endmodule
