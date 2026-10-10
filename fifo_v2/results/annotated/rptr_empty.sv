//      // verilator_coverage annotation
        module rptr_empty 
            #(
                parameter p_addr_width = 16  // Parameter to define the address width of the FIFO
            )(
 338829         input  wire                i_rd_clk,         // Read clock
+338829  point: type=toggle comment=i_rd_clk:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+338829  point: type=toggle comment=i_rd_clk:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
 000013         input  wire                i_rd_rst_n,       // Read reset (active low)
+000013  point: type=toggle comment=i_rd_rst_n:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000012  point: type=toggle comment=i_rd_rst_n:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
 000018         input  wire                i_rd_en,          // Read enable signal
+000018  point: type=toggle comment=i_rd_en:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000018  point: type=toggle comment=i_rd_en:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
 049442         input  wire [p_addr_width  :0] i_wr_ptr_sync, // Synchronized write pointer from the write clock domain
+049442  point: type=toggle comment=i_wr_ptr_sync[0]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+049442  point: type=toggle comment=i_wr_ptr_sync[0]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000048  point: type=toggle comment=i_wr_ptr_sync[10]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000048  point: type=toggle comment=i_wr_ptr_sync[10]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000024  point: type=toggle comment=i_wr_ptr_sync[11]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000024  point: type=toggle comment=i_wr_ptr_sync[11]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000012  point: type=toggle comment=i_wr_ptr_sync[12]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000012  point: type=toggle comment=i_wr_ptr_sync[12]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000006  point: type=toggle comment=i_wr_ptr_sync[13]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000006  point: type=toggle comment=i_wr_ptr_sync[13]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=i_wr_ptr_sync[14]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=i_wr_ptr_sync[14]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=i_wr_ptr_sync[15]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=i_wr_ptr_sync[15]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=i_wr_ptr_sync[16]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=i_wr_ptr_sync[16]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+024724  point: type=toggle comment=i_wr_ptr_sync[1]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+024723  point: type=toggle comment=i_wr_ptr_sync[1]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+012362  point: type=toggle comment=i_wr_ptr_sync[2]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+012361  point: type=toggle comment=i_wr_ptr_sync[2]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+006181  point: type=toggle comment=i_wr_ptr_sync[3]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+006181  point: type=toggle comment=i_wr_ptr_sync[3]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+003091  point: type=toggle comment=i_wr_ptr_sync[4]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+003090  point: type=toggle comment=i_wr_ptr_sync[4]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+001545  point: type=toggle comment=i_wr_ptr_sync[5]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+001545  point: type=toggle comment=i_wr_ptr_sync[5]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000773  point: type=toggle comment=i_wr_ptr_sync[6]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000772  point: type=toggle comment=i_wr_ptr_sync[6]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000386  point: type=toggle comment=i_wr_ptr_sync[7]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000386  point: type=toggle comment=i_wr_ptr_sync[7]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000193  point: type=toggle comment=i_wr_ptr_sync[8]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000193  point: type=toggle comment=i_wr_ptr_sync[8]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000097  point: type=toggle comment=i_wr_ptr_sync[9]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000097  point: type=toggle comment=i_wr_ptr_sync[9]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
 000016         output reg                 o_fifo_empty,     // Output flag indicating if the FIFO is empty
+000016  point: type=toggle comment=o_fifo_empty:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000015  point: type=toggle comment=o_fifo_empty:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
 098876         output wire [p_addr_width-1:0] o_rd_bin_addr, // Output binary read address
+098876  point: type=toggle comment=o_rd_bin_addr[0]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+098876  point: type=toggle comment=o_rd_bin_addr[0]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000096  point: type=toggle comment=o_rd_bin_addr[10]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000096  point: type=toggle comment=o_rd_bin_addr[10]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000048  point: type=toggle comment=o_rd_bin_addr[11]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000048  point: type=toggle comment=o_rd_bin_addr[11]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000024  point: type=toggle comment=o_rd_bin_addr[12]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000024  point: type=toggle comment=o_rd_bin_addr[12]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000012  point: type=toggle comment=o_rd_bin_addr[13]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000012  point: type=toggle comment=o_rd_bin_addr[13]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000006  point: type=toggle comment=o_rd_bin_addr[14]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000006  point: type=toggle comment=o_rd_bin_addr[14]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=o_rd_bin_addr[15]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=o_rd_bin_addr[15]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+049436  point: type=toggle comment=o_rd_bin_addr[1]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+049436  point: type=toggle comment=o_rd_bin_addr[1]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+024717  point: type=toggle comment=o_rd_bin_addr[2]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+024716  point: type=toggle comment=o_rd_bin_addr[2]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+012358  point: type=toggle comment=o_rd_bin_addr[3]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+012358  point: type=toggle comment=o_rd_bin_addr[3]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+006179  point: type=toggle comment=o_rd_bin_addr[4]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+006179  point: type=toggle comment=o_rd_bin_addr[4]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+003090  point: type=toggle comment=o_rd_bin_addr[5]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+003089  point: type=toggle comment=o_rd_bin_addr[5]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+001545  point: type=toggle comment=o_rd_bin_addr[6]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+001544  point: type=toggle comment=o_rd_bin_addr[6]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000772  point: type=toggle comment=o_rd_bin_addr[7]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000772  point: type=toggle comment=o_rd_bin_addr[7]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000386  point: type=toggle comment=o_rd_bin_addr[8]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000386  point: type=toggle comment=o_rd_bin_addr[8]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000193  point: type=toggle comment=o_rd_bin_addr[9]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000193  point: type=toggle comment=o_rd_bin_addr[9]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
 049440         output reg  [p_addr_width  :0] o_rd_grey_addr // Output Gray-coded read address
+049440  point: type=toggle comment=o_rd_grey_addr[0]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+049440  point: type=toggle comment=o_rd_grey_addr[0]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000048  point: type=toggle comment=o_rd_grey_addr[10]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000048  point: type=toggle comment=o_rd_grey_addr[10]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000024  point: type=toggle comment=o_rd_grey_addr[11]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000024  point: type=toggle comment=o_rd_grey_addr[11]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000012  point: type=toggle comment=o_rd_grey_addr[12]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000012  point: type=toggle comment=o_rd_grey_addr[12]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000006  point: type=toggle comment=o_rd_grey_addr[13]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000006  point: type=toggle comment=o_rd_grey_addr[13]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=o_rd_grey_addr[14]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=o_rd_grey_addr[14]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=o_rd_grey_addr[15]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=o_rd_grey_addr[15]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=o_rd_grey_addr[16]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=o_rd_grey_addr[16]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+024721  point: type=toggle comment=o_rd_grey_addr[1]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+024720  point: type=toggle comment=o_rd_grey_addr[1]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+012360  point: type=toggle comment=o_rd_grey_addr[2]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+012359  point: type=toggle comment=o_rd_grey_addr[2]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+006180  point: type=toggle comment=o_rd_grey_addr[3]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+006180  point: type=toggle comment=o_rd_grey_addr[3]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+003091  point: type=toggle comment=o_rd_grey_addr[4]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+003090  point: type=toggle comment=o_rd_grey_addr[4]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+001545  point: type=toggle comment=o_rd_grey_addr[5]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+001545  point: type=toggle comment=o_rd_grey_addr[5]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000773  point: type=toggle comment=o_rd_grey_addr[6]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000772  point: type=toggle comment=o_rd_grey_addr[6]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000386  point: type=toggle comment=o_rd_grey_addr[7]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000386  point: type=toggle comment=o_rd_grey_addr[7]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000193  point: type=toggle comment=o_rd_grey_addr[8]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000193  point: type=toggle comment=o_rd_grey_addr[8]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000097  point: type=toggle comment=o_rd_grey_addr[9]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000097  point: type=toggle comment=o_rd_grey_addr[9]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
            );
        
            // Internal registers and wires
 098876     reg  [p_addr_width:0] r_rd_bin_addr_pointer; // Register to store the current binary read address
