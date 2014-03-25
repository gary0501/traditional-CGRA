`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:21:13 10/12/2013 
// Design Name: 
// Module Name:    AGU0 
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
module AGU0( CLK, 
				bus_from_PE1, bus_from_PE2, bus_from_PE3, //data from pe
				pred_PE1, pred_PE2, pred_PE3, // pred from pe
				op_code, bus2mem_ld, imm_val, pred_control, select_pred, bus2mem_st_addr, bus2mem_st_data,//control signal
				ld_addr, enable_ld_write, st_addr, enable_st_write, st_data //output
	 );
	 
	 input CLK;
	 input pred_control;
	 input [31:0] bus_from_PE1, bus_from_PE2, bus_from_PE3;
	 input [3:0] pred_PE1, pred_PE2, pred_PE3, select_pred;
	 input [3:0] op_code, bus2mem_ld, bus2mem_st_addr, bus2mem_st_data; 
	 input signed [7:0] imm_val;
	 //op_code: 0001=ld_i, 0010=st_i
	 //bus2mem_ld: 0001= bus from pe1, 0010=pe2, 0100=pe3

	 wire [3:0] pred;
	 output enable_st_write, enable_ld_write;
	 output [31:0] ld_addr, st_addr, st_data;
	 
	 
////////////   select predicate  ////////////
	 assign pred = (select_pred[0]==1) ? pred_PE1 :
						(select_pred[1]==1) ? pred_PE2 :
						(select_pred[2]==1) ? pred_PE3 : 0 ;

	 
////////////   load part  //////////
	 assign enable_ld_write = (op_code == 4'b0001) ?
											((pred_control == 1) ? pred[0] : 1)
												: 0 ;
	//select ld_addr from pe's bus out then add immediate value.
	 assign ld_addr = (bus2mem_ld[0] == 1) ? bus_from_PE1 + imm_val :
							(bus2mem_ld[1] == 1) ? bus_from_PE2 + imm_val :
							(bus2mem_ld[2] == 1) ? bus_from_PE3 + imm_val : 0;
///////////    store part ///////////
	
	 assign enable_st_write = (op_code == 4'b0010) ? 
										((pred_control == 1) ? pred[0] : 1 )
											: 0 ;
	 assign st_addr = (bus2mem_st_addr[0] == 1) ? bus_from_PE1 + imm_val :
							(bus2mem_st_addr[1] == 1) ? bus_from_PE2 + imm_val :
							(bus2mem_st_addr[2] == 1) ? bus_from_PE3 + imm_val : 0;
	
    assign st_data = (bus2mem_st_data[0] == 1) ? bus_from_PE1 :
							(bus2mem_st_data[1] == 1) ? bus_from_PE2 :
							(bus2mem_st_data[2] == 1) ? bus_from_PE3 : 0;
	
endmodule
