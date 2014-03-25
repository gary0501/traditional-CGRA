`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    10:09:41 12/30/2013 
// Design Name: 
// Module Name:    design1 
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
module design1( CLK, start, 
					 PE1_data, PE2_data, PE3_data,
					 PE4_data, PE5_data, PE6_data,
					 PE7_data, PE8_data, PE9_data,
					 AGU0_data, AGU1_data, AGU2_data,
					 //pe edge part
					 
					 //mem part
					
					 bus_p_in
    );
	 
	 parameter PE_data_width = 120;
	 parameter AGU_data_width = 28;
	 
	 input CLK, start;
	 input [PE_data_width:0] PE1_data, PE2_data, PE3_data, 
									 PE4_data, PE5_data, PE6_data, 
									 PE7_data, PE8_data, PE9_data ;
	 input [AGU_data_width:0] AGU0_data, AGU1_data, AGU2_data;
	 
	 
	 /////////////////////////////////////////////////////
	 ////////////////PE1 wire & input output//////////////
	 
	 wire enable_ld_write_1;
	 wire [31:0] bus0_mem2pe, bus0_pe12agu0;
	 wire [3:0] pred_pe12agu0;
	 // temp: edge input and output
	 wire [31:0] edge1_2left, edge3_2up;
	 wire [3:0] edge1_p_2left, edge3_p_2up;
	 wire [31:0] edge1_2right, edge3_2down;
	 wire [3:0] edge1_p_2right, edge3_p_2down; 
	 //  unused signal
	 input [3:0]  bus_p_in;
	 
	 /////////////////////////////////////////////////////
	 /////////////////////////////////////////////////////
	 
	 /////////////////////////////////////////////////////
	 ////////////////PE2 wire & input output//////////////
	 
	 //wire enable_ld_write_1;
	 //wire [31:0] bus0_mem2pe;
	 wire [31:0] bus0_pe22agu0;
	 wire [3:0] pred_pe22agu0;
	 // temp: edge input and output
	
	 wire [31:0] edge2_2left, edge4_2up;
	 wire [3:0] edge2_p_2left, edge4_p_2up;
	 wire [31:0] edge2_2right, edge4_2down;
	 wire [3:0] edge2_p_2right, edge4_p_2down;
	 //  unused signal
	 //input [3:0]  bus_p_in;
	 
	 /////////////////////////////////////////////////////
	 /////////////////////////////////////////////////////
	 
	 
	 /////////////////////////////////////////////////////
	 ////////////////PE3 wire & input output//////////////
	 
	 //wire enable_ld_write_1;
	 //wire [31:0] bus0_mem2pe;
	 wire [31:0] bus0_pe32agu0;
	 wire [3:0] pred_pe32agu0;
	 // temp: edge input and output
	
	 wire [31:0] edge5_2up;
	 wire [3:0] edge5_p_2up;
	 wire [31:0] edge5_2down;
	 wire [3:0] edge5_p_2down;
	 //  unused signal
	 //input [3:0]  bus_p_in;
	 
	 /////////////////////////////////////////////////////
	 /////////////////////////////////////////////////////
	 
	 /////////////////////////////////////////////////////
	 ////////////////PE4 wire & input output//////////////
	 
	 wire enable_ld_write_2;
	 wire [31:0] bus1_mem2pe, bus1_pe12agu1;
	 wire [3:0] pred_pe12agu1;
	 // temp: edge input and output
	 wire [31:0] edge6_2left, edge8_2up;
	 wire [3:0] edge6_p_2left, edge8_p_2up;
	 wire [31:0] edge6_2right, edge8_2down;
	 wire [3:0] edge6_p_2right, edge8_p_2down; 
	 //  unused signal
	 //input [3:0]  bus_p_in;
	 
	 /////////////////////////////////////////////////////
	 /////////////////////////////////////////////////////
	 
	 /////////////////////////////////////////////////////
	 ////////////////PE5 wire & input output//////////////
	 
	 //wire enable_ld_write_2;
	 //wire [31:0] bus1_mem2pe, 
	 wire [31:0] bus1_pe22agu1;
	 wire [3:0] pred_pe22agu1;
	 // temp: edge input and output
	 wire [31:0] edge7_2left, edge9_2up;
	 wire [3:0] edge7_p_2left, edge9_p_2up;
	 wire [31:0] edge7_2right, edge9_2down;
	 wire [3:0] edge7_p_2right, edge9_p_2down; 
	 //  unused signal
	 //input [3:0]  bus_p_in;
	 
	 /////////////////////////////////////////////////////
	 /////////////////////////////////////////////////////
	 
	 /////////////////////////////////////////////////////
	 ////////////////PE6 wire & input output//////////////
	 
	 //wire enable_ld_write_2;
	 //wire [31:0] bus1_mem2pe, 
	 wire [31:0] bus1_pe32agu1;
	 wire [3:0] pred_pe32agu1;
	 // temp: edge input and output
	 wire [31:0] edge10_2up;
	 wire [3:0] edge10_p_2up;
	 wire [31:0] edge10_2down;
	 wire [3:0] edge10_p_2down; 
	 //  unused signal
	 //input [3:0]  bus_p_in;
	 
	 /////////////////////////////////////////////////////
	 /////////////////////////////////////////////////////
	 
	 /////////////////////////////////////////////////////
	 ////////////////PE7 wire & input output//////////////
	 
	 wire enable_ld_write_3;
	 wire [31:0] bus2_mem2pe; 
	 wire [31:0] bus2_pe12agu2;
	 wire [3:0] pred_pe12agu2;
	 // temp: edge input and output
	 wire [31:0] edge11_2left;
	 wire [3:0] edge11_p_2left;
	 wire [31:0] edge11_2right;
	 wire [3:0] edge11_p_2right; 
	 //  unused signal
	 //input [3:0]  bus_p_in;
	 
	 /////////////////////////////////////////////////////
	 /////////////////////////////////////////////////////
	 
	 /////////////////////////////////////////////////////
	 ////////////////PE8 wire & input output//////////////
	 
	 //wire enable_ld_write_3;
	 //wire [31:0] bus2_mem2pe; 
	 wire [31:0] bus2_pe22agu2;
	 wire [3:0] pred_pe22agu2;
	 // temp: edge input and output
	 wire [31:0] edge12_2left;
	 wire [3:0] edge12_p_2left;
	 wire [31:0] edge12_2right;
	 wire [3:0] edge12_p_2right; 
	 //  unused signal
	 //input [3:0]  bus_p_in;
	 
	 /////////////////////////////////////////////////////
	 /////////////////////////////////////////////////////
	 
	 /////////////////////////////////////////////////////
	 ////////////////PE9 wire & input output//////////////
	 
	 //wire enable_ld_write_3;
	 //wire [31:0] bus2_mem2pe; 
	 wire [31:0] bus2_pe32agu2;
	 wire [3:0] pred_pe32agu2;
	 // temp: edge input and output
	 
	 //  unused signal
	 //input [3:0]  bus_p_in;
	 
	 /////////////////////////////////////////////////////
	 /////////////////////////////////////////////////////
	 
	 
	 /////////////////////////////////////////////////////
	 //////////////MEMORY wire & input output/////////////
	 wire [31:0] bus0_ld_addr, bus0_st_addr;
	 wire [31:0] bus1_ld_addr, bus1_st_addr;
	 wire [31:0] bus2_ld_addr, bus2_st_addr;
	 wire [31:0] bus0_agu02mem, bus1_agu12mem, bus2_agu22mem;
	 wire mem_write0, mem_write1, mem_write2;

	 /////////////////////////////////////////////////////
	 /////////////////////////////////////////////////////
	 
	 
	 /////////////////////////////////////////////////////
	 /////////////// AGU control 0 wire //////////////////
	 wire [3:0] agu0_op, bus2mem_ld_0, bus2mem_st_addr_0, bus2mem_st_data_0;
	 wire [7:0] agu0_imm_val;
	 wire agu0_pred_control;
	 wire [3:0] agu0_select_pred;
	 /////////////////////////////////////////////////////
	 /////////////////////////////////////////////////////
	 
	 /////////////////////////////////////////////////////
	 /////////////// AGU control 1 wire //////////////////
	 wire [3:0] agu1_op, bus2mem_ld_1, bus2mem_st_addr_1, bus2mem_st_data_1;
	 wire [7:0] agu1_imm_val;
	 wire agu1_pred_control;
	 wire [3:0] agu1_select_pred;
	 /////////////////////////////////////////////////////
	 /////////////////////////////////////////////////////
	 
	 /////////////////////////////////////////////////////
	 /////////////// AGU control 2 wire //////////////////
	 wire [3:0] agu2_op, bus2mem_ld_2, bus2mem_st_addr_2, bus2mem_st_data_2;
	 wire [7:0] agu2_imm_val;
	 wire agu2_pred_control;
	 wire [3:0] agu2_select_pred;
	 /////////////////////////////////////////////////////
	 /////////////////////////////////////////////////////
	 
	 //////////  PE1 /////////////////////////
	 single_PE1 i_PE_1 (	CLK, PE1_data, start, enable_ld_write_1, 
	 edge1_2left, edge3_2up , bus0_mem2pe, 
	 edge1_p_2left, edge3_p_2up , bus_p_in,
	 edge1_2right, edge3_2down , bus0_pe12agu0, 
	 edge1_p_2right, edge3_p_2down , pred_pe12agu0
	 );
	 
	 /////////  PE2  /////////////////////////
	 single_PE2 i_PE_2( CLK, PE2_data, start, enable_ld_write_1, 
	 edge1_2right, edge2_2left ,edge4_2up, bus0_mem2pe, 
	 edge1_p_2right, edge2_p_2left , edge4_p_2up, bus_p_in,
	 edge1_2left, edge2_2right , edge4_2down, bus0_pe22agu0, 
	 edge1_p_2left, edge2_p_2right , edge4_p_2down, pred_pe22agu0
    );
	 
	 /////////  PE3  /////////////////////////
	 single_PE3 i_PE_3 ( CLK, PE3_data, start, enable_ld_write_1, 
	 edge2_2right, edge5_2up , bus0_mem2pe, 
	 edge2_p_2right, edge5_p_2up , bus_p_in,
	 edge2_2left, edge5_2down , bus0_pe32agu0, 
	 edge2_p_2left, edge5_p_2down , pred_pe32agu0 
    );
	 
	 /////////  PE4  /////////////////////////
	 single_PE4 i_PE_4 ( CLK, PE4_data, start, enable_ld_write_2, 
	 edge3_2down, edge6_2left ,edge8_2up, bus1_mem2pe, 
	 edge3_p_2down, edge6_p_2left , edge8_p_2up, bus_p_in,
	 edge3_2up, edge6_2right , edge8_2down, bus1_pe12agu1, 
	 edge3_p_2up, edge6_p_2right , edge8_p_2down, pred_pe12agu1
    );
	 
	 /////////  PE5  /////////////////////////
	 single_PE5 i_PE_5 ( CLK, PE5_data, start, enable_ld_write_2, 
	 edge4_2down, edge6_2right ,edge7_2left, edge9_2up, bus1_mem2pe, 
	 edge4_p_2down, edge6_p_2right , edge7_p_2left, edge9_p_2up, bus_p_in,
	 edge4_2up, edge6_2left , edge7_2right, edge9_2down, bus1_pe22agu1, 
	 edge4_p_2up, edge6_p_2left , edge7_p_2right, edge9_p_2down, pred_pe22agu1
    );
	 
	 /////////  PE6  /////////////////////////
	 single_PE6 i_PE_6 ( CLK, PE6_data, start, enable_ld_write_2, 
	 edge5_2down, edge7_2right ,edge10_2up, bus1_mem2pe, 
	 edge5_p_2down, edge7_p_2right , edge10_p_2up, bus_p_in,
	 edge5_2up, edge7_2left , edge10_2down, bus1_pe32agu1, 
	 edge5_p_2up, edge7_p_2left , edge10_p_2down, pred_pe32agu1
    );
	 
	 /////////  PE7  /////////////////////////
	 single_PE7 i_PE_7 ( CLK, PE7_data, start, enable_ld_write_3, 
	 edge8_2down, edge11_2left , bus2_mem2pe, 
	 edge8_p_2down, edge11_p_2left , bus_p_in,
	 edge8_2up, edge11_2right , bus2_pe12agu2, 
	 edge8_p_2up, edge11_p_2right , pred_pe12agu2 
    );
	 
	 /////////  PE8  /////////////////////////
	 single_PE8 i_PE_8( CLK, PE8_data, start, enable_ld_write_3, 
	 edge9_2down, edge11_2right ,edge12_2left, bus2_mem2pe, 
	 edge9_p_2down, edge11_p_2right , edge12_p_2left, bus_p_in,
	 edge9_2up, edge11_2left , edge12_2right, bus2_pe22agu2, 
	 edge9_p_2up, edge11_p_2left , edge12_p_2right, pred_pe22agu2
    );
	 
	 /////////  PE9  /////////////////////////
	 single_PE9 i_PE_9 ( CLK, PE9_data, start, enable_ld_write_3, 
	 edge10_2down, edge12_2right , bus2_mem2pe, 
	 edge10_p_2down, edge12_p_2right , bus_p_in,
	 edge10_2up, edge12_2left , bus2_pe32agu2, 
	 edge10_p_2up, edge12_p_2left , pred_pe32agu2
    );
	 
	 /////////  MEMORY  //////////////////////
	 memory i_mem ( CLK, bus0_ld_addr, bus1_ld_addr, bus2_ld_addr, 
						  bus0_st_addr, bus1_st_addr, bus2_st_addr,
					     bus0_mem2pe, bus1_mem2pe, bus2_mem2pe, 
						  bus0_agu02mem, bus1_agu12mem, bus2_agu22mem,
						  mem_write0, mem_write1, mem_write2
    );
	 
	 ///////// AGU control 0///////////////////
	 AGU_control i_agu_ctrl_0 ( CLK, AGU0_data, start, agu0_op, 
			bus2mem_ld_0, agu0_imm_val, agu0_pred_control, agu0_select_pred,
			bus2mem_st_addr_0, bus2mem_st_data_0
    );
	 
	 ///////// AGU0  /////////////////////////
	 AGU0 i_agu_0 ( CLK, 
			bus0_pe12agu0, bus0_pe22agu0, bus0_pe32agu0, 
			pred_pe12agu0, pred_pe22agu0, pred_pe32agu0, 
			agu0_op, bus2mem_ld_0, agu0_imm_val, agu0_pred_control, agu0_select_pred, //control signal
			bus2mem_st_addr_0, bus2mem_st_data_0, //control signal
			bus0_ld_addr, enable_ld_write_1, bus0_st_addr, mem_write0, bus0_agu02mem //output
	 );
	 
	 ///////// AGU control 1///////////////////
	 AGU_control i_agu_ctrl_1 ( CLK, AGU1_data, start, agu1_op, 
			bus2mem_ld_1, agu1_imm_val, agu1_pred_control, agu1_select_pred,
			bus2mem_st_addr_1, bus2mem_st_data_1
    );
	 
	 ///////// AGU1  /////////////////////////
	 AGU0 i_agu_1 ( CLK, 
			bus1_pe12agu1, bus1_pe22agu1, bus1_pe32agu1, 
			pred_pe12agu1, pred_pe22agu1, pred_pe32agu1, 
			agu1_op, bus2mem_ld_1, agu1_imm_val, agu1_pred_control, agu1_select_pred, //control signal
			bus2mem_st_addr_1, bus2mem_st_data_1, //control signal
			bus1_ld_addr, enable_ld_write_2, bus1_st_addr, mem_write1, bus1_agu12mem //output
	 );
	 
	 ///////// AGU control 2///////////////////
	 AGU_control i_agu_ctrl_2 ( CLK, AGU2_data, start, agu2_op, 
			bus2mem_ld_2, agu2_imm_val, agu2_pred_control, agu2_select_pred,
			bus2mem_st_addr_2, bus2mem_st_data_2
    );
	 
	 ///////// AGU2  /////////////////////////
	 AGU0 i_agu_2 ( CLK, 
			bus2_pe12agu2, bus2_pe22agu2, bus2_pe32agu2, 
			pred_pe12agu2, pred_pe22agu2, pred_pe32agu2, 
			agu2_op, bus2mem_ld_2, agu2_imm_val, agu2_pred_control, agu2_select_pred, //control signal
			bus2mem_st_addr_2, bus2mem_st_data_2, //control signal
			bus2_ld_addr, enable_ld_write_3, bus2_st_addr, mem_write2, bus2_agu22mem //output
	 );
endmodule
