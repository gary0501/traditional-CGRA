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
	
	//目前reg有64個[63:0]，如果這個clk沒有要放東西進去的話，訊號就送到最後一個reg吧 
	
	//control_in代表Reg上面那個mux要選擇將哪個edge or bus的資料送進來
		//九個bit中最右邊的代表right，右邊數來第二位代表down，第三位是left，第四位是up，第五位是bus
		//舉例：要將這個PE下面的edge資料送進來的話，訊號要送9'b000000010，雖然標準這樣訂，但在control_in這邊不能一次輸入多個(不能出現兩個以上的1)
	//control_out代表Reg下面的mux要選擇將資料送出去給哪個edge or bus
		//同上面的標準，可以用組合的，就會有多個輸出
		//舉例：同時要送資料給下面跟上面的edge，訊號送：9'b000001010
	 //control_put_in為剛剛從別的PE送進來的資料要放哪個reg,如果這個cycle沒有指定的話,就放到最後一格
	 //control_put_out為從FU算完的資料若有writeback時要存到哪個reg中
	 //control_reg為控制這個clock時要將哪些reg裡的資料送去給FU運算
	 //control_send決定要將哪一個reg中的資料送出去別的PE
	 //control_pe2fu決定是否要直接將別的PE傳來的資料送去給FU;
		//right=4'd1, down=4'd2, left=4'd3, up=4'd4, bus=4'd8 (這裡跟上面那種看第幾個bit的模式不同，是要看代表的數字)
		//訊號如果送0代表給FU的資料從reg中抓，此時就是看control_reg的訊號決定送什麼去給FU；
		//反言之若control_pe2fu不是0的時候control_reg就沒有作用了	 
	 //ld代表這個指令是不是load指令

	//----------------- Pred_reg -------------------  46bits
	output [8:0] control_in_p, control_out_p;
	output [5:0] control_put_in_p, control_put_out_p, control_pred, control_send_p;
	output [3:0] control_pe2fu_p; //2013.9.2 new_add
	//-------------------------------------------
	
	//reg數量同上面的63個，一樣也是若是沒做事就放最後一個吧
	
	//control_in_p代表pred_reg上面那個mux要選擇將哪個edge or bus的資料送進來
			//跟上面reg的部分相同
	//control_out_p代表pred下面的mux要選擇將資料送出去給哪個edge or bus
			//跟上面reg的部分相同
	 //control_put_in_p為剛剛從別的PE送進來的pred要放哪個pred_reg_file,如果這個cycle沒有指定的話,就放到最後一格
	 //control_put_out_p為從FU算完的資料若是CMP之類的會產生pred時，有writeback時要存到哪個pred_reg_file中
	 //control_pred為控制這個clock時要將哪些reg裡的資料送去給FU當pred
	 //control_send_p決定要將哪一個reg中的pred送出去別的PE
	 //control_pe2fu_p決定是否要直接將別的PE傳來的pred送去給FU;
			//right=4'd1, down=4'd2, left=4'd3, up=4'd4, bus=4'd8
			//同上面reg的部分
	//------------------- FU ----------------18bits
	output pred_control;
	output [7:0] op_mode_1;
	output imm;
	output [7:0] imm_val;
	//------------------------------------
	// pred_control每個operation時都要送1或0給FU，決定這個OP有沒有需要看pred，0代表不用看pred
	//op_mode 就是op_code啦
	//imm 表示這個OP的運算是否有immidiate值
	//imm_val 代表這個OP的immidiate值
	/*
		(op_mode_1 == 8'b00000000) 	//add, add_u
		(op_mode_1 == 8'b00000001)    //and
		(op_mode_1 == 8'b00000010) 	//asr
		(op_mode_1 == 8'b00000100) 	//div 會噴can not simplify operator DIV
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
	Buffer就是你要把input_data分別送到各個地方啦
	*/
	

endmodule
