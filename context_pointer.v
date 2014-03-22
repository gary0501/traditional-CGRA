`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:24:31 04/30/2013 
// Design Name: 
// Module Name:    context_pointer 
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
module context_pointer( CLK, start, CP
    );
	 input CLK,start;
	 output [15:0] CP;
	 reg [15:0] CP;
	  // counter
	 reg [3:0] counter;
	 //
	
	 
	 
	initial begin
		CP = 0;
		//counter = 0;
	end
	
	always@(posedge CLK) begin
		if(start == 1)
			CP = CP + 1;
		else
			CP = CP;
	end	

endmodule
