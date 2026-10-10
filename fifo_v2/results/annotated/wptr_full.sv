//      // verilator_coverage annotation
        module wptr_full 
            #(
                parameter p_addr_width = 16  // Parameter to define the address width of the FIFO
            )(
 474361         input  wire                     i_wr_clk,         // Write clock
+474361  point: type=toggle comment=i_wr_clk:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+474360  point: type=toggle comment=i_wr_clk:1->0 hier=tb_async_fifo.dut.wptr_full_inst
 000012         input  wire                     i_wr_rst_n,       // Write reset (active low)
+000012  point: type=toggle comment=i_wr_rst_n:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000011  point: type=toggle comment=i_wr_rst_n:1->0 hier=tb_async_fifo.dut.wptr_full_inst
 000015         input  wire                     i_wr_en,          // Write enable signal
+000015  point: type=toggle comment=i_wr_en:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000015  point: type=toggle comment=i_wr_en:1->0 hier=tb_async_fifo.dut.wptr_full_inst
 049440         input  wire [p_addr_width  :0]  i_rd_ptr_sync,    // Synchronized read pointer from the read clock domain
+049440  point: type=toggle comment=i_rd_ptr_sync[0]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+049440  point: type=toggle comment=i_rd_ptr_sync[0]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000048  point: type=toggle comment=i_rd_ptr_sync[10]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000048  point: type=toggle comment=i_rd_ptr_sync[10]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000024  point: type=toggle comment=i_rd_ptr_sync[11]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000024  point: type=toggle comment=i_rd_ptr_sync[11]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000012  point: type=toggle comment=i_rd_ptr_sync[12]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000012  point: type=toggle comment=i_rd_ptr_sync[12]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000006  point: type=toggle comment=i_rd_ptr_sync[13]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000006  point: type=toggle comment=i_rd_ptr_sync[13]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000003  point: type=toggle comment=i_rd_ptr_sync[14]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000003  point: type=toggle comment=i_rd_ptr_sync[14]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000003  point: type=toggle comment=i_rd_ptr_sync[15]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000003  point: type=toggle comment=i_rd_ptr_sync[15]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000003  point: type=toggle comment=i_rd_ptr_sync[16]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000003  point: type=toggle comment=i_rd_ptr_sync[16]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+024721  point: type=toggle comment=i_rd_ptr_sync[1]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+024720  point: type=toggle comment=i_rd_ptr_sync[1]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+012359  point: type=toggle comment=i_rd_ptr_sync[2]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+012359  point: type=toggle comment=i_rd_ptr_sync[2]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+006180  point: type=toggle comment=i_rd_ptr_sync[3]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+006180  point: type=toggle comment=i_rd_ptr_sync[3]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+003091  point: type=toggle comment=i_rd_ptr_sync[4]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+003090  point: type=toggle comment=i_rd_ptr_sync[4]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+001545  point: type=toggle comment=i_rd_ptr_sync[5]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+001545  point: type=toggle comment=i_rd_ptr_sync[5]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000773  point: type=toggle comment=i_rd_ptr_sync[6]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000772  point: type=toggle comment=i_rd_ptr_sync[6]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000386  point: type=toggle comment=i_rd_ptr_sync[7]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000386  point: type=toggle comment=i_rd_ptr_sync[7]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000193  point: type=toggle comment=i_rd_ptr_sync[8]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000193  point: type=toggle comment=i_rd_ptr_sync[8]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000097  point: type=toggle comment=i_rd_ptr_sync[9]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000097  point: type=toggle comment=i_rd_ptr_sync[9]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
 000003         output reg                      o_fifo_full,      // Output flag indicating if the FIFO is full
+000003  point: type=toggle comment=o_fifo_full:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000003  point: type=toggle comment=o_fifo_full:1->0 hier=tb_async_fifo.dut.wptr_full_inst
 098879         output wire [p_addr_width-1:0]  o_wr_bin_addr,    // Output binary write address
+098879  point: type=toggle comment=o_wr_bin_addr[0]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+098879  point: type=toggle comment=o_wr_bin_addr[0]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000096  point: type=toggle comment=o_wr_bin_addr[10]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000096  point: type=toggle comment=o_wr_bin_addr[10]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000048  point: type=toggle comment=o_wr_bin_addr[11]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000048  point: type=toggle comment=o_wr_bin_addr[11]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000024  point: type=toggle comment=o_wr_bin_addr[12]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000024  point: type=toggle comment=o_wr_bin_addr[12]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000012  point: type=toggle comment=o_wr_bin_addr[13]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000012  point: type=toggle comment=o_wr_bin_addr[13]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000006  point: type=toggle comment=o_wr_bin_addr[14]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000006  point: type=toggle comment=o_wr_bin_addr[14]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000003  point: type=toggle comment=o_wr_bin_addr[15]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000003  point: type=toggle comment=o_wr_bin_addr[15]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+049438  point: type=toggle comment=o_wr_bin_addr[1]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+049438  point: type=toggle comment=o_wr_bin_addr[1]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+024719  point: type=toggle comment=o_wr_bin_addr[2]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+024718  point: type=toggle comment=o_wr_bin_addr[2]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+012359  point: type=toggle comment=o_wr_bin_addr[3]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+012359  point: type=toggle comment=o_wr_bin_addr[3]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+006179  point: type=toggle comment=o_wr_bin_addr[4]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+006179  point: type=toggle comment=o_wr_bin_addr[4]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+003090  point: type=toggle comment=o_wr_bin_addr[5]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+003089  point: type=toggle comment=o_wr_bin_addr[5]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+001545  point: type=toggle comment=o_wr_bin_addr[6]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+001544  point: type=toggle comment=o_wr_bin_addr[6]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000772  point: type=toggle comment=o_wr_bin_addr[7]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000772  point: type=toggle comment=o_wr_bin_addr[7]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000386  point: type=toggle comment=o_wr_bin_addr[8]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000386  point: type=toggle comment=o_wr_bin_addr[8]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000193  point: type=toggle comment=o_wr_bin_addr[9]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000193  point: type=toggle comment=o_wr_bin_addr[9]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
 049442         output reg  [p_addr_width  :0]  o_wr_grey_addr    // Output Gray-coded write address
+049442  point: type=toggle comment=o_wr_grey_addr[0]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+049442  point: type=toggle comment=o_wr_grey_addr[0]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000048  point: type=toggle comment=o_wr_grey_addr[10]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000048  point: type=toggle comment=o_wr_grey_addr[10]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000024  point: type=toggle comment=o_wr_grey_addr[11]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000024  point: type=toggle comment=o_wr_grey_addr[11]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000012  point: type=toggle comment=o_wr_grey_addr[12]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000012  point: type=toggle comment=o_wr_grey_addr[12]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000006  point: type=toggle comment=o_wr_grey_addr[13]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000006  point: type=toggle comment=o_wr_grey_addr[13]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000003  point: type=toggle comment=o_wr_grey_addr[14]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000003  point: type=toggle comment=o_wr_grey_addr[14]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000003  point: type=toggle comment=o_wr_grey_addr[15]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000003  point: type=toggle comment=o_wr_grey_addr[15]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000003  point: type=toggle comment=o_wr_grey_addr[16]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000003  point: type=toggle comment=o_wr_grey_addr[16]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+024722  point: type=toggle comment=o_wr_grey_addr[1]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+024721  point: type=toggle comment=o_wr_grey_addr[1]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+012362  point: type=toggle comment=o_wr_grey_addr[2]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+012361  point: type=toggle comment=o_wr_grey_addr[2]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+006181  point: type=toggle comment=o_wr_grey_addr[3]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+006181  point: type=toggle comment=o_wr_grey_addr[3]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+003091  point: type=toggle comment=o_wr_grey_addr[4]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+003090  point: type=toggle comment=o_wr_grey_addr[4]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+001545  point: type=toggle comment=o_wr_grey_addr[5]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+001545  point: type=toggle comment=o_wr_grey_addr[5]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000773  point: type=toggle comment=o_wr_grey_addr[6]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000772  point: type=toggle comment=o_wr_grey_addr[6]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000386  point: type=toggle comment=o_wr_grey_addr[7]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000386  point: type=toggle comment=o_wr_grey_addr[7]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000193  point: type=toggle comment=o_wr_grey_addr[8]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000193  point: type=toggle comment=o_wr_grey_addr[8]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000097  point: type=toggle comment=o_wr_grey_addr[9]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000097  point: type=toggle comment=o_wr_grey_addr[9]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
            );
        
            // Internal registers and wires
 098879     reg  [p_addr_width:0] r_wr_bin_addr_pointer;  // Register to store the current binary write address
