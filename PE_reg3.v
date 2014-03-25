`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    03:05:50 01/12/2014 
// Design Name: 
// Module Name:    PE_reg3 
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
module PE_reg3(	
		edge2_in, edge5_in , bus_in, 
		edge2_out, edge5_out , bus_out , 
		write_back, control_in, control_put_in, out2reg, control_put_out, 
		control_reg_1, control_reg_2, reg_out1, reg_out2, CLK, 
		control_out, control_send, control_pe2fu_1, control_pe2fu_2, ld, ld_write
    );
	 input CLK, write_back, ld_write, ld; //�bFU���p�⧹���G��A�Y��pred����ɬO�_���nwrite_back 
	 input [31:0] out2reg;//out2reg�OFU��X�Ӫ����G�A��write_back����O�_�nwrite_back
	 input [8:0] control_in, control_out;//����ѭ���edge,bus�N��ƶǶireg
	 //control_out�M�w�e�X�h����ƭn�e�h��
	 input [5:0] control_reg_1, control_reg_2, control_put_in, control_put_out, control_send;
	 //control_reg������o��clock�ɭn�N����reg�̪���ưe�h��FU�B��
	 //control_put_in�����q�O��PE�e�i�Ӫ���ƭn�����reg
	 //control_put_out���qFU�⧹����ƭY��writeback�ɭn�s�����reg��
	 //control_send�M�w�n�N���@��reg������ưe�X�h
	 input [3:0] control_pe2fu_1, control_pe2fu_2;
	 //control_pe2fu�M�w�O�_�n�����N�O��PE�ǨӪ���ưe�h��FU;
	 
	 output [31:0] reg_out1, reg_out2 ;//reg_out�N��n�e�h��FU�B�⪺���, 
	 //demux_out���M�w�n�e�X�h����LPE�����
	 //reg [31:0] reg_out1, reg_out2 ;
	 
	 input [31:0] edge2_in, edge5_in, bus_in;
	 output [31:0] edge2_out, edge5_out, bus_out;
	 
	 reg [31:0] reg_file [63:0];
	 wire [31:0] mux2reg, demux_out;

	 //////////// MUX
	 assign mux2reg = (control_in == 9'b000000100 )? edge2_in :
							(control_in == 9'b000000010 )? edge5_in :
							(control_in == 9'b000010000 )? bus_in	: 0;
	///////////////////////////////////////////////////////	
	
	assign reg_out1 = (control_pe2fu_1 == 4'b0011)? edge2_in:
							(control_pe2fu_1 == 4'b0010)? edge5_in:
							(control_pe2fu_1 == 4'b1000)? bus_in : 
							(control_pe2fu_1 == 4'b0000)? reg_file [control_reg_1] : 0;
	
	assign reg_out2 = (control_pe2fu_2 == 4'b0011)? edge2_in:
							(control_pe2fu_2 == 4'b0010)? edge5_in:
							(control_pe2fu_2 == 4'b1000)? bus_in : 
							(control_pe2fu_2 == 4'b0000)? reg_file [control_reg_2] : 0;
	
	always @ (negedge CLK)
	begin
					//�O�H�e�i�Ӫ��g�J
					if(ld == 0 )reg_file[control_put_in] <= mux2reg;
					else
						if(ld_write == 1) reg_file[control_put_in] <= mux2reg;
						else reg_file[control_put_in] <= reg_file[control_put_in]; 
					
					//FU�⧹�g���Ӫ�
					if(write_back == 1'b1)
					reg_file[control_put_out] <=  out2reg;
					else
					reg_file[control_put_out] <= reg_file[control_put_out];
	end
	
	
	assign demux_out = reg_file[control_send];
	/////// DEMUX////////////////////
	assign edge2_out = (control_out[2] == 1 )? demux_out : 0;
	assign edge5_out = (control_out[1] == 1 )? demux_out : 0;
	assign bus_out = (control_out[4] == 1 )? demux_out : 0;
	
	//////////////////////////////////////////////////////////////////////
	
	
	

endmodule