+098876  point: type=toggle comment=r_rd_bin_addr_pointer[0]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+098876  point: type=toggle comment=r_rd_bin_addr_pointer[0]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000096  point: type=toggle comment=r_rd_bin_addr_pointer[10]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000096  point: type=toggle comment=r_rd_bin_addr_pointer[10]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000048  point: type=toggle comment=r_rd_bin_addr_pointer[11]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000048  point: type=toggle comment=r_rd_bin_addr_pointer[11]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000024  point: type=toggle comment=r_rd_bin_addr_pointer[12]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000024  point: type=toggle comment=r_rd_bin_addr_pointer[12]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000012  point: type=toggle comment=r_rd_bin_addr_pointer[13]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000012  point: type=toggle comment=r_rd_bin_addr_pointer[13]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000006  point: type=toggle comment=r_rd_bin_addr_pointer[14]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000006  point: type=toggle comment=r_rd_bin_addr_pointer[14]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=r_rd_bin_addr_pointer[15]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=r_rd_bin_addr_pointer[15]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=r_rd_bin_addr_pointer[16]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=r_rd_bin_addr_pointer[16]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+049436  point: type=toggle comment=r_rd_bin_addr_pointer[1]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+049436  point: type=toggle comment=r_rd_bin_addr_pointer[1]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+024717  point: type=toggle comment=r_rd_bin_addr_pointer[2]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+024716  point: type=toggle comment=r_rd_bin_addr_pointer[2]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+012358  point: type=toggle comment=r_rd_bin_addr_pointer[3]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+012358  point: type=toggle comment=r_rd_bin_addr_pointer[3]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+006179  point: type=toggle comment=r_rd_bin_addr_pointer[4]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+006179  point: type=toggle comment=r_rd_bin_addr_pointer[4]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+003090  point: type=toggle comment=r_rd_bin_addr_pointer[5]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+003089  point: type=toggle comment=r_rd_bin_addr_pointer[5]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+001545  point: type=toggle comment=r_rd_bin_addr_pointer[6]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+001544  point: type=toggle comment=r_rd_bin_addr_pointer[6]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000772  point: type=toggle comment=r_rd_bin_addr_pointer[7]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000772  point: type=toggle comment=r_rd_bin_addr_pointer[7]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000386  point: type=toggle comment=r_rd_bin_addr_pointer[8]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000386  point: type=toggle comment=r_rd_bin_addr_pointer[8]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000193  point: type=toggle comment=r_rd_bin_addr_pointer[9]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000193  point: type=toggle comment=r_rd_bin_addr_pointer[9]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
 049441     wire [p_addr_width:0] w_rd_next_grey_addr_pointer; // Wire for the next Gray-coded read address
