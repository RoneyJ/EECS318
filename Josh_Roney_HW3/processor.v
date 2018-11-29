//Processor module for HW3
//Josh Roney (jpr87)
module processor;
reg clk;

reg fetch, decode, execute, writeback;	//assertions to determine which task to perform at clock

reg [3:0] opcode;			//opcode
reg [3:0] cc;				//condition code
reg src_type,dest_type;	//source/destination type
reg [11:0] src_addr;		//source address or shift/rotate amount
reg [11:0] dest_addr;	//destination address

integer PC;					//program counter
reg [31:0] instr;			//instruction storage
reg [31:0] src_data;		//data stored at source address
reg [31:0] dest_data;	//data stored at destination address

reg [4:0] PSR;				//Program Status Register
reg [31:0] mem [0:5];	//memory used by processor, first X registers are data

reg [31:0] regfile;	//Register File

$monitor("Mem[0] = %d \t Mem[1] = %d \t Mem[2] = %h \t clock = %b \t PC = $d",mem[0],mem[1],mem[2],clk,PC);

initial
begin
	clk = 0;
	fetch = 1;
	decode = 0;
	execute = 0;
	writeback = 0;
	PSR = 5'b00000;
	PC = 2;//4;
	
	mem[0] = 3;
	mem[1] = 4;
	mem[2] = 32'b01010000000000000000000000000001;
	
	//#30 $finish;
end

always @*
begin
	#1 clk = ~clk;
end

always @(posedge clk)
begin
	if(fetch)			//fetch instruction from memory
	begin
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
		
			fetch = 1;
			execute = 0;
		end
	
		4'b0001:	//Load
		begin
		end
	
		4'b0010:	//Store
		begin
		end
	
		4'b0011:	//Branch
		begin
		end
	
		4'b0100:	//XOR
		begin
		end
	
		4'b0101:	//ADD
		begin
			//set PSR
			src_data = mem[src_addr];
			dest_data = mem[dest_addr];
		
			dest_data = dest_data + src_data;
		
			PC = PC + 1;
			execute = 0;
			writeback = 1;
		end
	
		4'b0110:	//Rotate
		begin
		end
	
		4'b0111:	//Shift
		begin
		end
	
		4'b1000:	//Halt
		begin
			PC = PC + 1;
			
			execute = 0;
			fetch = 1;
		end
		
		4'b1001:	//Complement
		begin
			
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
