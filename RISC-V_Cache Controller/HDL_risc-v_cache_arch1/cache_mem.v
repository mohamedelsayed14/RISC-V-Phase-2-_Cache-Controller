//cache memory
module cache_mem (input  reset, clk, cache_we,
                 input   [6:0] cache_r_addrs,cache_w_addrs,
			  	 input   [35:0] cache_wd,
                 output  [35:0] cache_rd);


v_mem valied (reset, clk, cache_we, cache_r_addrs[6:2], cache_wd[35], cache_rd[35]);

tag_mem tag     (clk, cache_we, cache_r_addrs[6:2], cache_wd[34:32], cache_rd[34:32]);
				  
cache_data data   (clk, cache_we, cache_r_addrs[6:0], cache_w_addrs[6:0], cache_wd[31:0], cache_rd[31:0]);					  
					  
					  
endmodule 