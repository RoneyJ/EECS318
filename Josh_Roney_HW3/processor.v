//Processor module for HW3
//Josh Roney (jpr87)
module processor;
reg clk;

reg fetch, decode, execute, writeback;	//assertions to determine which task to perform at clock

reg [3:0] opcode;		//opcode
reg [3:0] cc;			//condition code
reg src_type,dest_type;		//source/destination type
reg [11:0] src_addr;		//source address or shift/rotate amount
reg [11:0] dest_addr;		//destination address

integer PC;			//program counter
reg [31:0] instr;		//instruction storage
reg [31:0] src_data;		//data stored at source address
reg [31:0] dest_data;		//data stored at destination address

reg [4:0] PSR;			//Program Status Register
reg [31:0] mem [0:5];		//memory used by processor, first X registers are data

reg [31:0] regfile [0:15];	//Register File



initial
begin
	clk = 0;
	fetch = 1;
	decode = 0;
	execute = 0;
	writeback = 0;
	PSR = 5'b00000;
	PC = 2;//4;
	instr = 0;
	src_data = 0;
	dest_data = 0;
	
	mem[0] = 3;
	mem[1] = 4;
	mem[2] = 32'h50000001;
	mem[3] = 32'h50001001;
	mem[4] = 32'h50001000;
	mem[5] = 32'h50000000;
	
	#50 $finish;
end

always
begin
	#1 clk = ~clk;
end

always @(posedge clk)
begin
	$monitor("mem[0] = %d, mem[1] = %d, instr = %h, PC = $d",mem[0],mem[1],instr,PC);
	if(fetch)			//fetch instruction from memory
	begin
		$display("entered fetch");
		instr = mem[PC];
		
		fetch = 0;
		decode = 1;
	end
	
	else if(decode)	//decode instruction
	begin
		$display("entered decode");
		opcode = instr[31:28];
		cc = instr[27:24];
		src_type = instr[27];
		dest_type = instr[26];
		src_addr = instr[23:12];
		dest_addr = instr[11:0];
		
		decode = 0;
		execute = 1;
	end
	
	else if(execute)	//execute instruction depending on opcode
	begin
	$display("entered execute");
	case(opcode)
		4'b0000:	//No operation
		begin
			PC = PC + 1;
		
			execute = 0;
			fetch = 1;
		end
	
		4'b0001:	//Load
		begin
			PSR[0] = 0;
			
			regfile[dest_addr] = mem[src_addr];
			
			PC = PC + 1;
			execute = 0;
			fetch = 1;
		end
	
		4'b0010:	//Store
		begin
			PSR = 5'b00000;
			
			dest_data = regfile[src_addr];
			
			PC = PC + 1;
			execute = 0;
			writeback = 1;
		end
	
		4'b0011:	//Branch
		begin
			case(cc)
				4'b0000:	//always
				begin
				PC = dest_addr;
				execute = 0;
				fetch = 1;
				end

				4'b0001:	//parity
				begin
				if(PSR[1])
					PC = dest_addr;
				else
					PC = PC + 1;

				execute = 0;
				fetch = 1;
				end

				4'b0010:	//even
				begin
				if(PSR[2])
					PC = dest_addr;
				else
					PC = PC + 1;

				execute = 0;
				fetch = 1;
				end

				4'b0011:	//carry
				begin
				if(PSR[0])
					PC = dest_addr;
				else
					PC = PC + 1;

				execute = 0;
				fetch = 1;
				end

				4'b0100:	//negative
				begin
				if(PSR[3])
					PC = dest_addr;
				else
					PC = PC + 1;

				execute = 0;
				fetch = 1;
				end

				4'b0101:	//zero
				begin
				if(PSR[4])
					PC = dest_addr;
				else
					PC = PC + 1;

				execute = 0;
				fetch = 1;
				end

				4'b0110:	//no carry
				begin
				if(PSR[0])
					PC = PC + 1;
				else
					PC = dest_addr;

				execute = 0;
				fetch = 1;
				end

				4'b0111:	//positive
				begin
				if(PSR[3])
					PC = PC + 1;
				else
					PC = dest_addr;

				execute = 0;
				fetch = 1;
				end
			endcase
		end
	
		4'b0100:	//XOR
		begin
			//set PSR
			regfile[dest_addr] = regfile[dest_addr] ^ regfile[src_addr];

			
			PSR[0] = 0;
			PSR[2] = regfile[dest_addr][0];
			PSR[3] = regfile[dest_addr][31];
			if(regfile[dest_addr] == 32'h00000000)
				PSR[4] = 1;
			else
				PSR[4] = 0;

			PC = PC + 1;
			execute = 0;
			fetch = 1;
		end
	
		4'b0101:	//ADD
		begin
			//set PSR
			regfile[dest_addr] = regfile[dest_addr] + regfile[src_addr];
		
			PC = PC + 1;
			execute = 0;
			fetch = 1;
		end
	
		4'b0110:	//Rotate
		begin
			//set PSR
		end
	
		4'b0111:	//Shift
		begin
			//set PSR
			if(src_addr[11])
				regfile[dest_addr] = $signed(regfile[dest_addr]) <<< src_addr[10:0];
			else
				regfile[dest_addr] = $signed(regfile[dest_addr]) >>> src_addr[10:0];

			PC = PC + 1;
			execute = 0;
			fetch = 1;
		end
	
		4'b1000:	//Halt
		begin
			PC = PC + 1;
			
			execute = 0;
			fetch = 1;
		end
		
		4'b1001:	//Complement
		begin
			//set PSR
			PSR[0] = 0;
			regfile[dest_addr] = ~regfile[src_addr];
			
			PC = PC + 1;
			execute = 0;
			fetch = 1;
		end
	endcase
	end
	
	else if(writeback)
	begin
		$display("entered writeback");
		mem[dest_addr] = dest_data;
	
		writeback = 0;
		fetch = 1;
	end
	
end
endmodule
