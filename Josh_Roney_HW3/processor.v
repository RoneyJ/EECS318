//Processor module for HW3
//Josh Roney (jpr87)
module processor(address);
input [31:0] address;

reg [3:0] opcode;			//opcode
reg [3:0] cc;				//condition code
reg src_type,dest_type;	//source/destination type
reg [11:0] src_addr;		//source address
reg [11:0] count;			//shift/rotate count
reg [11:0] dest_addr;	//destination address

always @(address)
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
		4'b0001:	//Load
		4'b0010:	//Store
		4'b0011:	//Branch
		4'b0100:	//XOR
		4'b0101:	//ADD
		4'b0110:	//Rotate
		4'b0111:	//Shift
		4'b1000:	//Halt
		4'b1001:	//Complement
	endcase
end
endmodule