+049441  point: type=toggle comment=w_rd_next_grey_addr_pointer[0]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+049441  point: type=toggle comment=w_rd_next_grey_addr_pointer[0]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000048  point: type=toggle comment=w_rd_next_grey_addr_pointer[10]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000048  point: type=toggle comment=w_rd_next_grey_addr_pointer[10]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000024  point: type=toggle comment=w_rd_next_grey_addr_pointer[11]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000024  point: type=toggle comment=w_rd_next_grey_addr_pointer[11]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000012  point: type=toggle comment=w_rd_next_grey_addr_pointer[12]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000012  point: type=toggle comment=w_rd_next_grey_addr_pointer[12]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000006  point: type=toggle comment=w_rd_next_grey_addr_pointer[13]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000006  point: type=toggle comment=w_rd_next_grey_addr_pointer[13]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=w_rd_next_grey_addr_pointer[14]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=w_rd_next_grey_addr_pointer[14]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=w_rd_next_grey_addr_pointer[15]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=w_rd_next_grey_addr_pointer[15]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=w_rd_next_grey_addr_pointer[16]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=w_rd_next_grey_addr_pointer[16]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+024724  point: type=toggle comment=w_rd_next_grey_addr_pointer[1]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+024723  point: type=toggle comment=w_rd_next_grey_addr_pointer[1]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+012361  point: type=toggle comment=w_rd_next_grey_addr_pointer[2]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+012360  point: type=toggle comment=w_rd_next_grey_addr_pointer[2]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+006180  point: type=toggle comment=w_rd_next_grey_addr_pointer[3]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+006180  point: type=toggle comment=w_rd_next_grey_addr_pointer[3]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+003091  point: type=toggle comment=w_rd_next_grey_addr_pointer[4]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+003090  point: type=toggle comment=w_rd_next_grey_addr_pointer[4]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+001545  point: type=toggle comment=w_rd_next_grey_addr_pointer[5]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+001545  point: type=toggle comment=w_rd_next_grey_addr_pointer[5]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000773  point: type=toggle comment=w_rd_next_grey_addr_pointer[6]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000772  point: type=toggle comment=w_rd_next_grey_addr_pointer[6]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000386  point: type=toggle comment=w_rd_next_grey_addr_pointer[7]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000386  point: type=toggle comment=w_rd_next_grey_addr_pointer[7]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000193  point: type=toggle comment=w_rd_next_grey_addr_pointer[8]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000193  point: type=toggle comment=w_rd_next_grey_addr_pointer[8]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000097  point: type=toggle comment=w_rd_next_grey_addr_pointer[9]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000097  point: type=toggle comment=w_rd_next_grey_addr_pointer[9]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
 098881     wire [p_addr_width:0] w_rd_next_bin_addr_pointer; // Wire for the next binary read address
