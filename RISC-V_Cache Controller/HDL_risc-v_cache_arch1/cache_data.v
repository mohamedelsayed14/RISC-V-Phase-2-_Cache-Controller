//cache data
module cache_data (input   clk, c_we,
                  input   [6:0] c_r_addrs,c_w_addrs,
				  input   [31:0] c_wd,
                  output  [31:0] c_rd);

reg [31:0] RAM [0:127];  //memory size = 512_byte
 
//write operation
always@(negedge clk)
begin
		if (c_we) 
		  begin 
		   RAM[c_w_addrs] <= c_wd;
		  end
end
//read opertaion	 
	 assign c_rd = RAM[c_r_addrs];
endmodule 