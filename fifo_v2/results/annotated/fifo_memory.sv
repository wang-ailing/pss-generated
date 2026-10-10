//      // verilator_coverage annotation
        module fifo_memory
            #(
                parameter p_data_width = 32,    // Memory data word width
                parameter p_addr_width = 16     // Number of memory address bits
            ) (
 474361         input  wire                i_wr_clk,       // Write clock
+474361  point: type=toggle comment=i_wr_clk:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+474360  point: type=toggle comment=i_wr_clk:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
 000015         input  wire                i_wr_clk_en,    // Write clock enable
+000015  point: type=toggle comment=i_wr_clk_en:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000015  point: type=toggle comment=i_wr_clk_en:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
 098879         input  wire [p_addr_width-1:0] i_wr_addr,    // Write address
+098879  point: type=toggle comment=i_wr_addr[0]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+098879  point: type=toggle comment=i_wr_addr[0]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000096  point: type=toggle comment=i_wr_addr[10]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000096  point: type=toggle comment=i_wr_addr[10]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000048  point: type=toggle comment=i_wr_addr[11]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000048  point: type=toggle comment=i_wr_addr[11]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000024  point: type=toggle comment=i_wr_addr[12]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000024  point: type=toggle comment=i_wr_addr[12]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000012  point: type=toggle comment=i_wr_addr[13]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000012  point: type=toggle comment=i_wr_addr[13]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000006  point: type=toggle comment=i_wr_addr[14]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000006  point: type=toggle comment=i_wr_addr[14]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000003  point: type=toggle comment=i_wr_addr[15]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000003  point: type=toggle comment=i_wr_addr[15]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+049438  point: type=toggle comment=i_wr_addr[1]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+049438  point: type=toggle comment=i_wr_addr[1]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+024719  point: type=toggle comment=i_wr_addr[2]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+024718  point: type=toggle comment=i_wr_addr[2]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+012359  point: type=toggle comment=i_wr_addr[3]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+012359  point: type=toggle comment=i_wr_addr[3]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+006179  point: type=toggle comment=i_wr_addr[4]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+006179  point: type=toggle comment=i_wr_addr[4]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+003090  point: type=toggle comment=i_wr_addr[5]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+003089  point: type=toggle comment=i_wr_addr[5]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+001545  point: type=toggle comment=i_wr_addr[6]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+001544  point: type=toggle comment=i_wr_addr[6]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000772  point: type=toggle comment=i_wr_addr[7]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000772  point: type=toggle comment=i_wr_addr[7]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000386  point: type=toggle comment=i_wr_addr[8]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000386  point: type=toggle comment=i_wr_addr[8]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000193  point: type=toggle comment=i_wr_addr[9]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000193  point: type=toggle comment=i_wr_addr[9]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
~098874         input  wire [p_data_width-1:0] i_wr_data,    // Write data
+098874  point: type=toggle comment=i_wr_data[0]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+098873  point: type=toggle comment=i_wr_data[0]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000097  point: type=toggle comment=i_wr_data[10]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000097  point: type=toggle comment=i_wr_data[10]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000049  point: type=toggle comment=i_wr_data[11]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000049  point: type=toggle comment=i_wr_data[11]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000025  point: type=toggle comment=i_wr_data[12]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000025  point: type=toggle comment=i_wr_data[12]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000013  point: type=toggle comment=i_wr_data[13]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000013  point: type=toggle comment=i_wr_data[13]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000006  point: type=toggle comment=i_wr_data[14]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000006  point: type=toggle comment=i_wr_data[14]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000004  point: type=toggle comment=i_wr_data[15]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000004  point: type=toggle comment=i_wr_data[15]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000003  point: type=toggle comment=i_wr_data[16]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000003  point: type=toggle comment=i_wr_data[16]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=i_wr_data[17]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=i_wr_data[17]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=i_wr_data[18]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=i_wr_data[18]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=i_wr_data[19]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=i_wr_data[19]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+049438  point: type=toggle comment=i_wr_data[1]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+049437  point: type=toggle comment=i_wr_data[1]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=i_wr_data[20]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=i_wr_data[20]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=i_wr_data[21]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=i_wr_data[21]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=i_wr_data[22]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=i_wr_data[22]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=i_wr_data[23]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=i_wr_data[23]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=i_wr_data[24]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=i_wr_data[24]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=i_wr_data[25]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=i_wr_data[25]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=i_wr_data[26]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=i_wr_data[26]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=i_wr_data[27]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=i_wr_data[27]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=i_wr_data[28]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=i_wr_data[28]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=i_wr_data[29]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=i_wr_data[29]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+024720  point: type=toggle comment=i_wr_data[2]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+024719  point: type=toggle comment=i_wr_data[2]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=i_wr_data[30]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=i_wr_data[30]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=i_wr_data[31]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=i_wr_data[31]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+012360  point: type=toggle comment=i_wr_data[3]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+012360  point: type=toggle comment=i_wr_data[3]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+006179  point: type=toggle comment=i_wr_data[4]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+006179  point: type=toggle comment=i_wr_data[4]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+003093  point: type=toggle comment=i_wr_data[5]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+003092  point: type=toggle comment=i_wr_data[5]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+001548  point: type=toggle comment=i_wr_data[6]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+001547  point: type=toggle comment=i_wr_data[6]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000776  point: type=toggle comment=i_wr_data[7]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000775  point: type=toggle comment=i_wr_data[7]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000388  point: type=toggle comment=i_wr_data[8]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000387  point: type=toggle comment=i_wr_data[8]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000195  point: type=toggle comment=i_wr_data[9]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000194  point: type=toggle comment=i_wr_data[9]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
 000003         input  wire                i_wr_full,      // Write full flag
+000003  point: type=toggle comment=i_wr_full:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000003  point: type=toggle comment=i_wr_full:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
 338829         input  wire                i_rd_clk,       // Read clock
+338829  point: type=toggle comment=i_rd_clk:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+338829  point: type=toggle comment=i_rd_clk:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
 000018         input  wire                i_rd_clk_en,    // Read clock enable
+000018  point: type=toggle comment=i_rd_clk_en:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000018  point: type=toggle comment=i_rd_clk_en:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
 098876         input  wire [p_addr_width-1:0] i_rd_addr,    // Read address
+098876  point: type=toggle comment=i_rd_addr[0]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+098876  point: type=toggle comment=i_rd_addr[0]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000096  point: type=toggle comment=i_rd_addr[10]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000096  point: type=toggle comment=i_rd_addr[10]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000048  point: type=toggle comment=i_rd_addr[11]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000048  point: type=toggle comment=i_rd_addr[11]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000024  point: type=toggle comment=i_rd_addr[12]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000024  point: type=toggle comment=i_rd_addr[12]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000012  point: type=toggle comment=i_rd_addr[13]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000012  point: type=toggle comment=i_rd_addr[13]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000006  point: type=toggle comment=i_rd_addr[14]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000006  point: type=toggle comment=i_rd_addr[14]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000003  point: type=toggle comment=i_rd_addr[15]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000003  point: type=toggle comment=i_rd_addr[15]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+049436  point: type=toggle comment=i_rd_addr[1]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+049436  point: type=toggle comment=i_rd_addr[1]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+024717  point: type=toggle comment=i_rd_addr[2]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+024716  point: type=toggle comment=i_rd_addr[2]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+012358  point: type=toggle comment=i_rd_addr[3]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+012358  point: type=toggle comment=i_rd_addr[3]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+006179  point: type=toggle comment=i_rd_addr[4]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+006179  point: type=toggle comment=i_rd_addr[4]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+003090  point: type=toggle comment=i_rd_addr[5]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+003089  point: type=toggle comment=i_rd_addr[5]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+001545  point: type=toggle comment=i_rd_addr[6]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+001544  point: type=toggle comment=i_rd_addr[6]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000772  point: type=toggle comment=i_rd_addr[7]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000772  point: type=toggle comment=i_rd_addr[7]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000386  point: type=toggle comment=i_rd_addr[8]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000386  point: type=toggle comment=i_rd_addr[8]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000193  point: type=toggle comment=i_rd_addr[9]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000193  point: type=toggle comment=i_rd_addr[9]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
~098869         output wire [p_data_width-1:0] o_rd_data     // Read data output
+098869  point: type=toggle comment=o_rd_data[0]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+098868  point: type=toggle comment=o_rd_data[0]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000097  point: type=toggle comment=o_rd_data[10]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000097  point: type=toggle comment=o_rd_data[10]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000049  point: type=toggle comment=o_rd_data[11]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000049  point: type=toggle comment=o_rd_data[11]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000025  point: type=toggle comment=o_rd_data[12]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000025  point: type=toggle comment=o_rd_data[12]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000013  point: type=toggle comment=o_rd_data[13]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000013  point: type=toggle comment=o_rd_data[13]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000006  point: type=toggle comment=o_rd_data[14]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000006  point: type=toggle comment=o_rd_data[14]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000004  point: type=toggle comment=o_rd_data[15]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000004  point: type=toggle comment=o_rd_data[15]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000003  point: type=toggle comment=o_rd_data[16]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000003  point: type=toggle comment=o_rd_data[16]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=o_rd_data[17]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=o_rd_data[17]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=o_rd_data[18]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=o_rd_data[18]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=o_rd_data[19]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=o_rd_data[19]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+049437  point: type=toggle comment=o_rd_data[1]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+049436  point: type=toggle comment=o_rd_data[1]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=o_rd_data[20]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=o_rd_data[20]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=o_rd_data[21]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=o_rd_data[21]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=o_rd_data[22]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=o_rd_data[22]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=o_rd_data[23]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=o_rd_data[23]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=o_rd_data[24]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=o_rd_data[24]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=o_rd_data[25]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=o_rd_data[25]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=o_rd_data[26]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=o_rd_data[26]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=o_rd_data[27]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=o_rd_data[27]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=o_rd_data[28]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=o_rd_data[28]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=o_rd_data[29]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=o_rd_data[29]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+024719  point: type=toggle comment=o_rd_data[2]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+024718  point: type=toggle comment=o_rd_data[2]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=o_rd_data[30]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=o_rd_data[30]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=o_rd_data[31]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=o_rd_data[31]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+012360  point: type=toggle comment=o_rd_data[3]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+012360  point: type=toggle comment=o_rd_data[3]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+006179  point: type=toggle comment=o_rd_data[4]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+006179  point: type=toggle comment=o_rd_data[4]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+003093  point: type=toggle comment=o_rd_data[5]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+003092  point: type=toggle comment=o_rd_data[5]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+001548  point: type=toggle comment=o_rd_data[6]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+001547  point: type=toggle comment=o_rd_data[6]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000776  point: type=toggle comment=o_rd_data[7]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000775  point: type=toggle comment=o_rd_data[7]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000388  point: type=toggle comment=o_rd_data[8]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000387  point: type=toggle comment=o_rd_data[8]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000195  point: type=toggle comment=o_rd_data[9]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000194  point: type=toggle comment=o_rd_data[9]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
            );
        
            // Calculate the depth of the memory based on the address size
            localparam p_depth = 1 << p_addr_width;
        
            // Define the memory array with depth p_depth and data width p_data_width
            reg [p_data_width-1:0] r_memory [0:p_depth-1];
