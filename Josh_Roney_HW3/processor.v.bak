//Processor module for HW3
//Josh Roney (jpr87)

`include "ALU.v"

module processor(data, clk, out_data);
input [31:0] data;
input clk;
output [31:0] out_data;

reg [3:0] opcode;		//opcode
reg [3:0] cc;			//condition code
reg src_type,dest_type;		//source/destination type
reg [11:0] src_addr;		//source address
reg [11:0] count;		//shift/rotate count
reg [11:0] dest_addr;		//destination address

reg [31:0] memory [0:15];	//memory of 16 32-bit registers, the first 12 bits are the address field

reg [15:0] A,B,C;
reg [4:0] code;
reg overlfow;

ALU alu (A,B,code,C,overflow);

always @(posedge clk)
begin
	opcode = address[31:28];
	cc = address[27:24];
	src_type = address[27];
	dest_type = address[26];
	src_addr = address[23:12];
	count = address[23:12];
	dest_addr = address[11:0];
	
	case(opcode)
		4'b0000:	//NOP
		begin
			
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
			
		end

		4'b0110:	//Rotate
		begin
			
		end

		4'b0111:	//Shift
		begin
			
		end

		4'b1000:	//Halt
		begin
			
		end

		4'b1001:	//Complement
		begin
			
		end

	endcase
end
endmodule