+098881  point: type=toggle comment=w_rd_next_bin_addr_pointer[0]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+098881  point: type=toggle comment=w_rd_next_bin_addr_pointer[0]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000096  point: type=toggle comment=w_rd_next_bin_addr_pointer[10]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000096  point: type=toggle comment=w_rd_next_bin_addr_pointer[10]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000048  point: type=toggle comment=w_rd_next_bin_addr_pointer[11]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000048  point: type=toggle comment=w_rd_next_bin_addr_pointer[11]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000024  point: type=toggle comment=w_rd_next_bin_addr_pointer[12]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000024  point: type=toggle comment=w_rd_next_bin_addr_pointer[12]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000012  point: type=toggle comment=w_rd_next_bin_addr_pointer[13]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000012  point: type=toggle comment=w_rd_next_bin_addr_pointer[13]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000006  point: type=toggle comment=w_rd_next_bin_addr_pointer[14]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000006  point: type=toggle comment=w_rd_next_bin_addr_pointer[14]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=w_rd_next_bin_addr_pointer[15]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=w_rd_next_bin_addr_pointer[15]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=w_rd_next_bin_addr_pointer[16]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000003  point: type=toggle comment=w_rd_next_bin_addr_pointer[16]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+049440  point: type=toggle comment=w_rd_next_bin_addr_pointer[1]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+049440  point: type=toggle comment=w_rd_next_bin_addr_pointer[1]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+024718  point: type=toggle comment=w_rd_next_bin_addr_pointer[2]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+024717  point: type=toggle comment=w_rd_next_bin_addr_pointer[2]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+012358  point: type=toggle comment=w_rd_next_bin_addr_pointer[3]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+012358  point: type=toggle comment=w_rd_next_bin_addr_pointer[3]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+006179  point: type=toggle comment=w_rd_next_bin_addr_pointer[4]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+006179  point: type=toggle comment=w_rd_next_bin_addr_pointer[4]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+003090  point: type=toggle comment=w_rd_next_bin_addr_pointer[5]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+003089  point: type=toggle comment=w_rd_next_bin_addr_pointer[5]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+001545  point: type=toggle comment=w_rd_next_bin_addr_pointer[6]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+001544  point: type=toggle comment=w_rd_next_bin_addr_pointer[6]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000772  point: type=toggle comment=w_rd_next_bin_addr_pointer[7]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000772  point: type=toggle comment=w_rd_next_bin_addr_pointer[7]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000386  point: type=toggle comment=w_rd_next_bin_addr_pointer[8]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000386  point: type=toggle comment=w_rd_next_bin_addr_pointer[8]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
+000193  point: type=toggle comment=w_rd_next_bin_addr_pointer[9]:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000193  point: type=toggle comment=w_rd_next_bin_addr_pointer[9]:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
 000016     wire                  w_rd_empty;             // Wire indicating if the FIFO is empty
