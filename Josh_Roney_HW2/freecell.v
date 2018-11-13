//Module for Homework Assignment 2 that plays game 8321 of freecell.
//Josh Roney (jpr87)

//**Incorporate the new integers c0-c7 to allow for larger registers

module freecellPlayer(
	input clock,
	input [3:0] source,destination,
	output win
);
	//4 bits for card value (A,2,3,4,5,6,7,8,9,10,J,Q,K)
	//Card value matches the bit value
	//6'b000000 is an empty space
	//2 bits for suit value (Heart,Diamond,Spade,Club)
	//00 = Heart
	//01 = Diamond
	//10 = Spade
	//11 = Club
	
	reg [3:0] src,dest;
	reg [5:0] temp;
	reg src_valid,dest_valid;
	integer col_s,col_d;			//integers to mark which column entry is the source and destination
	integer c0,c1,c2,c3,c4,c5,c6,c7;	//integers to mark last spot with a card in it in a column;
	
	reg [5:0] col0 [6:0];	//columns of tableau (array for 6-bit registers)
	reg [5:0] col1 [6:0];	
	reg [5:0] col2 [6:0];
	reg [5:0] col3 [6:0];
	reg [5:0] col4 [5:0];
	reg [5:0] col5 [5:0];
	reg [5:0] col6 [5:0];
	reg [5:0] col7 [5:0];
	reg [5:0] home [3:0];	//homecells (00 = H, 01 = D, 10 = S, 11 = C)
	reg [5:0] free [3:0];	//free cells

	initial //initialize the board of game 8321
	begin
		src = 0;
		dest = 0;
		temp = 0;
		src_valid = 0;
		dest_valid = 0;
		col_d = 0;
		
		//homecells and free cells initiall empty
		home[0] = 6'b000000;
		home[1] = 6'b010000;
		home[2] = 6'b100000;
		home[3] = 6'b110000;
		free[0] = 0;
		free[1] = 0;
		free[2] = 0;
		free[3] = 0;
	
		//initial state of c0
		col0[0] = 6'b100100; //4 of spades
		col0[1] = 6'b011011; //jack of diamonds
		col0[2] = 6'b011010; //10 of diamonds
		col0[3] = 6'b010110; //6 of diamonds
		col0[4] = 6'b100011; //3 of spades
		col0[5] = 6'b010001; //ace of diamonds
		col0[6] = 6'b000001; //ace of hearts
		//initial state of c1
		col1[0] = 6'b100101; //5 of spades
		col1[1] = 6'b101010; //10 of spades
		col1[2] = 6'b001000; //8 of hearts
		col1[3] = 6'b110100; //4 of clubs
		col1[4] = 6'b000110; //6 of hearts
		col1[5] = 6'b001101; //king of hearts
		col1[6] = 6'b000010; //2 of hearts
		//initial state of c2
		col2[0] = 6'b101011; //jack of spades
		col2[1] = 6'b110111; //7 of clubs
		col2[2] = 6'b111001; //9 of clubs
		col2[3] = 6'b110110; //6 of clubs
		col2[4] = 6'b110010; //2 of clubs
		col2[5] = 6'b101101; //king of spades
		col2[6] = 6'b110001; //ace of clubs
		//initial state of c3
		col3[0] = 6'b000100; //4 of hearts
		col3[1] = 6'b100001; //ace of spades
		col3[2] = 6'b111100; //queen of clubs
		col3[3] = 6'b110101; //5 of clubs
		col3[4] = 6'b100111; //7 of spades
		col3[5] = 6'b001001; //9 of hearts
		col3[6] = 6'b101000; //8 of spades
		//initial state of c4
		col4[0] = 6'b011100; //queen of diamonds
		col4[1] = 6'b001011; //jack of hearts
		col4[2] = 6'b101100; //queen of spades
		col4[3] = 6'b100110; //6 of spades
		col4[4] = 6'b010010; //2 of diamonds
		col4[5] = 6'b101001; //9 of spades
		//initial state of c5
		col5[0] = 6'b010101; //5 of diamonds
		col5[1] = 6'b011101; //king of diamonds
		col5[2] = 6'b110011; //3 of clubs
		col5[3] = 6'b011001; //9 of diamonds
		col5[4] = 6'b000011; //3 of hearts
		col5[5] = 6'b100010; //2 of spades
		//initial state of c6
		col6[0] = 6'b000101; //5 of hearts
		col6[1] = 6'b010011; //3 of diamonds
		col6[2] = 6'b001100; //queen of hearts
		col6[3] = 6'b010111; //7 of diamonds
		col6[4] = 6'b111101; //king of clubs
		col6[5] = 6'b111010; //10 of clubs
		//initial state of c7
		col7[0] = 6'b111011; //jack of clubs
		col7[1] = 6'b010100; //4 of diamonds
		col7[2] = 6'b001010; //10 of hearts
		col7[3] = 6'b111000; //8 of clubs
		col7[4] = 6'b000111; //7 of hearts
		col7[5] = 6'b011000; //8 of diamonds
	end

	always @(posedge clock) //at positive edge of the clock, check validity of source and destination
	begin
		src = source;
		dest = destination;
		src_valid = 0;
		dest_valid = 0;
		col_s = 0;
		col_d = 0;
		
		//check validity of source
		case(src) 
			4'b11xx: //illegal source, do nothing
			begin
				$display("chosen source doesn't exist, no move taken");
				src_valid = 0;
			end
			
			4'b1000: //source is free cell 0
			begin
				if(free[0] == 6'b000000)
					src_valid = 0;
				else
				begin
					temp = free[0];
					src_valid = 1;
				end
			end
			
			4'b1001: //source is free cell 1
			begin
				if(free[1] == 6'b000000)
					src_valid = 0;
				else
				begin
					temp = free[1];
					src_valid = 1;
				end
			end
			
			4'b1010: //source is free cell 2
			begin
				if(free[2] == 6'b000000)
					src_valid = 0;
				else
				begin
					temp = free[2];
					src_valid = 1;
				end
			end
			
			4'b1011: //source is free cell 3
			begin
				if(free[3] == 6'b000000)
					src_valid = 0;
				else
				begin
					temp = free[3];
					src_valid = 1;
				end
			end
			
			4'b0000: //source is column 0
			begin
				if(col0[6] != 6'b000000)
				begin
					src_valid = 1;
					temp = col0[6];
					col_s = 6;
				end
				else if(col0[5] != 6'b000000)
				begin
					src_valid = 1;
					temp = col0[5];
					col_s = 5;
				end
				else if(col0[4] != 6'b000000)
				begin
					src_valid = 1;
					temp = col0[4];
					col_s = 4;
				end
				else if(col0[3] != 6'b000000)
				begin
					src_valid = 1;
					temp = col0[3];
					col_s = 3;
				end
				else if(col0[2] != 6'b000000)
				begin
					src_valid = 1;
					temp = col0[2];
					col_s = 2;
				end
				else if(col0[1] != 6'b000000)
				begin
					src_valid = 1;
					temp = col0[1];
					col_s = 1;
				end
				else if(col0[0] != 6'b000000)
				begin
					src_valid = 1;
					temp = col0[0];
					col_s = 0;
				end
				else
					src_valid = 0;
			end
			
			4'b0001: //source is column 1
			begin
				if(col1[6] != 6'b000000)
				begin
					src_valid = 1;
					temp = col1[6];
					col_s = 6;
				end
				else if(col1[5] != 6'b000000)
				begin
					src_valid = 1;
					temp = col1[5];
					col_s = 5;
				end
				else if(col1[4] != 6'b000000)
				begin
					src_valid = 1;
					temp = col1[4];
					col_s = 4;
				end
				else if(col1[3] != 6'b000000)
				begin
					src_valid = 1;
					temp = col1[3];
					col_s = 3;
				end
				else if(col1[2] != 6'b000000)
				begin
					src_valid = 1;
					temp = col1[2];
					col_s = 2;
				end
				else if(col1[1] != 6'b000000)
				begin
					src_valid = 1;
					temp = col1[1];
					col_s = 1;
				end
				else if(col1[0] != 6'b000000)
				begin
					src_valid = 1;
					temp = col1[0];
					col_s = 0;
				end
				else
					src_valid = 0;
			end
			
			4'b0010: //source is column 2
			begin
				if(col2[6] != 6'b000000)
				begin
					src_valid = 1;
					temp = col2[6];
					col_s = 6;
				end
				else if(col2[5] != 6'b000000)
				begin
					src_valid = 1;
					temp = col2[5];
					col_s = 5;
				end
				else if(col2[4] != 6'b000000)
				begin
					src_valid = 1;
					temp = col2[4];
					col_s = 4;
				end
				else if(col2[3] != 6'b000000)
				begin
					src_valid = 1;
					temp = col2[3];
					col_s = 3;
				end
				else if(col2[2] != 6'b000000)
				begin
					src_valid = 1;
					temp = col2[2];
					col_s = 2;
				end
				else if(col2[1] != 6'b000000)
				begin
					src_valid = 1;
					temp = col2[1];
					col_s = 1;
				end
				else if(col2[0] != 6'b000000)
				begin
					src_valid = 1;
					temp = col2[0];
					col_s = 0;
				end
				else
					src_valid = 0;
			end
			
			4'b0011: //source is column 3
			begin
				if(col3[6] != 6'b000000)
				begin
					src_valid = 1;
					temp = col3[6];
					col_s = 6;
				end
				else if(col3[5] != 6'b000000)
				begin
					src_valid = 1;
					temp = col3[5];
					col_s = 5;
				end
				else if(col3[4] != 6'b000000)
				begin
					src_valid = 1;
					temp = col3[4];
					col_s = 4;
				end
				else if(col3[3] != 6'b000000)
				begin
					src_valid = 1;
					temp = col3[3];
					col_s = 3;
				end
				else if(col3[2] != 6'b000000)
				begin
					src_valid = 1;
					temp = col3[2];
					col_s = 2;
				end
				else if(col3[1] != 6'b000000)
				begin
					src_valid = 1;
					temp = col3[1];
					col_s = 1;
				end
				else if(col3[0] != 6'b000000)
				begin
					src_valid = 1;
					temp = col3[0];
					col_s = 0;
				end
				else
					src_valid = 0;
			end
			
			4'b0100: //source is column 4
			begin
				if(col4[5] != 6'b000000)
				begin
					src_valid = 1;
					temp = col4[5];
					col_s = 5;
				end
				else if(col4[4] != 6'b000000)
				begin
					src_valid = 1;
					temp = col4[4];
					col_s = 4;
				end
				else if(col4[3] != 6'b000000)
				begin
					src_valid = 1;
					temp = col4[3];
					col_s = 3;
				end
				else if(col4[2] != 6'b000000)
				begin
					src_valid = 1;
					temp = col4[2];
					col_s = 2;
				end
				else if(col4[1] != 6'b000000)
				begin
					src_valid = 1;
					temp = col4[1];
					col_s = 1;
				end
				else if(col4[0] != 6'b000000)
				begin
					src_valid = 1;
					temp = col4[0];
					col_s = 0;
				end
				else
					src_valid = 0;
			end
			
			4'b0101: //source is column 5
			begin
				if(col5[5] != 6'b000000)
				begin
					src_valid = 1;
					temp = col5[5];
					col_s = 5;
				end
				else if(col5[4] != 6'b000000)
				begin
					src_valid = 1;
					temp = col5[4];
					col_s = 4;
				end
				else if(col5[3] != 6'b000000)
				begin
					src_valid = 1;
					temp = col5[3];
					col_s = 3;
				end
				else if(col5[2] != 6'b000000)
				begin
					src_valid = 1;
					temp = col5[2];
					col_s = 2;
				end
				else if(col5[1] != 6'b000000)
				begin
					src_valid = 1;
					temp = col5[1];
					col_s = 1;
				end
				else if(col5[0] != 6'b000000)
				begin
					src_valid = 1;
					temp = col5[0];
					col_s = 0;
				end
				else
					src_valid = 0;
			end
			
			4'b0110: //source is column 6
			begin
				if(col6[5] != 6'b000000)
				begin
					src_valid = 1;
					temp = col6[5];
					col_s = 5;
				end
				else if(col6[4] != 6'b000000)
				begin
					src_valid = 1;
					temp = col6[4];
					col_s = 4;
				end
				else if(col6[3] != 6'b000000)
				begin
					src_valid = 1;
					temp = col6[3];
					col_s = 3;
				end
				else if(col6[2] != 6'b000000)
				begin
					src_valid = 1;
					temp = col6[2];
					col_s = 2;
				end
				else if(col6[1] != 6'b000000)
				begin
					src_valid = 1;
					temp = col6[1];
					col_s = 1;
				end
				else if(col6[0] != 6'b000000)
				begin
					src_valid = 1;
					temp = col6[0];
					col_s = 0;
				end
				else
					src_valid = 0;
			end
			
			4'b0111: //source is column 7
			begin
				if(col7[5] != 6'b000000)
				begin
					src_valid = 1;
					temp = col7[5];
					col_s = 5;
				end
				else if(col7[4] != 6'b000000)
				begin
					src_valid = 1;
					temp = col7[4];
					col_s = 4;
				end
				else if(col7[3] != 6'b000000)
				begin
					src_valid = 1;
					temp = col7[3];
					col_s = 3;
				end
				else if(col7[2] != 6'b000000)
				begin
					src_valid = 1;
					temp = col7[2];
					col_s = 2;
				end
				else if(col7[1] != 6'b000000)
				begin
					src_valid = 1;
					temp = col7[1];
					col_s = 1;
				end
				else if(col7[0] != 6'b000000)
				begin
					src_valid = 1;
					temp = col7[0];
					col_s = 0;
				end
				else
					src_valid = 0;
			end
		endcase

		//check validity of destination
		//if(src_valid)
		$display("source valid : %b \t destination : %b", src_valid, dest);
		case(dest) 
			4'b1100: //destination is home cell
			begin 
				if(home[0][5:4] == temp[5:4] && home[0][3:0] == (temp[3:0]-1'b1)) //check to see if suits match and current card is one value lower than new card
				begin
					dest_valid = 1;
					col_d = 0;
				end
				else if(home[1][5:4] == temp[5:4] && home[1][3:0] == (temp[3:0]-1'b1))
				begin
					dest_valid = 1;
					col_d = 1;
				end
				else if(home[2][5:4] == temp[5:4] && home[2][3:0] == (temp[3:0]-1'b1))
				begin
					dest_valid = 1;
					col_d = 2;
				end
				else if(home[3][5:4] == temp[5:4] && home[3][3:0] == (temp[3:0]-1'b1))
				begin
					dest_valid = 1;
					col_d = 3;
				end
				else
					dest_valid = 0;
			end
			
			4'b1000: //destination is free cell a
			begin
				if(free[0] == 6'b000000) //valid if empty
					dest_valid = 1;
				else
					dest_valid = 0;
			end
			
			4'b1001: //destination is free cell b
			begin
				if(free[1] == 6'b000000) //valid if empty
					dest_valid = 1;
				else
					dest_valid = 0;
			end
			
			4'b1010: //destination is free cell c
			begin
				if(free[2] == 6'b000000) //valid if empty
					dest_valid = 1;
				else
					dest_valid = 0;
			end
			
			4'b1011: //destination is free cell d
			begin
				if(free[3] == 6'b000000) //valid if empty
					dest_valid = 1;
				else
					dest_valid = 0;
			end
			
			4'b0000: //destination is column 0
			begin
				if(col0[6] != 6'b000000) //if last position is not empty, not valid
					dest_valid = 0;
				else if(col0[5] != 6'b000000)
				begin
					if(col0[5][5] != temp[5] && col0[5][3:0] == (temp[3:0] + 1'b1))//if spot taken, see if it's a different color and one value higher
					begin
						dest_valid = 1;
						col_d = 6; //card will be moved to one spot higher in the column
					end
					else
						dest_valid = 0;
					
				end
				else if(col0[4] != 6'b000000)
				begin
					if(col0[4][5] != temp[5] && col0[4][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 5;
					end
					else
						dest_valid = 0;
					
				end
				else if(col0[3] != 6'b000000)
				begin
					if(col0[3][5] != temp[5] && col0[3][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 4;
					end
					else
						dest_valid = 0;
					
				end
				else if(col0[2] != 6'b000000)
				begin
					if(col0[2][5] != temp[5] && col0[2][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 3;
					end
					else
						dest_valid = 0;
					
				end
				else if(col0[1] != 6'b000000)
				begin
					if(col0[1][5] != temp[5] && col0[1][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 2;
					end
					else
						dest_valid = 0;
					
				end
				else if(col0[0] != 6'b000000)
				begin
					if(col0[0][5] != temp[5] && col0[0][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 1;
					end	
					else
						dest_valid = 0;
					
				end
				else //if column is completely empty, valid destination
				begin
					dest_valid = 1;
					col_d = 0;
				end
			end
			
			4'b0001: //destination is column 1
			begin
				if(col1[6] != 6'b000000)
					dest_valid = 0;
				else if(col1[5] != 6'b000000)
				begin
					if(col1[5][5] != temp[5] && col1[5][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 6;
					end
					else
						dest_valid = 0;
					
				end
				else if(col1[4] != 6'b000000)
				begin
					if(col1[4][5] != temp[5] && col1[4][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 5;
					end
					else
						dest_valid = 0;
					
				end
				else if(col1[3] != 6'b000000)
				begin
					if(col1[3][5] != temp[5] && col1[3][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 4;
					end
					else
						dest_valid = 0;
					
				end
				else if(col1[2] != 6'b000000)
				begin
					if(col1[2][5] != temp[5] && col1[2][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 3;
					end
					else
						dest_valid = 0;
					
				end
				else if(col1[1] != 6'b000000)
				begin
					if(col1[1][5] != temp[5] && col1[1][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 2;
					end
					else
						dest_valid = 0;
					
				end
				else if(col1[0] != 6'b000000)
				begin
					if(col1[0][5] != temp[5] && col1[0][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 1;
					end
					else
						dest_valid = 0;
					
				end
				else
				begin
					dest_valid = 1;
					col_d = 0;
				end
			end
			
			4'b0010: //destination is column 2
			begin
				if(col2[6] != 6'b000000)
					dest_valid = 0;
				else if(col2[5] != 6'b000000)
				begin
					if(col2[5][5] != temp[5] && col2[5][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 6;
					end
					else
						dest_valid = 0;
					
				end
				else if(col2[4] != 6'b000000)
				begin
					if(col2[4][5] != temp[5] && col2[4][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 5;
					end
					else
						dest_valid = 0;
					
				end
				else if(col2[3] != 6'b000000)
				begin
					if(col2[3][5] != temp[5] && col2[3][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 4;
					end
					else
						dest_valid = 0;
					
				end
				else if(col2[2] != 6'b000000)
				begin
					if(col2[2][5] != temp[5] && col2[2][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 3;
					end
					else
						dest_valid = 0;
					
				end
				else if(col2[1] != 6'b000000)
				begin
					if(col2[1][5] != temp[5] && col2[1][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 2;
					end
					else
						dest_valid = 0;
					
				end
				else if(col2[0] != 6'b000000)
				begin
					if(col2[0][5] != temp[5] && col2[0][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 1;
					end
					else
						dest_valid = 0;
					
				end
				else
				begin
					dest_valid = 1;
					col_d = 0;
				end
			end
			
			4'b0011: //destination is column 3
			begin
				if(col3[6] != 6'b000000)
					dest_valid = 0;
				else if(col3[5] != 6'b000000)
				begin
					if(col3[5][5] != temp[5] && col3[5][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 6;
					end
					else
						dest_valid = 0;
					
				end
				else if(col3[4] != 6'b000000)
				begin
					if(col3[4][5] != temp[5] && col3[4][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 5;
					end
					else
						dest_valid = 0;
					
				end
				else if(col3[3] != 6'b000000)
				begin
					if(col3[3][5] != temp[5] && col3[3][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 4;
					end
					else
						dest_valid = 0;
					
				end
				else if(col3[2] != 6'b000000)
				begin
					if(col3[2][5] != temp[5] && col3[2][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 3;
					end
					else
						dest_valid = 0;
					
				end
				else if(col3[1] != 6'b000000)
				begin
					if(col3[1][5] != temp[5] && col3[1][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 2;
					end
					else
						dest_valid = 0;
					
				end
				else if(col3[0] != 6'b000000)
				begin
					if(col3[0][5] != temp[5] && col3[0][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 1;
					end
					else
						dest_valid = 0;
					
				end
				else
				begin
					dest_valid = 1;
					col_d = 0;
				end
			end
			
			4'b0100: //destination is column 4
			begin
				if(col4[5] != 6'b000000)
					dest_valid = 0;
				else if(col4[4] != 6'b000000)
				begin
					if(col4[4][5] != temp[5] && col4[4][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 5;
					end
					else
						dest_valid = 0;
					
				end
				else if(col4[3] != 6'b000000)
				begin
					if(col4[3][5] != temp[5] && col4[3][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 4;
					end
					else
						dest_valid = 0;
					
				end
				else if(col4[2] != 6'b000000)
				begin
					if(col4[2][5] != temp[5] && col4[2][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 3;
					end
					else
						dest_valid = 0;
					
				end
				else if(col4[1] != 6'b000000)
				begin
					if(col4[1][5] != temp[5] && col4[1][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 2;
					end
					else
						dest_valid = 0;
					
				end
				else if(col4[0] != 6'b000000)
				begin
					if(col4[0][5] != temp[5] && col4[0][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 1;
					end
					else
						dest_valid = 0;
					
				end
				else
				begin
					dest_valid = 1;
					col_d = 0;
				end
			end
			
			4'b0101: //destination is column 5
			begin
				if(col5[5] != 6'b000000)
					dest_valid = 0;
				else if(col5[4] != 6'b000000)
				begin
					if(col5[4][5] != temp[5] && col5[4][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 5;
					end
					else
						dest_valid = 0;
					
				end
				else if(col5[3] != 6'b000000)
				begin
					if(col5[3][5] != temp[5] && col5[3][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 4;
					end
					else
						dest_valid = 0;
					
				end
				else if(col5[2] != 6'b000000)
				begin
					if(col5[2][5] != temp[5] && col5[2][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 3;
					end
					else
						dest_valid = 0;
					
				end
				else if(col5[1] != 6'b000000)
				begin
					if(col5[1][5] != temp[5] && col5[1][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 2;
					end
					else
						dest_valid = 0;
					
				end
				else if(col5[0] != 6'b000000)
				begin
					if(col5[0][5] != temp[5] && col5[0][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 1;
					end
					else
						dest_valid = 0;
					
				end
				else
				begin
					dest_valid = 1;
					col_d = 0;
				end
			end
			
			4'b0110: //destination is column 6
			begin
				if(col6[5] != 6'b000000)
					dest_valid = 0;
				else if(col6[4] != 6'b000000)
				begin
					if(col6[4][5] != temp[5] && col6[4][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 5;
					end
					else
						dest_valid = 0;
					
				end
				else if(col6[3] != 6'b000000)
				begin
					if(col6[3][5] != temp[5] && col6[3][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 4;
					end
					else
						dest_valid = 0;
					
				end
				else if(col6[2] != 6'b000000)
				begin
					if(col6[2][5] != temp[5] && col6[2][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 3;
					end
					else
						dest_valid = 0;
					
				end
				else if(col6[1] != 6'b000000)
				begin
					if(col6[1][5] != temp[5] && col6[1][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 2;
					end
					else
						dest_valid = 0;
					
				end
				else if(col6[0] != 6'b000000)
				begin
					if(col6[0][5] != temp[5] && col6[0][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 1;
					end
					else
						dest_valid = 0;
					
				end
				else
				begin
					dest_valid = 1;
					col_d = 0;
				end
			end
			
			4'b0111: //destination is column 7
			begin
				if(col7[5] != 6'b000000)
					dest_valid = 0;
				else if(col7[4] != 6'b000000)
				begin
					if(col7[4][5] != temp[5] && col7[4][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 5;
					end
					else
						dest_valid = 0;
					
				end
				else if(col7[3] != 6'b000000)
				begin
					if(col7[3][5] != temp[5] && col7[3][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 4;
					end
					else
						dest_valid = 0;
					
				end
				else if(col7[2] != 6'b000000)
				begin
					if(col7[2][5] != temp[5] && col7[2][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 3;
					end
					else
						dest_valid = 0;
					
				end
				else if(col7[1] != 6'b000000)
				begin
					if(col7[1][5] != temp[5] && col7[1][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 2;
					end
					else
						dest_valid = 0;
					
				end
				else if(col7[0] != 6'b000000)
				begin
					if(col7[0][5] != temp[5] && col7[0][3:0] == (temp[3:0] + 1'b1))
					begin
						dest_valid = 1;
						col_d = 1;
					end
					else
						dest_valid = 0;
					
				end
				else
				begin
					dest_valid = 1;
					col_d = 0;
				end
			end
		endcase
	end

	always @(negedge clock)
	begin
		if(src_valid && dest_valid)
		begin
		$display("card %h in spot %b was moved to spot %b", temp, src, dest);
		case(src) //if move was legal, clear source
			4'b1000: //free cell a
			begin
			free[0] = 6'b000000;
			end

			4'b1001: //free cell b
			begin
			free[1] = 6'b000000;
			end

			4'b1010: //free cell c
			begin
			free[2] = 6'b000000;
			end

			4'b1011: //free cell d
			begin
			free[3] = 6'b000000;
			end

			4'b0000: //column 0
			begin
			col0[col_s] = 6'b000000;
			end

			4'b0001: //column 1
			begin
			col1[col_s] = 6'b000000;
			end

			4'b0010: //column 2
			begin
			col2[col_s] = 6'b000000;
			end

			4'b0011: //column 3
			begin
			col3[col_s] = 6'b000000;
			end

			4'b0100: //column 4
			begin
			col4[col_s] = 6'b000000;
			end

			4'b0101: //column 5
			begin
			col5[col_s] = 6'b000000;
			end

			4'b0110: //column 6
			begin
			col6[col_s] = 6'b000000;
			end

			4'b0111: //column 7
			begin
			col7[col_s] = 6'b000000;
			end
		endcase

		case(dest) //if move was legal, load new value into destination
			4'b1100: //home cell
			begin
			home[col_d] = temp;
			end

			4'b1000: //free cell a
			begin
			free[0] = temp;
			end

			4'b1001: //free cell b
			begin
			free[0] = temp;
			end

			4'b1010: //free cell c
			begin
			free[0] = temp;
			end

			4'b1011: //free cell d
			begin
			free[0] = temp;
			end

			4'b0000: //column 0
			begin
			col0[col_d] = temp;
			end

			4'b0001: //column 1
			begin
			col1[col_d] = temp;
			end

			4'b0010: //column 2
			begin
			col2[col_d] = temp;
			end

			4'b0011: //column 3
			begin
			col3[col_d] = temp;
			end

			4'b0100: //column 4
			begin
			col4[col_d] = temp;
			end

			4'b0101: //column 5
			begin
			col5[col_d] = temp;
			end

			4'b0110: //column 6
			begin
			col6[col_d] = temp;
			end

			4'b0111: //column 7
			begin
			col7[col_d] = temp;
			end
		endcase
		end
		
		else
			$display("illegal move");
	end

	assign win = (home[0] == 6'b001101) & (home[1] == 6'b011101) & (home[2] == 6'b101101) & (home[3] == 6'b111101);
	

endmodule
