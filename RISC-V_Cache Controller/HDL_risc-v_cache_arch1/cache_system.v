//cache system
module 		cache_system  ( input   clk, reset, we, re,
						    output  stall,
							input   [31:0] byte_address,
							input   [31:0] wd,
							output  [31:0] rd);
wire [31:0] word_address;
wire hit;
wire [1:0]word_num, word_offset;
wire cache_we, dm_we, dm_re, ready;
wire [35:0]	cache_wd, cache_rd;				
wire [31:0] dm_wd, dm_rd_2cache;
wire sel_cache_din, new_valid;



assign word_address={2'b00,byte_address[31:2]};


assign word_num=  sel_cache_din   ? word_address[1:0] : word_offset;
assign cache_wd[31:0]=sel_cache_din? wd : dm_rd_2cache;
assign cache_wd[35:32]={new_valid,word_address[9:7]};

assign rd=cache_rd[31:0];
assign hit = cache_rd[35] & (word_address[9:7] == cache_rd[34:32]);

cache_mem cache_mem (reset, clk, cache_we, word_address[6:0],{word_address[6:2],word_num}, cache_wd, cache_rd);

data_mem data_mem (reset, clk, dm_we, dm_re, ready, word_address[9:0], wd, dm_rd_2cache, word_offset);    

cache_controller  cache_controller (clk, reset, we, re, ready, hit, cache_we, dm_we, dm_re, sel_cache_din, stall, new_valid);
				  				  
endmodule 