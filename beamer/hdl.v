module krnl(
	input wire a[DATA_SIZE-1:0][31:0],
	input wire b[DATA_SIZE-1:0][31:0],
	output reg c[DATA_SIZE-1:0][31:0],
	input wire in_ready,
	output wire out_ready
)
	reg[31:0] offset = 0;
	genvar i
	generate
		for (i = 0; i < NUM_ADDERS; i+=1)
		begin:adders
			adder tmp(
				.a(a[offset+i]),
				.b(b[offset+i]),
				.c(c[offset+i])
			);
		end
	endgenerate
	always @(posedge and(
			and(adders[0:NUM_ADDERS-1]),
			offset < DATA_SIZE
		)) begin
		offset += NUM_ADDERS;
	end
	assign out_ready = and(
		and(adders[0:NUM_ADDERS-1]),
		offset >= DATA_SIZE
	);
endmodule