~098869     reg [p_data_width-1:0] r_rd_data;  // Register to hold read data
+098869  point: type=toggle comment=r_rd_data[0]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+098868  point: type=toggle comment=r_rd_data[0]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000097  point: type=toggle comment=r_rd_data[10]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000097  point: type=toggle comment=r_rd_data[10]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000049  point: type=toggle comment=r_rd_data[11]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000049  point: type=toggle comment=r_rd_data[11]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000025  point: type=toggle comment=r_rd_data[12]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000025  point: type=toggle comment=r_rd_data[12]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000013  point: type=toggle comment=r_rd_data[13]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000013  point: type=toggle comment=r_rd_data[13]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000006  point: type=toggle comment=r_rd_data[14]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000006  point: type=toggle comment=r_rd_data[14]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000004  point: type=toggle comment=r_rd_data[15]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000004  point: type=toggle comment=r_rd_data[15]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000003  point: type=toggle comment=r_rd_data[16]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000003  point: type=toggle comment=r_rd_data[16]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=r_rd_data[17]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=r_rd_data[17]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=r_rd_data[18]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=r_rd_data[18]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=r_rd_data[19]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=r_rd_data[19]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+049437  point: type=toggle comment=r_rd_data[1]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+049436  point: type=toggle comment=r_rd_data[1]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=r_rd_data[20]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=r_rd_data[20]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=r_rd_data[21]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=r_rd_data[21]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=r_rd_data[22]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=r_rd_data[22]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=r_rd_data[23]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=r_rd_data[23]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=r_rd_data[24]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=r_rd_data[24]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=r_rd_data[25]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=r_rd_data[25]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=r_rd_data[26]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=r_rd_data[26]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=r_rd_data[27]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=r_rd_data[27]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=r_rd_data[28]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=r_rd_data[28]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=r_rd_data[29]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
-000000  point: type=toggle comment=r_rd_data[29]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+024719  point: type=toggle comment=r_rd_data[2]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+024718  point: type=toggle comment=r_rd_data[2]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=r_rd_data[30]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=r_rd_data[30]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=r_rd_data[31]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000001  point: type=toggle comment=r_rd_data[31]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+012360  point: type=toggle comment=r_rd_data[3]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+012360  point: type=toggle comment=r_rd_data[3]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+006179  point: type=toggle comment=r_rd_data[4]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+006179  point: type=toggle comment=r_rd_data[4]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+003093  point: type=toggle comment=r_rd_data[5]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+003092  point: type=toggle comment=r_rd_data[5]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+001548  point: type=toggle comment=r_rd_data[6]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+001547  point: type=toggle comment=r_rd_data[6]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000776  point: type=toggle comment=r_rd_data[7]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000775  point: type=toggle comment=r_rd_data[7]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000388  point: type=toggle comment=r_rd_data[8]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000387  point: type=toggle comment=r_rd_data[8]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
+000195  point: type=toggle comment=r_rd_data[9]:0->1 hier=tb_async_fifo.dut.fifo_memory_inst
+000194  point: type=toggle comment=r_rd_data[9]:1->0 hier=tb_async_fifo.dut.fifo_memory_inst
        
            // Write operation
 474361     always @(posedge i_wr_clk) begin