+098879  point: type=toggle comment=r_wr_bin_addr_pointer[0]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+098879  point: type=toggle comment=r_wr_bin_addr_pointer[0]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000096  point: type=toggle comment=r_wr_bin_addr_pointer[10]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000096  point: type=toggle comment=r_wr_bin_addr_pointer[10]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000048  point: type=toggle comment=r_wr_bin_addr_pointer[11]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000048  point: type=toggle comment=r_wr_bin_addr_pointer[11]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000024  point: type=toggle comment=r_wr_bin_addr_pointer[12]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000024  point: type=toggle comment=r_wr_bin_addr_pointer[12]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000012  point: type=toggle comment=r_wr_bin_addr_pointer[13]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000012  point: type=toggle comment=r_wr_bin_addr_pointer[13]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000006  point: type=toggle comment=r_wr_bin_addr_pointer[14]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000006  point: type=toggle comment=r_wr_bin_addr_pointer[14]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000003  point: type=toggle comment=r_wr_bin_addr_pointer[15]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000003  point: type=toggle comment=r_wr_bin_addr_pointer[15]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000003  point: type=toggle comment=r_wr_bin_addr_pointer[16]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000003  point: type=toggle comment=r_wr_bin_addr_pointer[16]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+049438  point: type=toggle comment=r_wr_bin_addr_pointer[1]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+049438  point: type=toggle comment=r_wr_bin_addr_pointer[1]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+024719  point: type=toggle comment=r_wr_bin_addr_pointer[2]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+024718  point: type=toggle comment=r_wr_bin_addr_pointer[2]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+012359  point: type=toggle comment=r_wr_bin_addr_pointer[3]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+012359  point: type=toggle comment=r_wr_bin_addr_pointer[3]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+006179  point: type=toggle comment=r_wr_bin_addr_pointer[4]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+006179  point: type=toggle comment=r_wr_bin_addr_pointer[4]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+003090  point: type=toggle comment=r_wr_bin_addr_pointer[5]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+003089  point: type=toggle comment=r_wr_bin_addr_pointer[5]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+001545  point: type=toggle comment=r_wr_bin_addr_pointer[6]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+001544  point: type=toggle comment=r_wr_bin_addr_pointer[6]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000772  point: type=toggle comment=r_wr_bin_addr_pointer[7]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000772  point: type=toggle comment=r_wr_bin_addr_pointer[7]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000386  point: type=toggle comment=r_wr_bin_addr_pointer[8]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000386  point: type=toggle comment=r_wr_bin_addr_pointer[8]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000193  point: type=toggle comment=r_wr_bin_addr_pointer[9]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000193  point: type=toggle comment=r_wr_bin_addr_pointer[9]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
 098890     wire [p_addr_width:0] w_wr_next_bin_addr_pointer; // Wire for the next binary write address
