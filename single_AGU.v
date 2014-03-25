`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:17:27 11/02/2013 
// Design Name: 
// Module Name:    single_AGU 
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
module AGU_control(CLK, AGU_data, start, op_code, 
			bus2mem_ld, imm_val, pred_control, select_pred,
			bus2mem_st_addr, bus2mem_st_data
    );
	 
	 parameter width = 28;
	 input CLK, start;
	 input [width:0] AGU_data;
	 output [3:0] op_code, bus2mem_ld, bus2mem_st_addr, bus2mem_st_data;
	 output [3:0] select_pred;
	 output [7:0] imm_val;
	 output pred_control;
	 
	 wire [width:0] cache_buffer;
	 wire 	[15:0] CP;
	 
	 AGU_context_cache i_AGU_cc(AGU_data, cache_buffer, start, CLK, CP);
	 
	 context_pointer i_CP_AGU (CLK, start, CP);
	 
	 AGU_buffer i_AGU_buffer( CLK, cache_buffer, op_code, 
			bus2mem_ld, imm_val, pred_control, select_pred,
			bus2mem_st_addr, bus2mem_st_data
    );
	 
	 

endmodule
