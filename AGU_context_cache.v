`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:09:57 11/02/2013 
// Design Name: 
// Module Name:    AGU_context_cache 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module AGU_context_cache( indata, outdata,	start, CLK, CP
    );
	 
	 
	parameter width = 28;
	input [width:0] indata;
	input start,CLK;
	input	[15:0] CP;
	output [width:0] outdata;
	//reg [width:0] outdata;
	
	reg [width:0] data_table [63:0];
	reg [255:0] number;
	 // counter
	// reg [3:0] counter;
	 //
	
	
	initial begin
		number = 0;
		//counter = 0;
	end
	
	
	assign outdata = data_table[CP];
	
	
	always @ (posedge CLK)
	begin
	
		if(start == 0)
		begin
			data_table[number] <= indata;
			number <= number + 1;
		end
		/*
		else if(start == 1)
		begin
			if(counter == 0)
				begin
				outdata = data_table[CP];
				counter = counter +1 ;
				end
			else
				begin
				outdata = outdata;
				counter = 0;
				end
		end
		*/
		else 
		begin
			number <= number;
		end
	end
	


endmodule