+098890  point: type=toggle comment=w_wr_next_bin_addr_pointer[0]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+098890  point: type=toggle comment=w_wr_next_bin_addr_pointer[0]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000097  point: type=toggle comment=w_wr_next_bin_addr_pointer[10]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000097  point: type=toggle comment=w_wr_next_bin_addr_pointer[10]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000049  point: type=toggle comment=w_wr_next_bin_addr_pointer[11]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000049  point: type=toggle comment=w_wr_next_bin_addr_pointer[11]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000025  point: type=toggle comment=w_wr_next_bin_addr_pointer[12]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000025  point: type=toggle comment=w_wr_next_bin_addr_pointer[12]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000013  point: type=toggle comment=w_wr_next_bin_addr_pointer[13]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000013  point: type=toggle comment=w_wr_next_bin_addr_pointer[13]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000007  point: type=toggle comment=w_wr_next_bin_addr_pointer[14]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000007  point: type=toggle comment=w_wr_next_bin_addr_pointer[14]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000004  point: type=toggle comment=w_wr_next_bin_addr_pointer[15]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000004  point: type=toggle comment=w_wr_next_bin_addr_pointer[15]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000004  point: type=toggle comment=w_wr_next_bin_addr_pointer[16]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000004  point: type=toggle comment=w_wr_next_bin_addr_pointer[16]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+049445  point: type=toggle comment=w_wr_next_bin_addr_pointer[1]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+049445  point: type=toggle comment=w_wr_next_bin_addr_pointer[1]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+024722  point: type=toggle comment=w_wr_next_bin_addr_pointer[2]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+024721  point: type=toggle comment=w_wr_next_bin_addr_pointer[2]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+012360  point: type=toggle comment=w_wr_next_bin_addr_pointer[3]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+012360  point: type=toggle comment=w_wr_next_bin_addr_pointer[3]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+006180  point: type=toggle comment=w_wr_next_bin_addr_pointer[4]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+006180  point: type=toggle comment=w_wr_next_bin_addr_pointer[4]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+003091  point: type=toggle comment=w_wr_next_bin_addr_pointer[5]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+003090  point: type=toggle comment=w_wr_next_bin_addr_pointer[5]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+001546  point: type=toggle comment=w_wr_next_bin_addr_pointer[6]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+001545  point: type=toggle comment=w_wr_next_bin_addr_pointer[6]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000773  point: type=toggle comment=w_wr_next_bin_addr_pointer[7]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000773  point: type=toggle comment=w_wr_next_bin_addr_pointer[7]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000387  point: type=toggle comment=w_wr_next_bin_addr_pointer[8]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000387  point: type=toggle comment=w_wr_next_bin_addr_pointer[8]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000194  point: type=toggle comment=w_wr_next_bin_addr_pointer[9]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000194  point: type=toggle comment=w_wr_next_bin_addr_pointer[9]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
 049446     wire [p_addr_width:0] w_wr_next_grey_addr_pointer; // Wire for the next Gray-coded write address
