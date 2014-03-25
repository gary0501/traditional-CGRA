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
	 //�M�w�n�q����PE��busŪ�J�nload��memory��m : 0001= bus from pe1, 0010=pe2, 0100=pe3
	 output [7:0] imm_val; //�N�O�o��cycle��imm_val(�i�H�Oload�]�i�H�Ostore��)
	 output pred_control; //�M�w�o��cycle���ʧ@�O�_�n��pred
	 output [3:0] select_pred; //pred�n�ݱq����PE�e�Ӫ�pred, 0001= pe1,0010=pe2......
	 output [3:0] bus2mem_st_addr;
	 //�M�w�n�q����PEŪ�J�nstore��memory��m,��m�ƪk�P�W
	 output [3:0] bus2mem_st_data;
	 //�M�w�n�q����PEŪ�J�nstore��memory�����,�ƪk�P�W
	
	
	 assign op_code = indata[3:0]; 
	 assign bus2mem_ld = indata[7:4];
	 assign imm_val = indata[15:8];
	 assign pred_control = indata[16];
	 assign select_pred = indata[20:17]; 
	 assign bus2mem_st_addr = indata[24:21];
	 assign bus2mem_st_data = indata[28:25];
	 
endmodule
 
			
