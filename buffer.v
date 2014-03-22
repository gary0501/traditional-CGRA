`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    16:01:47 04/30/2013 
// Design Name: 
// Module Name:    buffer 
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
module buffer( CLK, data_in, control_in, control_put_in, control_put_out, control_reg_1, control_reg_2,
					control_out, control_send, control_in_p, control_put_in_p, control_put_out_p, control_pred,
					control_out_p, control_send_p, pred_control, op_mode_1, imm, imm_val,
					control_pe2fu_1, control_pe2fu_2, control_pe2fu_p, ld );
	parameter width = 120;
	input CLK;
	input [width:0] data_in;
	
	
	//------------  Reg ----------------  57bits
	output [8:0] control_in, control_out;
	output [5:0] control_put_in, control_put_out, control_reg_1, control_reg_2, control_send;
	output [3:0] control_pe2fu_1, control_pe2fu_2; //2013.9.2 new_add
	output ld;
	//--------------------------------------
	
	//�ثereg��64��[63:0]�A�p�G�o��clk�S���n��F��i�h���ܡA�T���N�e��̫�@��reg�a 
	
	//control_in�N��Reg�W������mux�n��ܱN����edge or bus����ưe�i��
		//�E��bit���̥k�䪺�N��right�A�k��ƨӲĤG��N��down�A�ĤT��Oleft�A�ĥ|��Oup�A�Ĥ���Obus
		//�|�ҡG�n�N�o��PE�U����edge��ưe�i�Ӫ��ܡA�T���n�e9'b000000010�A���M�зǳo�˭q�A���bcontrol_in�o�䤣��@����J�h��(����X�{��ӥH�W��1)
	//control_out�N��Reg�U����mux�n��ܱN��ưe�X�h������edge or bus
		//�P�W�����зǡA�i�H�βզX���A�N�|���h�ӿ�X
		//�|�ҡG�P�ɭn�e��Ƶ��U����W����edge�A�T���e�G9'b000001010
	 //control_put_in�����q�O��PE�e�i�Ӫ���ƭn�����reg,�p�G�o��cycle�S�����w����,�N���̫�@��
	 //control_put_out���qFU�⧹����ƭY��writeback�ɭn�s�����reg��
	 //control_reg������o��clock�ɭn�N����reg�̪���ưe�h��FU�B��
	 //control_send�M�w�n�N���@��reg������ưe�X�h�O��PE
	 //control_pe2fu�M�w�O�_�n�����N�O��PE�ǨӪ���ưe�h��FU;
		//right=4'd1, down=4'd2, left=4'd3, up=4'd4, bus=4'd8 (�o�̸�W�����جݲĴX��bit���Ҧ����P�A�O�n�ݥN���Ʀr)
		//�T���p�G�e0�N��FU����Ʊqreg����A���ɴN�O��control_reg���T���M�w�e����h��FU�F
		//�Ϩ����Ycontrol_pe2fu���O0���ɭ�control_reg�N�S���@�ΤF	 
	 //ld�N��o�ӫ��O�O���Oload���O

	//----------------- Pred_reg -------------------  46bits
	output [8:0] control_in_p, control_out_p;
	output [5:0] control_put_in_p, control_put_out_p, control_pred, control_send_p;
	output [3:0] control_pe2fu_p; //2013.9.2 new_add
	//-------------------------------------------
	
	//reg�ƶq�P�W����63�ӡA�@�ˤ]�O�Y�O�S���ƴN��̫�@�ӧa
	
	//control_in_p�N��pred_reg�W������mux�n��ܱN����edge or bus����ưe�i��
			//��W��reg�������ۦP
	//control_out_p�N��pred�U����mux�n��ܱN��ưe�X�h������edge or bus
			//��W��reg�������ۦP
	 //control_put_in_p�����q�O��PE�e�i�Ӫ�pred�n�����pred_reg_file,�p�G�o��cycle�S�����w����,�N���̫�@��
	 //control_put_out_p���qFU�⧹����ƭY�OCMP�������|����pred�ɡA��writeback�ɭn�s�����pred_reg_file��
	 //control_pred������o��clock�ɭn�N����reg�̪���ưe�h��FU��pred
	 //control_send_p�M�w�n�N���@��reg����pred�e�X�h�O��PE
	 //control_pe2fu_p�M�w�O�_�n�����N�O��PE�ǨӪ�pred�e�h��FU;
			//right=4'd1, down=4'd2, left=4'd3, up=4'd4, bus=4'd8
			//�P�W��reg������
	//------------------- FU ----------------18bits
	output pred_control;
	output [7:0] op_mode_1;
	output imm;
	output [7:0] imm_val;
	//------------------------------------
	// pred_control�C��operation�ɳ��n�e1��0��FU�A�M�w�o��OP���S���ݭn��pred�A0�N���ά�pred
	//op_mode �N�Oop_code��
	//imm ��ܳo��OP���B��O�_��immidiate��
	//imm_val �N��o��OP��immidiate��
	/*
		(op_mode_1 == 8'b00000000) 	//add, add_u
		(op_mode_1 == 8'b00000001)    //and
		(op_mode_1 == 8'b00000010) 	//asr
		(op_mode_1 == 8'b00000100) 	//div �|�Qcan not simplify operator DIV
		(op_mode_1 == 8'b00000101) 	//lsl
		(op_mode_1 == 8'b00000110) 	//lsr
		(op_mode_1 == 8'b00000111) 	//mul
		(op_mode_1 == 8'b00001000) 	//or
		(op_mode_1 == 8'b00001001) 	//sub
		(op_mode_1 == 8'b00001010)    //xor
		(op_mode_1 == 8'b00000011) 	//cmp
	*/
	///////////////////////
	assign control_in = data_in[8:0];                 //9
	assign control_out = data_in[17:9];               //9
	assign control_put_in = data_in[23:18];           //6
	assign control_put_out = data_in[29:24];          //6
	assign control_reg_1 = data_in[35:30];            //6
	assign control_reg_2 = data_in[41:36];            //6
	assign control_send = data_in[47:42];             //6
	assign control_pe2fu_1 = data_in[51:48];          //4
	assign control_pe2fu_2 = data_in[55:52];          //4
	assign ld = data_in[56];                          //1
	                                                  //
	assign control_in_p = data_in[65:57];             //9
	assign control_out_p = data_in[74:66];            //9
	assign control_put_in_p = data_in[80:75];         //6
	assign control_put_out_p = data_in[86:81];        //6
	assign control_pred = data_in[92:87];             //6
	assign control_send_p = data_in[98:93];           //6
	assign control_pe2fu_p = data_in[102:99];         //4
	                                                  //
	assign pred_control = data_in[103];               //1
	assign op_mode_1 = data_in[111:104];              //8
	assign imm = data_in[112];                        //1
	assign imm_val = data_in[120:113];                //8
	

	
	
	
	/*
	Buffer�N�O�A�n��input_data���O�e��U�Ӧa���
	*/
	

endmodule