+474361  point: type=line comment=block hier=tb_async_fifo.dut.fifo_memory_inst
 276609         if (i_wr_clk_en && !i_wr_full)          // If write is enabled and FIFO is not full
+276609  point: type=branch comment=else hier=tb_async_fifo.dut.fifo_memory_inst
+276608  point: type=expr comment=(i_wr_clk_en==0) => 0 hier=tb_async_fifo.dut.fifo_memory_inst
+197752  point: type=expr comment=(i_wr_clk_en==1 && i_wr_full==0) => 1 hier=tb_async_fifo.dut.fifo_memory_inst
+000020  point: type=expr comment=(i_wr_full==1) => 0 hier=tb_async_fifo.dut.fifo_memory_inst
+197752  point: type=branch comment=if hier=tb_async_fifo.dut.fifo_memory_inst
 197752             r_memory[i_wr_addr] <= i_wr_data;   // Write data to memory at specified address
+197752  point: type=branch comment=if hier=tb_async_fifo.dut.fifo_memory_inst
            end
        
            // Read operation
 338829     always @(posedge i_rd_clk) begin
+338829  point: type=line comment=block hier=tb_async_fifo.dut.fifo_memory_inst
 197750         if (i_rd_clk_en)                        // If read is enabled
+141079  point: type=branch comment=else hier=tb_async_fifo.dut.fifo_memory_inst
+197750  point: type=branch comment=if hier=tb_async_fifo.dut.fifo_memory_inst
 197750             r_rd_data <= r_memory[i_rd_addr];   // Read data from memory at specified address
+197750  point: type=branch comment=if hier=tb_async_fifo.dut.fifo_memory_inst
            end
        
            // Assign the read data register to the output
            assign o_rd_data = r_rd_data;
        
        endmodule
