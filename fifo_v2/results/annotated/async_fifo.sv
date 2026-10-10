//      // verilator_coverage annotation
        module async_fifo
            #(
                parameter p_data_width = 32,   // Parameter to define the width of the data
                parameter p_addr_width = 16    // Parameter to define the width of the address
            )(
 474361         input  wire             i_wr_clk,           // Write clock
+474361  point: type=toggle comment=i_wr_clk:0->1 hier=tb_async_fifo.dut
+474360  point: type=toggle comment=i_wr_clk:1->0 hier=tb_async_fifo.dut
 000012         input  wire             i_wr_rst_n,         // Write reset (active low)
+000012  point: type=toggle comment=i_wr_rst_n:0->1 hier=tb_async_fifo.dut
+000011  point: type=toggle comment=i_wr_rst_n:1->0 hier=tb_async_fifo.dut
 000015         input  wire             i_wr_en,            // Write enable
+000015  point: type=toggle comment=i_wr_en:0->1 hier=tb_async_fifo.dut
+000015  point: type=toggle comment=i_wr_en:1->0 hier=tb_async_fifo.dut
~098874         input  wire [p_data_width-1:0] i_wr_data,   // Data to be written to the FIFO
+098874  point: type=toggle comment=i_wr_data[0]:0->1 hier=tb_async_fifo.dut
+098873  point: type=toggle comment=i_wr_data[0]:1->0 hier=tb_async_fifo.dut
+000097  point: type=toggle comment=i_wr_data[10]:0->1 hier=tb_async_fifo.dut
+000097  point: type=toggle comment=i_wr_data[10]:1->0 hier=tb_async_fifo.dut
+000049  point: type=toggle comment=i_wr_data[11]:0->1 hier=tb_async_fifo.dut
+000049  point: type=toggle comment=i_wr_data[11]:1->0 hier=tb_async_fifo.dut
+000025  point: type=toggle comment=i_wr_data[12]:0->1 hier=tb_async_fifo.dut
+000025  point: type=toggle comment=i_wr_data[12]:1->0 hier=tb_async_fifo.dut
+000013  point: type=toggle comment=i_wr_data[13]:0->1 hier=tb_async_fifo.dut
+000013  point: type=toggle comment=i_wr_data[13]:1->0 hier=tb_async_fifo.dut
+000006  point: type=toggle comment=i_wr_data[14]:0->1 hier=tb_async_fifo.dut
+000006  point: type=toggle comment=i_wr_data[14]:1->0 hier=tb_async_fifo.dut
+000004  point: type=toggle comment=i_wr_data[15]:0->1 hier=tb_async_fifo.dut
+000004  point: type=toggle comment=i_wr_data[15]:1->0 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=i_wr_data[16]:0->1 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=i_wr_data[16]:1->0 hier=tb_async_fifo.dut
-000000  point: type=toggle comment=i_wr_data[17]:0->1 hier=tb_async_fifo.dut
-000000  point: type=toggle comment=i_wr_data[17]:1->0 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=i_wr_data[18]:0->1 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=i_wr_data[18]:1->0 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=i_wr_data[19]:0->1 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=i_wr_data[19]:1->0 hier=tb_async_fifo.dut
+049438  point: type=toggle comment=i_wr_data[1]:0->1 hier=tb_async_fifo.dut
+049437  point: type=toggle comment=i_wr_data[1]:1->0 hier=tb_async_fifo.dut
-000000  point: type=toggle comment=i_wr_data[20]:0->1 hier=tb_async_fifo.dut
-000000  point: type=toggle comment=i_wr_data[20]:1->0 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=i_wr_data[21]:0->1 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=i_wr_data[21]:1->0 hier=tb_async_fifo.dut
-000000  point: type=toggle comment=i_wr_data[22]:0->1 hier=tb_async_fifo.dut
-000000  point: type=toggle comment=i_wr_data[22]:1->0 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=i_wr_data[23]:0->1 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=i_wr_data[23]:1->0 hier=tb_async_fifo.dut
-000000  point: type=toggle comment=i_wr_data[24]:0->1 hier=tb_async_fifo.dut
-000000  point: type=toggle comment=i_wr_data[24]:1->0 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=i_wr_data[25]:0->1 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=i_wr_data[25]:1->0 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=i_wr_data[26]:0->1 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=i_wr_data[26]:1->0 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=i_wr_data[27]:0->1 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=i_wr_data[27]:1->0 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=i_wr_data[28]:0->1 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=i_wr_data[28]:1->0 hier=tb_async_fifo.dut
-000000  point: type=toggle comment=i_wr_data[29]:0->1 hier=tb_async_fifo.dut
-000000  point: type=toggle comment=i_wr_data[29]:1->0 hier=tb_async_fifo.dut
+024720  point: type=toggle comment=i_wr_data[2]:0->1 hier=tb_async_fifo.dut
+024719  point: type=toggle comment=i_wr_data[2]:1->0 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=i_wr_data[30]:0->1 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=i_wr_data[30]:1->0 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=i_wr_data[31]:0->1 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=i_wr_data[31]:1->0 hier=tb_async_fifo.dut
+012360  point: type=toggle comment=i_wr_data[3]:0->1 hier=tb_async_fifo.dut
+012360  point: type=toggle comment=i_wr_data[3]:1->0 hier=tb_async_fifo.dut
+006179  point: type=toggle comment=i_wr_data[4]:0->1 hier=tb_async_fifo.dut
+006179  point: type=toggle comment=i_wr_data[4]:1->0 hier=tb_async_fifo.dut
+003093  point: type=toggle comment=i_wr_data[5]:0->1 hier=tb_async_fifo.dut
+003092  point: type=toggle comment=i_wr_data[5]:1->0 hier=tb_async_fifo.dut
+001548  point: type=toggle comment=i_wr_data[6]:0->1 hier=tb_async_fifo.dut
+001547  point: type=toggle comment=i_wr_data[6]:1->0 hier=tb_async_fifo.dut
+000776  point: type=toggle comment=i_wr_data[7]:0->1 hier=tb_async_fifo.dut
+000775  point: type=toggle comment=i_wr_data[7]:1->0 hier=tb_async_fifo.dut
+000388  point: type=toggle comment=i_wr_data[8]:0->1 hier=tb_async_fifo.dut
+000387  point: type=toggle comment=i_wr_data[8]:1->0 hier=tb_async_fifo.dut
+000195  point: type=toggle comment=i_wr_data[9]:0->1 hier=tb_async_fifo.dut
+000194  point: type=toggle comment=i_wr_data[9]:1->0 hier=tb_async_fifo.dut
 000003         output wire             o_fifo_full,        // FIFO full flag
+000003  point: type=toggle comment=o_fifo_full:0->1 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=o_fifo_full:1->0 hier=tb_async_fifo.dut
 338829         input  wire             i_rd_clk,           // Read clock
+338829  point: type=toggle comment=i_rd_clk:0->1 hier=tb_async_fifo.dut
+338829  point: type=toggle comment=i_rd_clk:1->0 hier=tb_async_fifo.dut
 000013         input  wire             i_rd_rst_n,         // Read reset (active low)
+000013  point: type=toggle comment=i_rd_rst_n:0->1 hier=tb_async_fifo.dut
+000012  point: type=toggle comment=i_rd_rst_n:1->0 hier=tb_async_fifo.dut
 000018         input  wire             i_rd_en,            // Read enable
+000018  point: type=toggle comment=i_rd_en:0->1 hier=tb_async_fifo.dut
+000018  point: type=toggle comment=i_rd_en:1->0 hier=tb_async_fifo.dut
~098869         output wire [p_data_width-1:0] o_rd_data,   // Data read from the FIFO
+098869  point: type=toggle comment=o_rd_data[0]:0->1 hier=tb_async_fifo.dut
+098868  point: type=toggle comment=o_rd_data[0]:1->0 hier=tb_async_fifo.dut
+000097  point: type=toggle comment=o_rd_data[10]:0->1 hier=tb_async_fifo.dut
+000097  point: type=toggle comment=o_rd_data[10]:1->0 hier=tb_async_fifo.dut
+000049  point: type=toggle comment=o_rd_data[11]:0->1 hier=tb_async_fifo.dut
+000049  point: type=toggle comment=o_rd_data[11]:1->0 hier=tb_async_fifo.dut
+000025  point: type=toggle comment=o_rd_data[12]:0->1 hier=tb_async_fifo.dut
+000025  point: type=toggle comment=o_rd_data[12]:1->0 hier=tb_async_fifo.dut
+000013  point: type=toggle comment=o_rd_data[13]:0->1 hier=tb_async_fifo.dut
+000013  point: type=toggle comment=o_rd_data[13]:1->0 hier=tb_async_fifo.dut
+000006  point: type=toggle comment=o_rd_data[14]:0->1 hier=tb_async_fifo.dut
+000006  point: type=toggle comment=o_rd_data[14]:1->0 hier=tb_async_fifo.dut
+000004  point: type=toggle comment=o_rd_data[15]:0->1 hier=tb_async_fifo.dut
+000004  point: type=toggle comment=o_rd_data[15]:1->0 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=o_rd_data[16]:0->1 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=o_rd_data[16]:1->0 hier=tb_async_fifo.dut
-000000  point: type=toggle comment=o_rd_data[17]:0->1 hier=tb_async_fifo.dut
-000000  point: type=toggle comment=o_rd_data[17]:1->0 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=o_rd_data[18]:0->1 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=o_rd_data[18]:1->0 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=o_rd_data[19]:0->1 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=o_rd_data[19]:1->0 hier=tb_async_fifo.dut
+049437  point: type=toggle comment=o_rd_data[1]:0->1 hier=tb_async_fifo.dut
+049436  point: type=toggle comment=o_rd_data[1]:1->0 hier=tb_async_fifo.dut
-000000  point: type=toggle comment=o_rd_data[20]:0->1 hier=tb_async_fifo.dut
-000000  point: type=toggle comment=o_rd_data[20]:1->0 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=o_rd_data[21]:0->1 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=o_rd_data[21]:1->0 hier=tb_async_fifo.dut
-000000  point: type=toggle comment=o_rd_data[22]:0->1 hier=tb_async_fifo.dut
-000000  point: type=toggle comment=o_rd_data[22]:1->0 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=o_rd_data[23]:0->1 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=o_rd_data[23]:1->0 hier=tb_async_fifo.dut
-000000  point: type=toggle comment=o_rd_data[24]:0->1 hier=tb_async_fifo.dut
-000000  point: type=toggle comment=o_rd_data[24]:1->0 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=o_rd_data[25]:0->1 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=o_rd_data[25]:1->0 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=o_rd_data[26]:0->1 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=o_rd_data[26]:1->0 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=o_rd_data[27]:0->1 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=o_rd_data[27]:1->0 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=o_rd_data[28]:0->1 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=o_rd_data[28]:1->0 hier=tb_async_fifo.dut
-000000  point: type=toggle comment=o_rd_data[29]:0->1 hier=tb_async_fifo.dut
-000000  point: type=toggle comment=o_rd_data[29]:1->0 hier=tb_async_fifo.dut
+024719  point: type=toggle comment=o_rd_data[2]:0->1 hier=tb_async_fifo.dut
+024718  point: type=toggle comment=o_rd_data[2]:1->0 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=o_rd_data[30]:0->1 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=o_rd_data[30]:1->0 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=o_rd_data[31]:0->1 hier=tb_async_fifo.dut
+000001  point: type=toggle comment=o_rd_data[31]:1->0 hier=tb_async_fifo.dut
+012360  point: type=toggle comment=o_rd_data[3]:0->1 hier=tb_async_fifo.dut
+012360  point: type=toggle comment=o_rd_data[3]:1->0 hier=tb_async_fifo.dut
+006179  point: type=toggle comment=o_rd_data[4]:0->1 hier=tb_async_fifo.dut
+006179  point: type=toggle comment=o_rd_data[4]:1->0 hier=tb_async_fifo.dut
+003093  point: type=toggle comment=o_rd_data[5]:0->1 hier=tb_async_fifo.dut
+003092  point: type=toggle comment=o_rd_data[5]:1->0 hier=tb_async_fifo.dut
+001548  point: type=toggle comment=o_rd_data[6]:0->1 hier=tb_async_fifo.dut
+001547  point: type=toggle comment=o_rd_data[6]:1->0 hier=tb_async_fifo.dut
+000776  point: type=toggle comment=o_rd_data[7]:0->1 hier=tb_async_fifo.dut
+000775  point: type=toggle comment=o_rd_data[7]:1->0 hier=tb_async_fifo.dut
+000388  point: type=toggle comment=o_rd_data[8]:0->1 hier=tb_async_fifo.dut
+000387  point: type=toggle comment=o_rd_data[8]:1->0 hier=tb_async_fifo.dut
+000195  point: type=toggle comment=o_rd_data[9]:0->1 hier=tb_async_fifo.dut
+000194  point: type=toggle comment=o_rd_data[9]:1->0 hier=tb_async_fifo.dut
 000016         output wire             o_fifo_empty        // FIFO empty flag
+000016  point: type=toggle comment=o_fifo_empty:0->1 hier=tb_async_fifo.dut
+000015  point: type=toggle comment=o_fifo_empty:1->0 hier=tb_async_fifo.dut
            );
        
            // Internal signals for address synchronization
 098879     wire [p_addr_width-1:0] w_wr_bin_addr, w_rd_bin_addr; // Binary addresses for write and read