+000016  point: type=toggle comment=w_rd_empty:0->1 hier=tb_async_fifo.dut.rptr_empty_inst
+000015  point: type=toggle comment=w_rd_empty:1->0 hier=tb_async_fifo.dut.rptr_empty_inst
        
            //-------------------
            // GRAYSTYLE2 pointer
            //-------------------
 338841     always @(posedge i_rd_clk or negedge i_rd_rst_n) 
+338841  point: type=line comment=block hier=tb_async_fifo.dut.rptr_empty_inst
 338841     begin
+338841  point: type=line comment=block hier=tb_async_fifo.dut.rptr_empty_inst
 338719         if (!i_rd_rst_n) begin
+338719  point: type=branch comment=else hier=tb_async_fifo.dut.rptr_empty_inst
+000122  point: type=expr comment=(i_rd_rst_n==0) => 1 hier=tb_async_fifo.dut.rptr_empty_inst
+338719  point: type=expr comment=(i_rd_rst_n==1) => 0 hier=tb_async_fifo.dut.rptr_empty_inst
+000122  point: type=branch comment=if hier=tb_async_fifo.dut.rptr_empty_inst
                    // Reset the read address pointers to 0 on reset
 000122             r_rd_bin_addr_pointer <= {p_addr_width+1{1'b0}};
+000122  point: type=branch comment=if hier=tb_async_fifo.dut.rptr_empty_inst
 000122             o_rd_grey_addr <= {p_addr_width+1{1'b0}};
+000122  point: type=branch comment=if hier=tb_async_fifo.dut.rptr_empty_inst
 338719         end else begin
+338719  point: type=branch comment=else hier=tb_async_fifo.dut.rptr_empty_inst
                    // Update the read address pointers on each clock edge
 338719             r_rd_bin_addr_pointer <= w_rd_next_bin_addr_pointer;
+338719  point: type=branch comment=else hier=tb_async_fifo.dut.rptr_empty_inst
 338719             o_rd_grey_addr <= w_rd_next_grey_addr_pointer;
+338719  point: type=branch comment=else hier=tb_async_fifo.dut.rptr_empty_inst
                end
            end
            
            // Memory read-address pointer (binary addressing for memory access)
            assign o_rd_bin_addr = r_rd_bin_addr_pointer[p_addr_width-1:0];
        
            // Calculate the next binary read address, increment only if read enable is active and FIFO is not empty
            assign w_rd_next_bin_addr_pointer = r_rd_bin_addr_pointer + (i_rd_en & ~o_fifo_empty);
        
            // Convert the next binary read address to Gray code
            assign w_rd_next_grey_addr_pointer = (w_rd_next_bin_addr_pointer >> 1) ^ w_rd_next_bin_addr_pointer;
        
            //---------------------------------------------------------------
            // FIFO is empty when the next Gray-coded read address matches the synchronized write pointer or on reset
            //---------------------------------------------------------------
            assign w_rd_empty = (w_rd_next_grey_addr_pointer == i_wr_ptr_sync);
        
            // Always block for updating the FIFO empty flag
 338841     always @(posedge i_rd_clk or negedge i_rd_rst_n) begin
+338841  point: type=line comment=block hier=tb_async_fifo.dut.rptr_empty_inst
 338719         if (!i_rd_rst_n) begin
+338719  point: type=branch comment=else hier=tb_async_fifo.dut.rptr_empty_inst
+000122  point: type=expr comment=(i_rd_rst_n==0) => 1 hier=tb_async_fifo.dut.rptr_empty_inst
+338719  point: type=expr comment=(i_rd_rst_n==1) => 0 hier=tb_async_fifo.dut.rptr_empty_inst
+000122  point: type=branch comment=if hier=tb_async_fifo.dut.rptr_empty_inst
                    // Reset the FIFO empty flag to 1 on reset
 000122             o_fifo_empty <= 1'b1;
+000122  point: type=branch comment=if hier=tb_async_fifo.dut.rptr_empty_inst
 338719         end else begin
+338719  point: type=branch comment=else hier=tb_async_fifo.dut.rptr_empty_inst
                    // Update the FIFO empty flag based on the calculated empty condition
 338719             o_fifo_empty <= w_rd_empty;
+338719  point: type=branch comment=else hier=tb_async_fifo.dut.rptr_empty_inst
                end
            end
        
        endmodule
