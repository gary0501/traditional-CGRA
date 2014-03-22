`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    02:29:41 04/28/2013 
// Design Name: 
// Module Name:    FU 
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
module FU(  pred_control, pred, op_mode_1, f_value_1, s_value_1, outvalue, outpred, write_back, write_back_p,
            imm, imm_val
    );
	input  pred_control; 
	input [3:0] pred;
	input [7:0] op_mode_1;
	input signed [31:0] f_value_1, s_value_1;
	input imm;
	input signed [7:0] imm_val;
	
	output write_back, write_back_p;
	
	output [3:0] outpred;
	output signed[31:0] outvalue;
	
	wire signed [31:0] op_s_value_1;
	assign op_s_value_1 = (imm == 0) ? s_value_1 :
						  32'b0 | imm_val;
	
	
	// ALU
	
	
	
		assign outvalue = (op_mode_1 == 8'b00000000) ? (f_value_1 + op_s_value_1) :	//add, add_u , addi, addi_u
								(op_mode_1 == 8'b00000001) ? (f_value_1 & op_s_value_1) :	//and
								(op_mode_1 == 8'b00000010) ? (f_value_1 >>> op_s_value_1) :	//asr
						//		(op_mode_1 == 8'b00000100) ? (f_value_1 / s_value_1) :	//div ·|¼Qcan not simplify operator DIV
								(op_mode_1 == 8'b00000101) ? (f_value_1 << op_s_value_1) :	//lsl
								(op_mode_1 == 8'b00000110) ? (f_value_1 >> op_s_value_1) :	//lsr
								(op_mode_1 == 8'b00000111) ? (f_value_1 * op_s_value_1) :	//mul
								(op_mode_1 == 8'b00001000) ? (f_value_1 | op_s_value_1) :	//or
								(op_mode_1 == 8'b00001001) ? (f_value_1 - op_s_value_1) :	//sub
								(op_mode_1 == 8'b00001010) ? (f_value_1 ^ op_s_value_1) : 0;//xor
		//op_mode_1[5] ==	cmp_op							
		assign outpred = (op_mode_1 == 8'b00100001) ? ((f_value_1 - op_s_value_1 == 0) ?  0 : 1) : //ne
						 (op_mode_1 == 8'b00100000) ? ((f_value_1 - op_s_value_1 == 0) ? 1 : 0) :  // eq	
						 (op_mode_1 == 8'b00100011) ? ((f_value_1 - op_s_value_1 > 0) ? 1 : 0) :  // gt
						 (op_mode_1 == 8'b00100010) ? ((f_value_1 - op_s_value_1 >= 0) ? 1 : 0) :  // ge
						 (op_mode_1 == 8'b00100101) ? ((f_value_1 - op_s_value_1 < 0) ? 1 : 0) :  // lt
						 (op_mode_1 == 8'b00100100) ? ((f_value_1 - op_s_value_1 <= 0) ? 1 : 0) :  // gt
							0;	
		
		assign write_back = (op_mode_1 == 8'b11111111) ? 0 : 
						 ((pred_control == 1) ? ((pred[0] == 1) ? 1 : 0) : 1);
		
		assign write_back_p = (op_mode_1 == 8'b11111111) ? 0 :
						 ((op_mode_1[5] == 1) ? 1 : 0); //cmp
	 
/* useless

	ld_c2
	ld_i
	ld_uc
	ld_uc2

	mov
	
	st_c
	st_c2
	st_i
*/

/*unknown
rcmp
sxt_c
sxt_c2
xor
zxt_c
zxt_c2
*/

/* queue


*/
	
endmodule