+098879  point: type=toggle comment=w_wr_bin_addr[0]:0->1 hier=tb_async_fifo.dut
+098879  point: type=toggle comment=w_wr_bin_addr[0]:1->0 hier=tb_async_fifo.dut
+000096  point: type=toggle comment=w_wr_bin_addr[10]:0->1 hier=tb_async_fifo.dut
+000096  point: type=toggle comment=w_wr_bin_addr[10]:1->0 hier=tb_async_fifo.dut
+000048  point: type=toggle comment=w_wr_bin_addr[11]:0->1 hier=tb_async_fifo.dut
+000048  point: type=toggle comment=w_wr_bin_addr[11]:1->0 hier=tb_async_fifo.dut
+000024  point: type=toggle comment=w_wr_bin_addr[12]:0->1 hier=tb_async_fifo.dut
+000024  point: type=toggle comment=w_wr_bin_addr[12]:1->0 hier=tb_async_fifo.dut
+000012  point: type=toggle comment=w_wr_bin_addr[13]:0->1 hier=tb_async_fifo.dut
+000012  point: type=toggle comment=w_wr_bin_addr[13]:1->0 hier=tb_async_fifo.dut
+000006  point: type=toggle comment=w_wr_bin_addr[14]:0->1 hier=tb_async_fifo.dut
+000006  point: type=toggle comment=w_wr_bin_addr[14]:1->0 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_wr_bin_addr[15]:0->1 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_wr_bin_addr[15]:1->0 hier=tb_async_fifo.dut
+049438  point: type=toggle comment=w_wr_bin_addr[1]:0->1 hier=tb_async_fifo.dut
+049438  point: type=toggle comment=w_wr_bin_addr[1]:1->0 hier=tb_async_fifo.dut
+024719  point: type=toggle comment=w_wr_bin_addr[2]:0->1 hier=tb_async_fifo.dut
+024718  point: type=toggle comment=w_wr_bin_addr[2]:1->0 hier=tb_async_fifo.dut
+012359  point: type=toggle comment=w_wr_bin_addr[3]:0->1 hier=tb_async_fifo.dut
+012359  point: type=toggle comment=w_wr_bin_addr[3]:1->0 hier=tb_async_fifo.dut
+006179  point: type=toggle comment=w_wr_bin_addr[4]:0->1 hier=tb_async_fifo.dut
+006179  point: type=toggle comment=w_wr_bin_addr[4]:1->0 hier=tb_async_fifo.dut
+003090  point: type=toggle comment=w_wr_bin_addr[5]:0->1 hier=tb_async_fifo.dut
+003089  point: type=toggle comment=w_wr_bin_addr[5]:1->0 hier=tb_async_fifo.dut
+001545  point: type=toggle comment=w_wr_bin_addr[6]:0->1 hier=tb_async_fifo.dut
+001544  point: type=toggle comment=w_wr_bin_addr[6]:1->0 hier=tb_async_fifo.dut
+000772  point: type=toggle comment=w_wr_bin_addr[7]:0->1 hier=tb_async_fifo.dut
+000772  point: type=toggle comment=w_wr_bin_addr[7]:1->0 hier=tb_async_fifo.dut
+000386  point: type=toggle comment=w_wr_bin_addr[8]:0->1 hier=tb_async_fifo.dut
+000386  point: type=toggle comment=w_wr_bin_addr[8]:1->0 hier=tb_async_fifo.dut
+000193  point: type=toggle comment=w_wr_bin_addr[9]:0->1 hier=tb_async_fifo.dut
+000193  point: type=toggle comment=w_wr_bin_addr[9]:1->0 hier=tb_async_fifo.dut
+098876  point: type=toggle comment=w_rd_bin_addr[0]:0->1 hier=tb_async_fifo.dut
+098876  point: type=toggle comment=w_rd_bin_addr[0]:1->0 hier=tb_async_fifo.dut
+000096  point: type=toggle comment=w_rd_bin_addr[10]:0->1 hier=tb_async_fifo.dut
+000096  point: type=toggle comment=w_rd_bin_addr[10]:1->0 hier=tb_async_fifo.dut
+000048  point: type=toggle comment=w_rd_bin_addr[11]:0->1 hier=tb_async_fifo.dut
+000048  point: type=toggle comment=w_rd_bin_addr[11]:1->0 hier=tb_async_fifo.dut
+000024  point: type=toggle comment=w_rd_bin_addr[12]:0->1 hier=tb_async_fifo.dut
+000024  point: type=toggle comment=w_rd_bin_addr[12]:1->0 hier=tb_async_fifo.dut
+000012  point: type=toggle comment=w_rd_bin_addr[13]:0->1 hier=tb_async_fifo.dut
+000012  point: type=toggle comment=w_rd_bin_addr[13]:1->0 hier=tb_async_fifo.dut
+000006  point: type=toggle comment=w_rd_bin_addr[14]:0->1 hier=tb_async_fifo.dut
+000006  point: type=toggle comment=w_rd_bin_addr[14]:1->0 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_rd_bin_addr[15]:0->1 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_rd_bin_addr[15]:1->0 hier=tb_async_fifo.dut
+049436  point: type=toggle comment=w_rd_bin_addr[1]:0->1 hier=tb_async_fifo.dut
+049436  point: type=toggle comment=w_rd_bin_addr[1]:1->0 hier=tb_async_fifo.dut
+024717  point: type=toggle comment=w_rd_bin_addr[2]:0->1 hier=tb_async_fifo.dut
+024716  point: type=toggle comment=w_rd_bin_addr[2]:1->0 hier=tb_async_fifo.dut
+012358  point: type=toggle comment=w_rd_bin_addr[3]:0->1 hier=tb_async_fifo.dut
+012358  point: type=toggle comment=w_rd_bin_addr[3]:1->0 hier=tb_async_fifo.dut
+006179  point: type=toggle comment=w_rd_bin_addr[4]:0->1 hier=tb_async_fifo.dut
+006179  point: type=toggle comment=w_rd_bin_addr[4]:1->0 hier=tb_async_fifo.dut
+003090  point: type=toggle comment=w_rd_bin_addr[5]:0->1 hier=tb_async_fifo.dut
+003089  point: type=toggle comment=w_rd_bin_addr[5]:1->0 hier=tb_async_fifo.dut
+001545  point: type=toggle comment=w_rd_bin_addr[6]:0->1 hier=tb_async_fifo.dut
+001544  point: type=toggle comment=w_rd_bin_addr[6]:1->0 hier=tb_async_fifo.dut
+000772  point: type=toggle comment=w_rd_bin_addr[7]:0->1 hier=tb_async_fifo.dut
+000772  point: type=toggle comment=w_rd_bin_addr[7]:1->0 hier=tb_async_fifo.dut
+000386  point: type=toggle comment=w_rd_bin_addr[8]:0->1 hier=tb_async_fifo.dut
+000386  point: type=toggle comment=w_rd_bin_addr[8]:1->0 hier=tb_async_fifo.dut
+000193  point: type=toggle comment=w_rd_bin_addr[9]:0->1 hier=tb_async_fifo.dut
+000193  point: type=toggle comment=w_rd_bin_addr[9]:1->0 hier=tb_async_fifo.dut
 049442     wire [p_addr_width  :0] w_wr_grey_addr, w_rd_grey_addr; // Gray-coded addresses for write and read
