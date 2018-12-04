//Processor module for HW3
//This is the processor with instructions made for problem 3
//These instructions multiple 2 4-bit numbers in mem[0] and mem[1] and store it in mem[3]
//Josh Roney (jpr87)
module P3_processor;
reg clk;

reg fetch, decode, execute, writeback;	//assertions to determine which task to perform at clock

reg [3:0] opcode;		//opcode
reg [3:0] cc;			//condition code
reg src_type,dest_type;		//source/destination type
reg [11:0] src_addr;		//source address or shift/rotate amount
reg [11:0] dest_addr;		//destination address

integer PC;			//program counter
integer i,j;			//integers for function for loops
reg [31:0] instr;		//instruction storage
reg [31:0] data;		//data to be written into memory 

reg [4:0] PSR;			//Program Status Register
reg [31:0] mem [0:22];		//memory used by processor, first 2 registers hold data

reg [31:0] regfile [0:15];	//Register File of 16 32-bit registers

function parity;
input [31:0] r;
begin
	for(j=1;j<32;j=j+1)
	begin
		if(j==1)
		parity = r[j] ^ r[j-1];
		else
		parity = parity ^ r[j];
	end
end
endfunction

function [4:0] psr;
input [31:0] rg;
begin
	psr[0] = 0;	//ask how carry should be set
	psr[1] = parity(rg);
	psr[2] = ~rg[0];
	psr[3] = rg[31];
	if(rg == 32'h00000000)
		psr[4] = 1;
	else
		psr[4] = 0;
end
endfunction

function [31:0] rotate;
input [31:0] rg;
input [11:0] rot;
begin
	rotate = rg;
	if(rot[11])
		for(i=0;i<rot[10:0];i=i+1)
		begin
			rotate = {rotate[30:0],rotate[31]};
		end
	else
		for(i=0;i<rot[10:0];i=i+1)
		begin
			rotate = {rotate[0],rotate[31:1]};
		end
end
endfunction

initial
begin
	clk = 0;
	fetch = 1;
	decode = 0;
	execute = 0;
	writeback = 0;
	PSR = 5'b00000;
	PC = 3;
	instr = 0;
	data = 0;

	regfile[0] = 0;
	regfile[1] = 0;
	regfile[2] = 0;
	regfile[3] = 0;
	regfile[4] = 0;
	regfile[5] = 0;
	regfile[6] = 0;
	regfile[7] = 0;
	regfile[8] = 0;
	regfile[9] = 0;
	regfile[10] = 0;
	regfile[11] = 0;
	regfile[12] = 0;
	regfile[13] = 0;
	regfile[14] = 0;
	regfile[15] = 0;

	//isntructions to multiply mem[0] and mem[1] and store into mem[2]
	mem[0] = 4'b1000;	//8
	mem[1] = 4'b0110;	//6
	mem[2] = 0;		//product
	
	mem[4] = 32'h10000001;	//load mem[0] into regfile[1]
	mem[5] = 32'h34000008;	//branch if negative
	mem[6] = 32'h10001002;	//load mem[1] into regfile[2]
	mem[7] = 32'h3400000x;	//branch if negative

	//mem[0] was negative
	mem[8] = 32'h10001002;	//load mem[1] into regfile[2]
	mem[9] = 32'h3400000x;	//branch if negative
	//**Fill out all scenarios**

	//for 2 positive numbers
	mem[] = 32'h32000007;	//branch if even
	mem[] = 32'h50001000;	//add regfile[1] to regfile[0]
	mem[] = 32'h70801001;	//shift regfile[1] left
	mem[] = 32'h70001002;	//shift regfile[2] right

	mem[] = 32'h3200000b;	//branch is even
	mem[] = 32'h50001000;	//add regfile[1] to regfile[0]
	mem[] = 32'h70801001;	//shift regfile[1] left
	mem[] = 32'h70001002;	//shift regfile[2] right

	mem[] = 32'h3200000f;	//branch is even
	mem[] = 32'h50001000;	//add regfile[1] to regfile[0]
	mem[] = 32'h70801001;	//shift regfile[1] left
	mem[] = 32'h70001002;	//shift regfile[2] right

	mem[] = 32'h32000013;	//branch is even
	mem[] = 32'h50001000;	//add regfile[1] to regfile[0]
	mem[] = 32'h70801001;	//shift regfile[1] left
	mem[] = 32'h70001002;	//shift regfile[2] right

	mem[] = 32'h20000002;	//store regfile[0] in mem[2]
	mem[] = 32'h80000000;	//halt

	#125 $finish;
end

always
begin
	#1 clk = ~clk;
end

always @(posedge clk)
begin
	//$monitor("mem[0] = %d, mem[1] = %d, instr = %h, PC = $d",mem[0],mem[1],instr,PC);
	$monitor("PSR = %b, rg = %h", PSR, regfile[dest_addr]);
	if(fetch)	//fetch instruction from memory
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
	
	else if(execute)//execute instruction depending on opcode
	begin
	$display("entered execute");
	case(opcode)
		4'b0000://No operation
		begin
			PC = PC + 1;
		
			execute = 0;
			fetch = 1;
		end
	
		4'b0001://Load
		begin
			if(src_type)
				regfile[dest_addr] = src_addr;
			else
				regfile[dest_addr] = mem[src_addr];
			
			PSR = psr(regfile[dest_addr]);
			PSR[0] = 0;
			
			PC = PC + 1;
			execute = 0;
			fetch = 1;
		end
	
		4'b0010://Store
		begin
			PSR = 5'b00000;
			
			data = regfile[src_addr];

			PSR = 5'b00000;
			
			PC = PC + 1;
			execute = 0;
			writeback = 1;
		end
	
		4'b0011://Branch
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
			if(src_type)
				regfile[dest_addr] = regfile[dest_addr] ^ {{20{1'b0}},src_addr};
			else
				regfile[dest_addr] = regfile[dest_addr] ^ regfile[src_addr];

			
			PSR = psr(regfile[dest_addr]);
			PSR[0] = 0;

			PC = PC + 1;
			execute = 0;
			fetch = 1;
		end
	
		4'b0101:	//ADD
		begin
			if(src_type)
				regfile[dest_addr] = regfile[dest_addr] + src_addr;
			else
				regfile[dest_addr] = regfile[dest_addr] + regfile[src_addr];

			PSR = psr(regfile[dest_addr]);
		
			PC = PC + 1;
			execute = 0;
			fetch = 1;
		end
	
		4'b0110:	//Rotate
		begin
			regfile[dest_addr] = rotate(regfile[dest_addr],regfile[src_addr]);

			PSR = psr(regfile[dest_addr]);
			
			PC = PC + 1;
			execute = 0;
			fetch = 1;
		end
	
		4'b0111:	//Shift
		begin
			if(src_addr[11])
				regfile[dest_addr] = $signed(regfile[dest_addr]) <<< src_addr[10:0];
			else
				regfile[dest_addr] = $signed(regfile[dest_addr]) >>> src_addr[10:0];

			PSR = psr(regfile[dest_addr]);

			PC = PC + 1;
			execute = 0;
			fetch = 1;
		end
	
		4'b1000:	//Halt
		begin	//ask how halt should operate
			execute = 0;
			fetch = 0;
		end
		
		4'b1001:	//Complement
		begin
			//set PSR
			PSR[0] = 0;
			regfile[dest_addr] = ~regfile[src_addr];

			PSR = psr(regfile[dest_addr]);

			PSR[0] = 0;
			
			PC = PC + 1;
			execute = 0;
			fetch = 1;
		end
	endcase
	end
	
	else if(writeback)
	begin
		$display("entered writeback");
		mem[dest_addr] = data;
	
		writeback = 0;
		fetch = 1;
	end
	
end
endmodule