+049446  point: type=toggle comment=w_wr_next_grey_addr_pointer[0]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+049446  point: type=toggle comment=w_wr_next_grey_addr_pointer[0]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000048  point: type=toggle comment=w_wr_next_grey_addr_pointer[10]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000048  point: type=toggle comment=w_wr_next_grey_addr_pointer[10]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000024  point: type=toggle comment=w_wr_next_grey_addr_pointer[11]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000024  point: type=toggle comment=w_wr_next_grey_addr_pointer[11]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000012  point: type=toggle comment=w_wr_next_grey_addr_pointer[12]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000012  point: type=toggle comment=w_wr_next_grey_addr_pointer[12]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000006  point: type=toggle comment=w_wr_next_grey_addr_pointer[13]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000006  point: type=toggle comment=w_wr_next_grey_addr_pointer[13]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000003  point: type=toggle comment=w_wr_next_grey_addr_pointer[14]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000003  point: type=toggle comment=w_wr_next_grey_addr_pointer[14]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000003  point: type=toggle comment=w_wr_next_grey_addr_pointer[15]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000003  point: type=toggle comment=w_wr_next_grey_addr_pointer[15]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000004  point: type=toggle comment=w_wr_next_grey_addr_pointer[16]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000004  point: type=toggle comment=w_wr_next_grey_addr_pointer[16]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+024726  point: type=toggle comment=w_wr_next_grey_addr_pointer[1]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+024725  point: type=toggle comment=w_wr_next_grey_addr_pointer[1]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+012364  point: type=toggle comment=w_wr_next_grey_addr_pointer[2]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+012363  point: type=toggle comment=w_wr_next_grey_addr_pointer[2]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+006181  point: type=toggle comment=w_wr_next_grey_addr_pointer[3]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+006181  point: type=toggle comment=w_wr_next_grey_addr_pointer[3]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+003091  point: type=toggle comment=w_wr_next_grey_addr_pointer[4]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+003090  point: type=toggle comment=w_wr_next_grey_addr_pointer[4]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+001545  point: type=toggle comment=w_wr_next_grey_addr_pointer[5]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+001545  point: type=toggle comment=w_wr_next_grey_addr_pointer[5]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000773  point: type=toggle comment=w_wr_next_grey_addr_pointer[6]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000772  point: type=toggle comment=w_wr_next_grey_addr_pointer[6]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000386  point: type=toggle comment=w_wr_next_grey_addr_pointer[7]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000386  point: type=toggle comment=w_wr_next_grey_addr_pointer[7]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000193  point: type=toggle comment=w_wr_next_grey_addr_pointer[8]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000193  point: type=toggle comment=w_wr_next_grey_addr_pointer[8]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
+000097  point: type=toggle comment=w_wr_next_grey_addr_pointer[9]:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000097  point: type=toggle comment=w_wr_next_grey_addr_pointer[9]:1->0 hier=tb_async_fifo.dut.wptr_full_inst
 000004     wire                  w_wr_full;             // Wire indicating if the FIFO is full