+049442  point: type=toggle comment=w_wr_grey_addr[0]:0->1 hier=tb_async_fifo.dut
+049442  point: type=toggle comment=w_wr_grey_addr[0]:1->0 hier=tb_async_fifo.dut
+000048  point: type=toggle comment=w_wr_grey_addr[10]:0->1 hier=tb_async_fifo.dut
+000048  point: type=toggle comment=w_wr_grey_addr[10]:1->0 hier=tb_async_fifo.dut
+000024  point: type=toggle comment=w_wr_grey_addr[11]:0->1 hier=tb_async_fifo.dut
+000024  point: type=toggle comment=w_wr_grey_addr[11]:1->0 hier=tb_async_fifo.dut
+000012  point: type=toggle comment=w_wr_grey_addr[12]:0->1 hier=tb_async_fifo.dut
+000012  point: type=toggle comment=w_wr_grey_addr[12]:1->0 hier=tb_async_fifo.dut
+000006  point: type=toggle comment=w_wr_grey_addr[13]:0->1 hier=tb_async_fifo.dut
+000006  point: type=toggle comment=w_wr_grey_addr[13]:1->0 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_wr_grey_addr[14]:0->1 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_wr_grey_addr[14]:1->0 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_wr_grey_addr[15]:0->1 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_wr_grey_addr[15]:1->0 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_wr_grey_addr[16]:0->1 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_wr_grey_addr[16]:1->0 hier=tb_async_fifo.dut
+024722  point: type=toggle comment=w_wr_grey_addr[1]:0->1 hier=tb_async_fifo.dut
+024721  point: type=toggle comment=w_wr_grey_addr[1]:1->0 hier=tb_async_fifo.dut
+012362  point: type=toggle comment=w_wr_grey_addr[2]:0->1 hier=tb_async_fifo.dut
+012361  point: type=toggle comment=w_wr_grey_addr[2]:1->0 hier=tb_async_fifo.dut
+006181  point: type=toggle comment=w_wr_grey_addr[3]:0->1 hier=tb_async_fifo.dut
+006181  point: type=toggle comment=w_wr_grey_addr[3]:1->0 hier=tb_async_fifo.dut
+003091  point: type=toggle comment=w_wr_grey_addr[4]:0->1 hier=tb_async_fifo.dut
+003090  point: type=toggle comment=w_wr_grey_addr[4]:1->0 hier=tb_async_fifo.dut
+001545  point: type=toggle comment=w_wr_grey_addr[5]:0->1 hier=tb_async_fifo.dut
+001545  point: type=toggle comment=w_wr_grey_addr[5]:1->0 hier=tb_async_fifo.dut
+000773  point: type=toggle comment=w_wr_grey_addr[6]:0->1 hier=tb_async_fifo.dut
+000772  point: type=toggle comment=w_wr_grey_addr[6]:1->0 hier=tb_async_fifo.dut
+000386  point: type=toggle comment=w_wr_grey_addr[7]:0->1 hier=tb_async_fifo.dut
+000386  point: type=toggle comment=w_wr_grey_addr[7]:1->0 hier=tb_async_fifo.dut
+000193  point: type=toggle comment=w_wr_grey_addr[8]:0->1 hier=tb_async_fifo.dut
+000193  point: type=toggle comment=w_wr_grey_addr[8]:1->0 hier=tb_async_fifo.dut
+000097  point: type=toggle comment=w_wr_grey_addr[9]:0->1 hier=tb_async_fifo.dut
+000097  point: type=toggle comment=w_wr_grey_addr[9]:1->0 hier=tb_async_fifo.dut
+049440  point: type=toggle comment=w_rd_grey_addr[0]:0->1 hier=tb_async_fifo.dut
+049440  point: type=toggle comment=w_rd_grey_addr[0]:1->0 hier=tb_async_fifo.dut
+000048  point: type=toggle comment=w_rd_grey_addr[10]:0->1 hier=tb_async_fifo.dut
+000048  point: type=toggle comment=w_rd_grey_addr[10]:1->0 hier=tb_async_fifo.dut
+000024  point: type=toggle comment=w_rd_grey_addr[11]:0->1 hier=tb_async_fifo.dut
+000024  point: type=toggle comment=w_rd_grey_addr[11]:1->0 hier=tb_async_fifo.dut
+000012  point: type=toggle comment=w_rd_grey_addr[12]:0->1 hier=tb_async_fifo.dut
+000012  point: type=toggle comment=w_rd_grey_addr[12]:1->0 hier=tb_async_fifo.dut
+000006  point: type=toggle comment=w_rd_grey_addr[13]:0->1 hier=tb_async_fifo.dut
+000006  point: type=toggle comment=w_rd_grey_addr[13]:1->0 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_rd_grey_addr[14]:0->1 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_rd_grey_addr[14]:1->0 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_rd_grey_addr[15]:0->1 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_rd_grey_addr[15]:1->0 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_rd_grey_addr[16]:0->1 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_rd_grey_addr[16]:1->0 hier=tb_async_fifo.dut
+024721  point: type=toggle comment=w_rd_grey_addr[1]:0->1 hier=tb_async_fifo.dut
+024720  point: type=toggle comment=w_rd_grey_addr[1]:1->0 hier=tb_async_fifo.dut
+012360  point: type=toggle comment=w_rd_grey_addr[2]:0->1 hier=tb_async_fifo.dut
+012359  point: type=toggle comment=w_rd_grey_addr[2]:1->0 hier=tb_async_fifo.dut
+006180  point: type=toggle comment=w_rd_grey_addr[3]:0->1 hier=tb_async_fifo.dut
+006180  point: type=toggle comment=w_rd_grey_addr[3]:1->0 hier=tb_async_fifo.dut
+003091  point: type=toggle comment=w_rd_grey_addr[4]:0->1 hier=tb_async_fifo.dut
+003090  point: type=toggle comment=w_rd_grey_addr[4]:1->0 hier=tb_async_fifo.dut
+001545  point: type=toggle comment=w_rd_grey_addr[5]:0->1 hier=tb_async_fifo.dut
+001545  point: type=toggle comment=w_rd_grey_addr[5]:1->0 hier=tb_async_fifo.dut
+000773  point: type=toggle comment=w_rd_grey_addr[6]:0->1 hier=tb_async_fifo.dut
+000772  point: type=toggle comment=w_rd_grey_addr[6]:1->0 hier=tb_async_fifo.dut
+000386  point: type=toggle comment=w_rd_grey_addr[7]:0->1 hier=tb_async_fifo.dut
+000386  point: type=toggle comment=w_rd_grey_addr[7]:1->0 hier=tb_async_fifo.dut
+000193  point: type=toggle comment=w_rd_grey_addr[8]:0->1 hier=tb_async_fifo.dut
+000193  point: type=toggle comment=w_rd_grey_addr[8]:1->0 hier=tb_async_fifo.dut
+000097  point: type=toggle comment=w_rd_grey_addr[9]:0->1 hier=tb_async_fifo.dut
+000097  point: type=toggle comment=w_rd_grey_addr[9]:1->0 hier=tb_async_fifo.dut
 049442     wire [p_addr_width  :0] w_rd_ptr_sync, w_wr_ptr_sync;   // Synchronized pointers
