`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    19:12:17 11/02/2013 
// Design Name: 
// Module Name:    AGU_buffer 
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
module AGU_buffer( CLK, indata, 
			op_code, bus2mem_ld, imm_val, pred_control, select_pred,
			bus2mem_st_addr, bus2mem_st_data
    );
	 parameter width = 28;
	 input CLK;
	 input [width:0] indata;
	 output [3:0] op_code; //0001 = ld_i, 0010 = st_i
	 output [3:0] bus2mem_ld;
	 //決定要從哪個PE的bus讀入要load的memory位置 : 0001= bus from pe1, 0010=pe2, 0100=pe3
	 output [7:0] imm_val; //就是這個cycle的imm_val(可以是load也可以是store的)
	 output pred_control; //決定這個cycle的動作是否要看pred
	 output [3:0] select_pred; //pred要看從哪個PE送來的pred, 0001= pe1,0010=pe2......
	 output [3:0] bus2mem_st_addr;
	 //決定要從哪個PE讀入要store的memory位置,位置排法同上
	 output [3:0] bus2mem_st_data;
	 //決定要從哪個PE讀入要store到memory的資料,排法同上
	
	
	 assign op_code = indata[3:0]; 
	 assign bus2mem_ld = indata[7:4];
	 assign imm_val = indata[15:8];
	 assign pred_control = indata[16];
	 assign select_pred = indata[20:17]; 
	 assign bus2mem_st_addr = indata[24:21];
	 assign bus2mem_st_data = indata[28:25];
	 
endmodule
 
			