+000004  point: type=toggle comment=w_wr_full:0->1 hier=tb_async_fifo.dut.wptr_full_inst
+000004  point: type=toggle comment=w_wr_full:1->0 hier=tb_async_fifo.dut.wptr_full_inst
        
            // Always block for updating the write address pointers
            // GRAYSTYLE2 pointer update mechanism
 474372     always @(posedge i_wr_clk or negedge i_wr_rst_n) begin
+474372  point: type=line comment=block hier=tb_async_fifo.dut.wptr_full_inst
 474212         if (!i_wr_rst_n) begin
+474212  point: type=branch comment=else hier=tb_async_fifo.dut.wptr_full_inst
+000160  point: type=expr comment=(i_wr_rst_n==0) => 1 hier=tb_async_fifo.dut.wptr_full_inst
+474212  point: type=expr comment=(i_wr_rst_n==1) => 0 hier=tb_async_fifo.dut.wptr_full_inst
+000160  point: type=branch comment=if hier=tb_async_fifo.dut.wptr_full_inst
                    // Reset the write address pointers to 0 on reset
 000160             r_wr_bin_addr_pointer <= {p_addr_width{1'b0}};
+000160  point: type=branch comment=if hier=tb_async_fifo.dut.wptr_full_inst
 000160             o_wr_grey_addr <= {p_addr_width{1'b0}};
+000160  point: type=branch comment=if hier=tb_async_fifo.dut.wptr_full_inst
 474212         end else begin
+474212  point: type=branch comment=else hier=tb_async_fifo.dut.wptr_full_inst
                    // Update the write address pointers on each clock edge
 474212             r_wr_bin_addr_pointer <= w_wr_next_bin_addr_pointer;
+474212  point: type=branch comment=else hier=tb_async_fifo.dut.wptr_full_inst
 474212             o_wr_grey_addr <= w_wr_next_grey_addr_pointer;
+474212  point: type=branch comment=else hier=tb_async_fifo.dut.wptr_full_inst
                end
            end
        
            // Assign the binary write address for addressing the memory
            assign o_wr_bin_addr = r_wr_bin_addr_pointer[p_addr_width-1:0];
        
            // Calculate the next binary write address, only increment if write enable is active and FIFO is not full
            assign w_wr_next_bin_addr_pointer  = r_wr_bin_addr_pointer + (i_wr_en & ~o_fifo_full);
        
            // Convert the next binary write address to Gray code
            assign w_wr_next_grey_addr_pointer = (w_wr_next_bin_addr_pointer >> 1) ^ w_wr_next_bin_addr_pointer;
        
            // Check if the FIFO is full by comparing the next Gray-coded write address with the synchronized read pointer
            // FIFO is full if the next write address matches the read pointer with the MSB inverted
            assign w_wr_full = (w_wr_next_grey_addr_pointer == {~i_rd_ptr_sync[p_addr_width:p_addr_width-1], i_rd_ptr_sync[p_addr_width-2:0]});
        
            // Always block for updating the FIFO full flag
 474372     always @(posedge i_wr_clk or negedge i_wr_rst_n) begin
+474372  point: type=line comment=block hier=tb_async_fifo.dut.wptr_full_inst
 474212         if (!i_wr_rst_n) begin
+474212  point: type=branch comment=else hier=tb_async_fifo.dut.wptr_full_inst
+000160  point: type=expr comment=(i_wr_rst_n==0) => 1 hier=tb_async_fifo.dut.wptr_full_inst
+474212  point: type=expr comment=(i_wr_rst_n==1) => 0 hier=tb_async_fifo.dut.wptr_full_inst
+000160  point: type=branch comment=if hier=tb_async_fifo.dut.wptr_full_inst
                    // Reset the FIFO full flag to 0 on reset
 000160             o_fifo_full <= 1'b0;
+000160  point: type=branch comment=if hier=tb_async_fifo.dut.wptr_full_inst
 474212         end else begin
+474212  point: type=branch comment=else hier=tb_async_fifo.dut.wptr_full_inst
                    // Update the FIFO full flag based on the calculated full condition
 474212             o_fifo_full <= w_wr_full;
+474212  point: type=branch comment=else hier=tb_async_fifo.dut.wptr_full_inst
                end
            end
        
        endmodule