+049440  point: type=toggle comment=w_rd_ptr_sync[0]:0->1 hier=tb_async_fifo.dut
+049440  point: type=toggle comment=w_rd_ptr_sync[0]:1->0 hier=tb_async_fifo.dut
+000048  point: type=toggle comment=w_rd_ptr_sync[10]:0->1 hier=tb_async_fifo.dut
+000048  point: type=toggle comment=w_rd_ptr_sync[10]:1->0 hier=tb_async_fifo.dut
+000024  point: type=toggle comment=w_rd_ptr_sync[11]:0->1 hier=tb_async_fifo.dut
+000024  point: type=toggle comment=w_rd_ptr_sync[11]:1->0 hier=tb_async_fifo.dut
+000012  point: type=toggle comment=w_rd_ptr_sync[12]:0->1 hier=tb_async_fifo.dut
+000012  point: type=toggle comment=w_rd_ptr_sync[12]:1->0 hier=tb_async_fifo.dut
+000006  point: type=toggle comment=w_rd_ptr_sync[13]:0->1 hier=tb_async_fifo.dut
+000006  point: type=toggle comment=w_rd_ptr_sync[13]:1->0 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_rd_ptr_sync[14]:0->1 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_rd_ptr_sync[14]:1->0 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_rd_ptr_sync[15]:0->1 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_rd_ptr_sync[15]:1->0 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_rd_ptr_sync[16]:0->1 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_rd_ptr_sync[16]:1->0 hier=tb_async_fifo.dut
+024721  point: type=toggle comment=w_rd_ptr_sync[1]:0->1 hier=tb_async_fifo.dut
+024720  point: type=toggle comment=w_rd_ptr_sync[1]:1->0 hier=tb_async_fifo.dut
+012359  point: type=toggle comment=w_rd_ptr_sync[2]:0->1 hier=tb_async_fifo.dut
+012359  point: type=toggle comment=w_rd_ptr_sync[2]:1->0 hier=tb_async_fifo.dut
+006180  point: type=toggle comment=w_rd_ptr_sync[3]:0->1 hier=tb_async_fifo.dut
+006180  point: type=toggle comment=w_rd_ptr_sync[3]:1->0 hier=tb_async_fifo.dut
+003091  point: type=toggle comment=w_rd_ptr_sync[4]:0->1 hier=tb_async_fifo.dut
+003090  point: type=toggle comment=w_rd_ptr_sync[4]:1->0 hier=tb_async_fifo.dut
+001545  point: type=toggle comment=w_rd_ptr_sync[5]:0->1 hier=tb_async_fifo.dut
+001545  point: type=toggle comment=w_rd_ptr_sync[5]:1->0 hier=tb_async_fifo.dut
+000773  point: type=toggle comment=w_rd_ptr_sync[6]:0->1 hier=tb_async_fifo.dut
+000772  point: type=toggle comment=w_rd_ptr_sync[6]:1->0 hier=tb_async_fifo.dut
+000386  point: type=toggle comment=w_rd_ptr_sync[7]:0->1 hier=tb_async_fifo.dut
+000386  point: type=toggle comment=w_rd_ptr_sync[7]:1->0 hier=tb_async_fifo.dut
+000193  point: type=toggle comment=w_rd_ptr_sync[8]:0->1 hier=tb_async_fifo.dut
+000193  point: type=toggle comment=w_rd_ptr_sync[8]:1->0 hier=tb_async_fifo.dut
+000097  point: type=toggle comment=w_rd_ptr_sync[9]:0->1 hier=tb_async_fifo.dut
+000097  point: type=toggle comment=w_rd_ptr_sync[9]:1->0 hier=tb_async_fifo.dut
+049442  point: type=toggle comment=w_wr_ptr_sync[0]:0->1 hier=tb_async_fifo.dut
+049442  point: type=toggle comment=w_wr_ptr_sync[0]:1->0 hier=tb_async_fifo.dut
+000048  point: type=toggle comment=w_wr_ptr_sync[10]:0->1 hier=tb_async_fifo.dut
+000048  point: type=toggle comment=w_wr_ptr_sync[10]:1->0 hier=tb_async_fifo.dut
+000024  point: type=toggle comment=w_wr_ptr_sync[11]:0->1 hier=tb_async_fifo.dut
+000024  point: type=toggle comment=w_wr_ptr_sync[11]:1->0 hier=tb_async_fifo.dut
+000012  point: type=toggle comment=w_wr_ptr_sync[12]:0->1 hier=tb_async_fifo.dut
+000012  point: type=toggle comment=w_wr_ptr_sync[12]:1->0 hier=tb_async_fifo.dut
+000006  point: type=toggle comment=w_wr_ptr_sync[13]:0->1 hier=tb_async_fifo.dut
+000006  point: type=toggle comment=w_wr_ptr_sync[13]:1->0 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_wr_ptr_sync[14]:0->1 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_wr_ptr_sync[14]:1->0 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_wr_ptr_sync[15]:0->1 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_wr_ptr_sync[15]:1->0 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_wr_ptr_sync[16]:0->1 hier=tb_async_fifo.dut
+000003  point: type=toggle comment=w_wr_ptr_sync[16]:1->0 hier=tb_async_fifo.dut
+024724  point: type=toggle comment=w_wr_ptr_sync[1]:0->1 hier=tb_async_fifo.dut
+024723  point: type=toggle comment=w_wr_ptr_sync[1]:1->0 hier=tb_async_fifo.dut
+012362  point: type=toggle comment=w_wr_ptr_sync[2]:0->1 hier=tb_async_fifo.dut
+012361  point: type=toggle comment=w_wr_ptr_sync[2]:1->0 hier=tb_async_fifo.dut
+006181  point: type=toggle comment=w_wr_ptr_sync[3]:0->1 hier=tb_async_fifo.dut
+006181  point: type=toggle comment=w_wr_ptr_sync[3]:1->0 hier=tb_async_fifo.dut
+003091  point: type=toggle comment=w_wr_ptr_sync[4]:0->1 hier=tb_async_fifo.dut
+003090  point: type=toggle comment=w_wr_ptr_sync[4]:1->0 hier=tb_async_fifo.dut
+001545  point: type=toggle comment=w_wr_ptr_sync[5]:0->1 hier=tb_async_fifo.dut
+001545  point: type=toggle comment=w_wr_ptr_sync[5]:1->0 hier=tb_async_fifo.dut
+000773  point: type=toggle comment=w_wr_ptr_sync[6]:0->1 hier=tb_async_fifo.dut
+000772  point: type=toggle comment=w_wr_ptr_sync[6]:1->0 hier=tb_async_fifo.dut
+000386  point: type=toggle comment=w_wr_ptr_sync[7]:0->1 hier=tb_async_fifo.dut
+000386  point: type=toggle comment=w_wr_ptr_sync[7]:1->0 hier=tb_async_fifo.dut
+000193  point: type=toggle comment=w_wr_ptr_sync[8]:0->1 hier=tb_async_fifo.dut
+000193  point: type=toggle comment=w_wr_ptr_sync[8]:1->0 hier=tb_async_fifo.dut
+000097  point: type=toggle comment=w_wr_ptr_sync[9]:0->1 hier=tb_async_fifo.dut
+000097  point: type=toggle comment=w_wr_ptr_sync[9]:1->0 hier=tb_async_fifo.dut
        
            // Synchronize the read pointer from read domain to write domain
            read_to_write_pointer_sync
            #(p_addr_width)
            read_to_write_pointer_sync_inst (
                .o_rd_ptr_sync (w_rd_ptr_sync),    // Output synchronized read pointer
                .i_rd_grey_addr (w_rd_grey_addr),  // Input Gray-coded read address
                .i_wr_clk     (i_wr_clk),          // Write clock
                .i_wr_rst_n   (i_wr_rst_n)         // Write reset (active low)
            );
        
            // Synchronize the write pointer from write domain to read domain
            write_to_read_pointer_sync
            #(p_addr_width)
            write_to_read_pointer_sync_inst (
                .i_rd_clk     (i_rd_clk),          // Read clock
                .i_rd_rst_n   (i_rd_rst_n),        // Read reset (active low)
                .i_wr_grey_addr (w_wr_grey_addr),  // Input Gray-coded write address
                .o_wr_ptr_sync (w_wr_ptr_sync)     // Output synchronized write pointer
            );
        
            // Handle the write requests and manage the write pointer
            wptr_full
            #(p_addr_width)
            wptr_full_inst (
                .i_wr_clk     (i_wr_clk),          // Write clock
                .i_wr_rst_n   (i_wr_rst_n),        // Write reset (active low)
                .i_wr_en     (i_wr_en),            // Write enable
                .i_rd_ptr_sync (w_rd_ptr_sync),    // Synchronized read pointer
                .o_fifo_full    (o_fifo_full),     // FIFO full flag
                .o_wr_bin_addr    (w_wr_bin_addr), // Binary write address
                .o_wr_grey_addr     (w_wr_grey_addr) // Gray-coded write address
            );
        
            // Dual-port RAM for FIFO memory
            fifo_memory
            #(p_data_width, p_addr_width)
            fifo_memory_inst (
                .i_wr_clk   (i_wr_clk),            // Write clock
                .i_wr_clk_en (i_wr_en),            // Write clock enable
                .i_wr_addr  (w_wr_bin_addr),       // Write address
                .i_wr_data  (i_wr_data),           // Write data
                .i_wr_full  (o_fifo_full),         // FIFO full flag (write side)
                .i_rd_clk   (i_rd_clk),            // Read clock
                .i_rd_clk_en (i_rd_en),            // Read clock enable
                .i_rd_addr  (w_rd_bin_addr),       // Read address
                .o_rd_data  (o_rd_data)            // Read data output
            );
        
            // Handle the read requests and manage the read pointer
            rptr_empty
            #(p_addr_width)
            rptr_empty_inst (
                .i_rd_clk     (i_rd_clk),          // Read clock
                .i_rd_rst_n   (i_rd_rst_n),        // Read reset (active low)
                .i_rd_en     (i_rd_en),            // Read enable
                .i_wr_ptr_sync (w_wr_ptr_sync),    // Synchronized write pointer
                .o_fifo_empty   (o_fifo_empty),    // FIFO empty flag
                .o_rd_bin_addr    (w_rd_bin_addr), // Binary read address
                .o_rd_grey_addr     (w_rd_grey_addr) // Gray-coded read address
            );
        
        endmodule
