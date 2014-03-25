`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:46:41 10/12/2013 
// Design Name: 
// Module Name:    memory 
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
module memory( CLK, bus0_ld_addr, bus1_ld_addr, bus2_ld_addr, 
						  bus0_st_addr, bus1_st_addr, bus2_st_addr,
					     bus0_from_mem, bus1_from_mem, bus2_from_mem, 
						  bus0_data_in, bus1_data_in, bus2_data_in,
						  write0, write1, write2
    );
	 
	 input CLK;
	 input write0, write1, write2;
	 input [31:0] bus0_ld_addr, bus1_ld_addr, bus2_ld_addr;
	 input [31:0] bus0_st_addr, bus1_st_addr, bus2_st_addr;
	 
	 input [31:0]  bus0_data_in, bus1_data_in, bus2_data_in;
	 output [31:0] bus0_from_mem, bus1_from_mem, bus2_from_mem;
	 
	 reg [31:0] mem [63:0];
	 
	 
	 
	 assign bus0_from_mem = mem[bus0_ld_addr];
	 assign bus1_from_mem = mem[bus1_ld_addr];
	 assign bus2_from_mem = mem[bus2_ld_addr];
	 
	 always @ (negedge CLK)
	 begin
		if(write0 == 1) mem[bus0_st_addr] <= bus0_data_in;
		else mem[bus0_st_addr] <= mem[bus0_st_addr]; 
		
		if(write1 == 1) mem[bus1_st_addr] <= bus1_data_in;
		else mem[bus1_st_addr] <= mem[bus1_st_addr];
		
		if(write2 == 1) mem[bus2_st_addr] <= bus2_data_in;
		else mem[bus2_st_addr] <= mem[bus2_st_addr];
	 end


endmodule
