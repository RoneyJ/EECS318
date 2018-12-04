//Processor module for HW3
//This is the processor with instructions made for problem 2
//These instructions count the number of 1's in mem[0] and stores it in mem[1]
//Josh Roney (jpr87)
module P2_processor;
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
reg [31:0] mem [0:13];		//memory used by processor, first 2 registers hold data

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
	PC = 2;
	instr = 0;
	data = 0;
	//instructions to count number of 1's in mem[0]
	mem[0] = 6;
	mem[1] = 0;
	
	mem[3] = 32'h10000000;	//load mem[0] into regfile[0]
	//0
	mem[4] = 32'h32000005;	//branch if even
	mem[5] = 32'h58001001;	//add 1 to regfile[1]
	mem[6] = 32'h70001002;	//add 1 to regfile[2]
	mem[7] = 32'h18020003;	//load 32 into regfile[3]
	mem[8] = 32'h40002003;	//xor regfile[3] and regfile[2]
	mem[9] = 32'h3500000c;	//branch to end if zero
	mem[10] = 32'h70001000;	//shift regfile[0] right
	mem[11] = 32'h30000004;	//redo loop
	
	mem[12] = 32'h20001001;	//store regfile[1] in mem[1]
	mem[13] = 32'h80000000;	//halt
	//1
	/*mem[6] = 32'h32000005;	//branch if even
	mem[7] = 32'h58001001;	//add 1 to regfile[1]
	mem[8] = 32'h70001000;	//shift regfile[0] right
	//2
	mem[9] = 32'h32000005;	//branch if even
	mem[10] = 32'h58001001;	//add 1 to regfile[1]
	mem[11] = 32'h70001000;	//shift regfile[0] right
	//3
	mem[12] = 32'h32000005;	//branch if even
	mem[13] = 32'h58001001;	//add 1 to regfile[1]
	mem[14] = 32'h70001000;	//shift regfile[0] right
	//4
	mem[15] = 32'h32000005;	//branch if even
	mem[16] = 32'h58001001;	//add 1 to regfile[1]
	mem[17] = 32'h70001000;	//shift regfile[0] right
	//5
	mem[18] = 32'h32000005;	//branch if even
	mem[19] = 32'h58001001;	//add 1 to regfile[1]
	mem[20] = 32'h70001000;	//shift regfile[0] right
	//6
	mem[21] = 32'h32000005;	//branch if even
	mem[22] = 32'h58001001;	//add 1 to regfile[1]
	mem[23] = 32'h70001000;	//shift regfile[0] right
	//7
	mem[24] = 32'h32000005;	//branch if even
	mem[25] = 32'h58001001;	//add 1 to regfile[1]
	mem[26] = 32'h70001000;	//shift regfile[0] right
	//8
	mem[27] = 32'h32000005;	//branch if even
	mem[28] = 32'h58001001;	//add 1 to regfile[1]
	mem[29] = 32'h70001000;	//shift regfile[0] right
	//9
	mem[30] = 32'h32000005;	//branch if even
	mem[31] = 32'h58001001;	//add 1 to regfile[1]
	mem[32] = 32'h70001000;	//shift regfile[0] right
	//10
	mem[33] = 32'h32000005;	//branch if even
	mem[34] = 32'h58001001;	//add 1 to regfile[1]
	mem[35] = 32'h70001000;	//shift regfile[0] right
	//11
	mem[36] = 32'h32000005;	//branch if even
	mem[37] = 32'h58001001;	//add 1 to regfile[1]
	mem[38] = 32'h70001000;	//shift regfile[0] right
	//12
	mem[39] = 32'h32000005;	//branch if even
	mem[40] = 32'h58001001;	//add 1 to regfile[1]
	mem[41] = 32'h70001000;	//shift regfile[0] right
	//13
	mem[42] = 32'h32000005;	//branch if even
	mem[43] = 32'h58001001;	//add 1 to regfile[1]
	mem[44] = 32'h70001000;	//shift regfile[0] right
	//14
	mem[45] = 32'h32000005;	//branch if even
	mem[46] = 32'h58001001;	//add 1 to regfile[1]
	mem[47] = 32'h70001000;	//shift regfile[0] right
	//15
	mem[48] = 32'h32000005;	//branch if even
	mem[49] = 32'h58001001;	//add 1 to regfile[1]
	mem[50] = 32'h70001000;	//shift regfile[0] right
	//16
	mem[51] = 32'h32000005;	//branch if even
	mem[52] = 32'h58001001;	//add 1 to regfile[1]
	mem[53] = 32'h70001000;	//shift regfile[0] right
	//17
	mem[54] = 32'h32000005;	//branch if even
	mem[55] = 32'h58001001;	//add 1 to regfile[1]
	mem[56] = 32'h70001000;	//shift regfile[0] right
	//18
	mem[57] = 32'h32000005;	//branch if even
	mem[58] = 32'h58001001;	//add 1 to regfile[1]
	mem[59] = 32'h70001000;	//shift regfile[0] right
	//19
	mem[60] = 32'h32000005;	//branch if even
	mem[61] = 32'h58001001;	//add 1 to regfile[1]
	mem[62] = 32'h70001000;	//shift regfile[0] right
	//20
	mem[63] = 32'h32000005;	//branch if even
	mem[64] = 32'h58001001;	//add 1 to regfile[1]
	mem[65] = 32'h70001000;	//shift regfile[0] right
	//21
	mem[66] = 32'h32000005;	//branch if even
	mem[67] = 32'h58001001;	//add 1 to regfile[1]
	mem[68] = 32'h70001000;	//shift regfile[0] right
	//22
	mem[69] = 32'h32000005;	//branch if even
	mem[70] = 32'h58001001;	//add 1 to regfile[1]
	mem[71] = 32'h70001000;	//shift regfile[0] right
	//23
	mem[72] = 32'h32000005;	//branch if even
	mem[73] = 32'h58001001;	//add 1 to regfile[1]
	mem[74] = 32'h70001000;	//shift regfile[0] right
	//24
	mem[75] = 32'h32000005;	//branch if even
	mem[76] = 32'h58001001;	//add 1 to regfile[1]
	mem[77] = 32'h70001000;	//shift regfile[0] right
	//25
	mem[78] = 32'h32000005;	//branch if even
	mem[79] = 32'h58001001;	//add 1 to regfile[1]
	mem[80] = 32'h70001000;	//shift regfile[0] right
	//26
	mem[81] = 32'h32000005;	//branch if even
	mem[82] = 32'h58001001;	//add 1 to regfile[1]
	mem[83] = 32'h70001000;	//shift regfile[0] right
	//27
	mem[84] = 32'h32000005;	//branch if even
	mem[85] = 32'h58001001;	//add 1 to regfile[1]
	mem[86] = 32'h70001000;	//shift regfile[0] right
	//28
	mem[87] = 32'h32000005;	//branch if even
	mem[88] = 32'h58001001;	//add 1 to regfile[1]
	mem[89] = 32'h70001000;	//shift regfile[0] right
	//29
	mem[90] = 32'h32000005;	//branch if even
	mem[91] = 32'h58001001;	//add 1 to regfile[1]
	mem[92] = 32'h70001000;	//shift regfile[0] right
	//30
	mem[93] = 32'h32000005;	//branch if even
	mem[94] = 32'h58001001;	//add 1 to regfile[1]
	mem[95] = 32'h70001000;	//shift regfile[0] right
	//31
	mem[96] = 32'h32000005;	//branch if even
	mem[97] = 32'h58001001;	//add 1 to regfile[1]
	mem[98] = 32'h70001000;	//shift regfile[0] right
	
	mem[99] = 32'h20001001;	//store regfile[1] in mem[0]
	mem[100] = 32'h80000000;//halt*/
	

	#80 $display("mem[0] = %b , mem[1] = %d", mem[0], mem[1]);
	$finish;
end

always
begin
	#1 clk = ~clk;
end

always @(posedge clk)
begin
	if(fetch)	//fetch instruction from memory
	begin
		instr = mem[PC];
		
		fetch = 0;
		decode = 1;
	end
	
	else if(decode)	//decode instruction
	begin
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
			//set PSR
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
			//set PSR
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
			//set PSR
			regfile[dest_addr] = rotate(regfile[dest_addr],regfile[src_addr]);

			PSR = psr(regfile[dest_addr]);
			
			PC = PC + 1;
			execute = 0;
			fetch = 1;
		end
	
		4'b0111:	//Shift
		begin
			//set PSR
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
		mem[dest_addr] = data;
	
		writeback = 0;
		fetch = 1;
	end
	
end
endmodule
