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
	 input CLK, write_back, ld_write, ld; //在FU中計算完結果後，若有pred控制時是否不要write_back 
	 input [31:0] out2reg;//out2reg是FU算出來的結果，由write_back控制是否要write_back
	 input [8:0] control_in, control_out;//控制由哪個edge,bus將資料傳進reg
	 //control_out決定送出去的資料要送去哪
	 input [5:0] control_reg_1, control_reg_2, control_put_in, control_put_out, control_send;
	 //control_reg為控制這個clock時要將哪些reg裡的資料送去給FU運算
	 //control_put_in為剛剛從別的PE送進來的資料要放哪個reg
	 //control_put_out為從FU算完的資料若有writeback時要存到哪個reg中
	 //control_send決定要將哪一個reg中的資料送出去
	 input [3:0] control_pe2fu_1, control_pe2fu_2;
	 //control_pe2fu決定是否要直接將別的PE傳來的資料送去給FU;
	 
	 output [31:0] reg_out1, reg_out2 ;//reg_out代表要送去給FU運算的資料, 
	 //demux_out為決定要送出去給其他PE的資料
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
					//別人送進來的寫入
					if(ld == 0 )reg_file[control_put_in] <= mux2reg;
					else
						if(ld_write == 1) reg_file[control_put_in] <= mux2reg;
						else reg_file[control_put_in] <= reg_file[control_put_in]; 
					
					//FU算完寫完來的
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
