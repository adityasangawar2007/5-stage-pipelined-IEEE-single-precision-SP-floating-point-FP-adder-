//*****************************
//Pipelined Adder in Verilog
//*****************************
`timescale 10ns/1ns
module PipelineAdder(s1_9637,s2_9637,e1_9637,e2_9637,e3_9637,mantissa1_9637,mantissa2_9637, m3_9637,clk,reset);

input s1_9637,s2_9637;
reg s1_9637_reg, s2_9637_reg, s1_9637_reg_stage1_9637,s1_9637_reg_stage2_9637,s1_9637_reg_stage3_9637,s1_9637_reg_stage4, s2_9637_reg_stage1_9637, s2_9637_reg_stage2_9637,s2_9637_reg_stage3_9637,s2_9637_reg_stage4;
input [7:0] e1_9637,e2_9637;
reg [7:0] e1_9637_reg, e2_9637_reg, e_same, e1_9637_stage1_9637, e1_9637_stage2_9637, e1_9637_stage3_9637, e1_9637_stage4, e2_9637_stage4, e2_9637_stage1_9637, e2_9637_stage2_9637, e2_9637_stage3_9637, e2_9637_stage4;
output reg [7:0] e3_9637;
input [22:0] mantissa1_9637, mantissa2_9637;
reg [23:0] m1,m2, m1_stage1_9637, m2_stage1_9637;
reg [23:0] m4, m1_2comp, m2_2comp, m1_shift, m2_shift, m1_reg, m2_reg, m2_2comp_m2_shift, m1_2comp_m1, m2_2comp_m2, m1_2comp_m1_shift ; //24th bit is carry used for normalization
reg [23:0] m2_2comp_m2_shift, m1_no_shift, m2_no_shift;
reg [23:0] m1_stage3_9637;
reg [23:0] m2_stage3_9637;
reg [23:0] m2_shift_stage3_9637;
reg [23:0] m1_2comp_m1;
reg [23:0] m2_shift_stage3_9637;
reg [23:0] m1_less_stage3_9637;
reg [23:0] m2_shift_less_stage3_9637;
reg [23:0] m2_shift_less_stage3_9637;
reg [23:0] m1_shift_less_stage3_9637;
reg [23:0] m1_shiftmore_stage3_9637;
reg [23:0] m2_less_stage3_9637;
reg [23:0]	m1_no_shift_stage3_9637;
reg [23:0]	m1_no_shift;
reg [23:0]	m2_no_shift_again;
reg [23:0]	m2_no_shift;
reg [23:0]	m2_no_shift_stage3_9637;
reg [23:0]	m2_no_shift;
reg [23:0]	m1_no_shift_again;
reg [23:0]	m1_no_shift, m1_no_shift;
reg [23:0]	m1_2comp_m1_no_shift, m2_2comp_m1_no_shift;
reg [23:0]	m1_second_stage,m2_second_stage;

output reg [23:0] m3_9637;
input clk, reset;

//assign m1 = mantissa1_9637|24'b1000_0000_0000_0000_0000_0000;
//assign m2 = mantissa2_9637|24'b1000_0000_0000_0000_0000_0000;






//stage 1 : Compare the exponents - 
always@(posedge clk or negedge reset)
	begin
		if(!reset)
		begin
			s1_9637_reg= 0; s2_9637_reg= 0; e1_9637_reg = 0; e2_9637_reg = 0; m1_reg= 0; m2_reg= 0;
		end
		
		else
		begin
				//m1 <= mantissa1_9637|24'b1000_0000_0000_0000_0000_0000;
				//m2 <= mantissa2_9637|24'b1000_0000_0000_0000_0000_0000;
				
			
			if(e2_9637>e1_9637)
			begin
				m1_stage1_9637 <= mantissa1_9637|24'b1000_0000_0000_0000_0000_0000;
				m2_stage1_9637 <= mantissa2_9637|24'b1000_0000_0000_0000_0000_0000;
				e1_9637_reg <= (e2_9637-e1_9637);
				s1_9637_reg_stage1_9637<= s1_9637;
				s2_9637_reg_stage1_9637<= s2_9637;
				e1_9637_stage1_9637<= e1_9637;
				e2_9637_stage1_9637<= e2_9637;
				
			end
			
			else
			begin
				m1 <= mantissa1_9637|24'b1000_0000_0000_0000_0000_0000;
				m2 <= mantissa2_9637|24'b1000_0000_0000_0000_0000_0000;
				e1_9637_reg <= (e1_9637-e2_9637);
				s1_9637_reg_stage1_9637<= s1_9637;
				s2_9637_reg_stage1_9637<= s2_9637;
				e1_9637_stage1_9637<= e1_9637;
				e2_9637_stage1_9637<= e2_9637;

			end
			/*
			else if(e1_9637==e2_9637)
				begin
					//e_same = e2_9637 + (e1_9637-e2_9637);
					e_same <= (e1_9637-e2_9637);	//same exponent before normalization
				end
			*/
		end
	end

//stage 2 : Right shift mantissa of smaller exponent -
always@(posedge clk or negedge reset)
	begin
		if(!reset)
		begin
			s1_9637_reg= 0; s2_9637_reg= 0; e1_9637_reg = 0; e2_9637_reg = 0; m1_reg= 0; m2_reg= 0;
		end
		
		else
		begin
			if(e1_9637_reg>0)
			begin													 //##### Example 1 stage 2
				$display("e1_9637_reg=%b", e1_9637_reg);
				m1_shift <= (m1_stage1_9637 >> (e1_9637_reg));
				m2_second_stage <= m2_stage1_9637;
								$display("e2_9637_reg=%b Eg Stage 2 ####@@@@@ start", m2_second_stage);

				s1_9637_reg_stage2_9637 <=s1_9637_reg_stage1_9637;
				s2_9637_reg_stage2_9637 <=s2_9637_reg_stage1_9637;
				e1_9637_stage2_9637<= e1_9637_stage1_9637;
				e2_9637_stage2_9637<= e2_9637_stage1_9637;

				//e3_9637 = e1_9637_reg;
			end
			
			else //if(e2_9637_reg)
			begin
						$display("e2_9637_reg=%b", e2_9637_reg);
				m2_shift <= (m2 >> (e1_9637_reg)) ;
				m1_second_stage <= m1;
				s1_9637_reg_stage2_9637 <=s1_9637_reg_stage1_9637;
				s2_9637_reg_stage2_9637 <=s2_9637_reg_stage1_9637;
				e1_9637_stage2_9637<= e1_9637_stage1_9637;
				e2_9637_stage2_9637<= e2_9637_stage1_9637;


				//e3_9637 = e2_9637_reg;	//x = x<<2;  				
			end
			
			 
			
			/*else 
			begin
			if(e_same)
				begin
					m2_no_shift <= (m2 >> (e1_9637-e2_9637));	 //no shift required
					m1_no_shift <= (m1 >> (e_same));
				end
			end*/
		end
	end	
	
			
//stage 3 : Compare the two aligned mantissas and take 2’s complement of the smaller mantissa if the signs of the two numbers are different (addition) - 
always@(posedge clk or negedge reset)
	begin
		
		if(!reset)
		begin
			s1_9637_reg= 0; s2_9637_reg= 0; e1_9637_reg = 0; e2_9637_reg = 0; m1_reg= 0; m2_reg= 0;
		end
		
		else
		begin
			if(m1_second_stage>m2_shift)
			begin
			
				if(s1_9637_reg_stage2_9637!=s2_9637_reg_stage2_9637)
				begin
				m1_stage3_9637 <= m1_second_stage;
				m2_2comp_m2_shift <= (~m2_shift + 1'b1); //2's compliment of m2
				s1_9637_reg_stage3_9637 <=s1_9637_reg_stage2_9637;
				s2_9637_reg_stage3_9637 <=s2_9637_reg_stage2_9637;
				e1_9637_stage3_9637<= e1_9637_stage2_9637;
				e2_9637_stage3_9637<= e2_9637_stage2_9637;

				end
				
				else
				begin
				m1_stage3_9637 <= m1_second_stage;
				m2_stage3_9637 <= m2_shift;
				s1_9637_reg_stage3_9637 <=s1_9637_reg_stage2_9637;
				s2_9637_reg_stage3_9637 <=s2_9637_reg_stage2_9637;
				e1_9637_stage3_9637<= e1_9637_stage2_9637;
				e2_9637_stage3_9637<= e2_9637_stage2_9637;

				end
			end
			
			else if(m1_second_stage<m2_shift)
			begin
				if(s1_9637_reg_stage2_9637!=s2_9637_reg_stage2_9637)
				begin
				m2_shift_stage3_9637 <= m2_shift;
				m1_2comp_m1 <= (~m1_second_stage + 1'b1); //2's compliment of m1
				s1_9637_reg_stage3_9637 <=s1_9637_reg_stage2_9637;
				s2_9637_reg_stage3_9637 <=s2_9637_reg_stage2_9637;
				e1_9637_stage3_9637<= e1_9637_stage2_9637;
				e2_9637_stage3_9637<= e2_9637_stage2_9637;

				
				end
				
				begin
				m2_shift_stage3_9637 <= m2_shift;
				m1_less_stage3_9637 <= m1_second_stage;
				s1_9637_reg_stage3_9637 <=s1_9637_reg_stage2_9637;
				s2_9637_reg_stage3_9637 <=s2_9637_reg_stage2_9637;
				e1_9637_stage3_9637<= e1_9637_stage2_9637;
				e2_9637_stage3_9637<= e2_9637_stage2_9637;

				
				end
			end
				
			else if(m1_shift>m2_second_stage)
			begin
				if(s1_9637_reg_stage2_9637!=s2_9637_reg_stage2_9637)
				begin
				m1_shiftmore_stage3_9637 <= m1_shift;
				m2_2comp_m2 <= (~m2_second_stage + 1'b1); //2's compliment of m1
				s1_9637_reg_stage3_9637 <=s1_9637_reg_stage2_9637;
				s2_9637_reg_stage3_9637 <=s2_9637_reg_stage2_9637;
				e1_9637_stage3_9637<= e1_9637_stage2_9637;
				e2_9637_stage3_9637<= e2_9637_stage2_9637;

				
				end
				
				begin
				m1_shiftmore_stage3_9637 <= m1_shift;
				m2_less_stage3_9637 <= m2_second_stage;
				s1_9637_reg_stage3_9637 <=s1_9637_reg_stage2_9637;
				s2_9637_reg_stage3_9637 <=s2_9637_reg_stage2_9637;
				e1_9637_stage3_9637<= e1_9637_stage2_9637;
				e2_9637_stage3_9637<= e2_9637_stage2_9637;

				
				end
			end
				
			else if(m1_shift<m2_second_stage)     // ##### Example 3 stage 3 these come in 4th cycle
			begin
				$display("e2_9637_reg=%b Eg Stage 3 ####@@@@@ start", m2_second_stage);
				
				m2_shift_less_stage3_9637 <= m2_second_stage;
				$display("e2_9637_reg=%b Eg Stage 3 start", m2_shift_less_stage3_9637);
				if(s1_9637_reg_stage2_9637!=s2_9637_reg_stage2_9637)
				begin
				m1_2comp_m1_shift <= (~m1_shift + 1'b1); //2's compliment of m1
				$display("e2_9637_reg=%b Eg Stage 3 2's Comp", m2_shift_less_stage3_9637);
				
				s1_9637_reg_stage3_9637 <=s1_9637_reg_stage2_9637;
				s2_9637_reg_stage3_9637 <=s2_9637_reg_stage2_9637;
				e1_9637_stage3_9637<= e1_9637_stage2_9637;
				e2_9637_stage3_9637<= e2_9637_stage2_9637;

				
				end
				
				else
				begin
				//m2_shift_less_stage3_9637 <= m2_second_stage;   //##### Example 1 stage 3
				m1_shift_less_stage3_9637 <= m1_shift;
				s1_9637_reg_stage3_9637 <=s1_9637_reg_stage2_9637;
				s2_9637_reg_stage3_9637 <=s2_9637_reg_stage2_9637;
				e1_9637_stage3_9637<= e1_9637_stage2_9637;
				e2_9637_stage3_9637<= e2_9637_stage2_9637;

				
				end
			end
			
			else if (m2_no_shift > m1_no_shift)
				begin
					if(s1_9637_reg_stage2_9637!=s2_9637_reg_stage2_9637)
					begin
					m2_no_shift_stage3_9637 <= m2_no_shift;
					m1_2comp_m1_no_shift <= (~m1_no_shift + 1'b1); //2's compliment of m1
					s1_9637_reg_stage3_9637 <=s1_9637_reg_stage2_9637;
					s2_9637_reg_stage3_9637 <=s2_9637_reg_stage2_9637;
					e1_9637_stage3_9637<= e1_9637_stage2_9637;
					e2_9637_stage3_9637<= e2_9637_stage2_9637;

				
					end
					
					else
					begin
					m2_no_shift_stage3_9637 <= m2_no_shift;
					m1_no_shift_again <= m1_no_shift;
					s1_9637_reg_stage3_9637 <=s1_9637_reg_stage2_9637;
				    s2_9637_reg_stage3_9637 <=s2_9637_reg_stage2_9637;
					e1_9637_stage3_9637<= e1_9637_stage2_9637;
					e2_9637_stage3_9637<= e2_9637_stage2_9637;

				
					end
				
				end
				
			else if (m2_no_shift < m1_no_shift)
				begin
					if(s1_9637_reg_stage2_9637!=s2_9637_reg_stage2_9637)
					begin
					m1_no_shift_stage3_9637 <= m1_no_shift;
					m2_2comp_m1_no_shift <= (~m2_no_shift + 1'b1); //2's compliment of m1
					s1_9637_reg_stage3_9637 <=s1_9637_reg_stage2_9637;
				    s2_9637_reg_stage3_9637 <=s2_9637_reg_stage2_9637;
					e1_9637_stage3_9637<= e1_9637_stage2_9637;
					e2_9637_stage3_9637<= e2_9637_stage2_9637;

				
					end
					
					else
					begin
					m1_no_shift_stage3_9637 <= m1_no_shift;
					m2_no_shift_again <= m2_no_shift;
					s1_9637_reg_stage3_9637 <=s1_9637_reg_stage2_9637;
				    s2_9637_reg_stage3_9637 <=s2_9637_reg_stage2_9637;
					e1_9637_stage3_9637<= e1_9637_stage2_9637;
					e2_9637_stage3_9637<= e2_9637_stage2_9637;

				
					end
				
				end	

		end			
	end
	
	
//stage 4 : Add the two mantissas. Then, determine the amount of shifts required and the corresponding direction to normalize the result (normalization-1).
always@(posedge clk or negedge reset)
	begin
			
		if(!reset)
		begin
			s1_9637_reg= 0; s2_9637_reg= 0; e1_9637_reg = 0; e2_9637_reg = 0; m1_reg= 0; m2_reg= 0;
		end
		
		else
		begin		
			if(m2_2comp_m2_shift)
				begin
					m3_9637 <= m1+ m2_2comp_m2_shift;
					s1_9637_reg_stage4 <=s1_9637_reg_stage3_9637;
				    s2_9637_reg_stage4 <=s2_9637_reg_stage3_9637;
					e1_9637_stage4<= e1_9637_stage3_9637;
					e2_9637_stage4<= e2_9637_stage3_9637;

				end
				
			else if(m1_2comp_m1)
				begin
					m3_9637 <= m2_shift_stage3_9637 + m1_2comp_m1;
					s1_9637_reg_stage4 <=s1_9637_reg_stage3_9637;
				    s2_9637_reg_stage4 <=s2_9637_reg_stage3_9637;
					e1_9637_stage4<= e1_9637_stage3_9637;
					e2_9637_stage4<= e2_9637_stage3_9637;

				end
				
			else if(m2_2comp_m2)
				begin
					m3_9637 <= m1_shift+m2_2comp_m2; 
					e3_9637 <= e1_9637;
					s1_9637_reg_stage4 <=s1_9637_reg_stage3_9637;
				    s2_9637_reg_stage4 <=s2_9637_reg_stage3_9637;
					e1_9637_stage4<= e1_9637_stage3_9637;
					e2_9637_stage4<= e2_9637_stage3_9637;

				end
				
			else if(m1_2comp_m1_shift)
				begin
					m3_9637 <= m1_2comp_m1_shift+m2; 
					s1_9637_reg_stage4 <=s1_9637_reg_stage3_9637;
				    s2_9637_reg_stage4 <=s2_9637_reg_stage3_9637;
					e1_9637_stage4<= e1_9637_stage3_9637;
					e2_9637_stage4<= e2_9637_stage3_9637;

				end

				
			else if(m1_shift_less_stage3_9637)
				begin
					m3_9637 <= m2_shift_less_stage3_9637+m1_shift_less_stage3_9637; 
					s1_9637_reg_stage4 <=s1_9637_reg_stage3_9637;
				    s2_9637_reg_stage4 <=s2_9637_reg_stage3_9637;
					e1_9637_stage4<= e1_9637_stage3_9637;
					e2_9637_stage4<= e2_9637_stage3_9637;

				end
				
			else if (m1_2comp_m1_no_shift)
				begin
					m3_9637 <= m2_no_shift_stage3_9637 + m1_2comp_m1_no_shift; 
					
					s1_9637_reg_stage4 <=s1_9637_reg_stage3_9637;
				    s2_9637_reg_stage4 <=s2_9637_reg_stage3_9637;
					e1_9637_stage4<= e1_9637_stage3_9637;
					e2_9637_stage4<= e2_9637_stage3_9637;

				end
				
			else if (m2_2comp_m1_no_shift)
				begin
					m3_9637 <= m1_no_shift_stage3_9637 + m2_2comp_m1_no_shift; 					
					s1_9637_reg_stage4 <=s1_9637_reg_stage3_9637;
				    s2_9637_reg_stage4 <=s2_9637_reg_stage3_9637;
					e1_9637_stage4<= e1_9637_stage3_9637;
					e2_9637_stage4<= e2_9637_stage3_9637;

				end
								

		end
	end			
endmodule




//*************** TestBench Carry Select Adder *************************************************

module PipelineAdderTB();

reg s1_9637,s2_9637;
reg [7:0] e1_9637,e2_9637;
wire [7:0] e3_9637;
reg [22:0] mantissa1_9637,mantissa2_9637;
wire [23:0] m3_9637;
reg clk=1'b1, reset;

always #1 clk=~clk;

PipelineAdder inst1(s1_9637,s2_9637,e1_9637,e2_9637,e3_9637,mantissa1_9637,mantissa2_9637,m3_9637,clk,reset);

initial begin
	$dumpfile ("AdderIEEE.vcd");
	$dumpvars (0);
//$monitor("m1=%b, m2=%b, e1_9637=%b, e2_9637=%b , m3_9637=%b , e3_9637=%b, reset=%b", mantissa1_9637, mantissa2_9637, e1_9637, e2_9637, m3_9637, e3_9637, reset);
  
	s1_9637 = 1'b0;	e1_9637 = 8'b1000_0101;	mantissa1_9637 = 23'b1000_1000_0000_0000_0000_000;	reset = 1'b1; //98
	s2_9637 = 1'b0;	e2_9637 = 8'b1000_0110;	mantissa2_9637 = 23'b0101_0010_0000_0000_0000_000;	reset = 1'b1; //169
	#2;

	s1_9637 = 1'b0;	e1_9637 = 8'b1000_0101;	mantissa1_9637 = 23'b1000_1100_0000_0000_0000_000;	reset = 1'b1; //99
	s2_9637 = 1'b1;	e2_9637 = 8'b1000_0101;	mantissa2_9637 = 23'b0110_0100_0000_0000_0000_000;	reset = 1'b1; //-89
	#2;
 	
 	s1_9637 = 1'b1;	e1_9637 = 8'b1000_0100;	mantissa1_9637 = 23'b0110_1000_0000_0000_0000_000;	reset = 1'b1; //-45
	s2_9637 = 1'b0;	e2_9637 = 8'b1000_0101;	mantissa2_9637 = 23'b0011_1100_0000_0000_0000_000;	reset = 1'b1; //79
	#2;
	
	s1_9637 = 1'b1;	e1_9637 = 8'b1000_0111;	mantissa1_9637 = 23'b0001_1011_0000_0000_0000_000;	reset = 1'b1; //-283
	s2_9637 = 1'b1;	e2_9637 = 8'b1000_0101;	mantissa2_9637 = 23'b0000_1000_0000_0000_0000_000;	reset = 1'b1; //-66
	#2;

	s1_9637 = 1'b0;	e1_9637 = 8'b0000_0000;	mantissa1_9637 = 23'b0000_0000_0000_0000_0000_000;	reset = 1'b1; //0
	s2_9637 = 1'b0;	e2_9637 = 8'b0000_0000;	mantissa2_9637 = 23'b0000_0000_0000_0000_0000_000;	reset = 1'b1; //0
	#2;

	s1_9637 = 1'b0;	e1_9637 = 8'b0000_0000;	mantissa1_9637 = 23'b0000_0000_0000_0000_0000_000;	reset = 1'b1; //0
	s2_9637 = 1'b1;	e2_9637 = 8'b1000_0101;	mantissa2_9637 = 23'b1101_0100_0000_0000_0000_000;	reset = 1'b1; //-117
	#2;
	
	s1_9637 = 1'b1;	e1_9637 = 8'b1000_0101;	mantissa1_9637 = 23'b1011_1000_1000_0000_0000_000;	reset = 1'b1; //-110.125
	s2_9637 = 1'b0;	e2_9637 = 8'b1000_0101;	mantissa2_9637 = 23'b1000_1111_1000_0000_0000_000;	reset = 1'b1; //99.875
	#2;

	s1_9637 = 1'b0;	e1_9637 = 8'b1000_0101;	mantissa1_9637 = 23'b1011_1011_1000_0000_0000_000;	reset = 1'b1; //110.875
	s2_9637 = 1'b0;	e2_9637 = 8'b1000_0101;	mantissa2_9637 = 23'b1000_1100_1000_0000_0000_000;	reset = 1'b1; //99.125
	#2;
	
	s1_9637 = 1'b0;	e1_9637 = 8'b1000_0101;	mantissa1_9637 = 23'b1011_1011_1000_0000_0000_000;	reset = 1'b1; //110.875
	s2_9637 = 1'b0;	e2_9637 = 8'b1000_0101;	mantissa2_9637 = 23'b1000_1100_1000_0000_0000_000;	reset = 1'b1; //99.125
	#2;
	
	s1_9637 = 1'b0;	e1_9637 = 8'b1000_0101;	mantissa1_9637 = 23'b1011_1011_1000_0000_0000_000;	reset = 1'b1; //110.875
	s2_9637 = 1'b0;	e2_9637 = 8'b1000_0101;	mantissa2_9637 = 23'b1000_1100_1000_0000_0000_000;	reset = 1'b1; //99.125
	#12;
	

 $finish();	
end

endmodule


