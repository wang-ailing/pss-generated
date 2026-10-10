//      // verilator_coverage annotation
        module read_to_write_pointer_sync 
            #(
                parameter p_addr_width = 16  // Parameter to define the address width of the FIFO
            )(
 474361         input  wire              i_wr_clk,           // Write clock
+474361  point: type=toggle comment=i_wr_clk:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+474360  point: type=toggle comment=i_wr_clk:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
 000012         input  wire              i_wr_rst_n,         // Write reset (active low)
+000012  point: type=toggle comment=i_wr_rst_n:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000011  point: type=toggle comment=i_wr_rst_n:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
 049440         input  wire [p_addr_width:0] i_rd_grey_addr, // Gray-coded read address from the read clock domain
+049440  point: type=toggle comment=i_rd_grey_addr[0]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+049440  point: type=toggle comment=i_rd_grey_addr[0]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000048  point: type=toggle comment=i_rd_grey_addr[10]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000048  point: type=toggle comment=i_rd_grey_addr[10]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000024  point: type=toggle comment=i_rd_grey_addr[11]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000024  point: type=toggle comment=i_rd_grey_addr[11]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000012  point: type=toggle comment=i_rd_grey_addr[12]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000012  point: type=toggle comment=i_rd_grey_addr[12]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000006  point: type=toggle comment=i_rd_grey_addr[13]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000006  point: type=toggle comment=i_rd_grey_addr[13]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000003  point: type=toggle comment=i_rd_grey_addr[14]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000003  point: type=toggle comment=i_rd_grey_addr[14]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000003  point: type=toggle comment=i_rd_grey_addr[15]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000003  point: type=toggle comment=i_rd_grey_addr[15]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000003  point: type=toggle comment=i_rd_grey_addr[16]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000003  point: type=toggle comment=i_rd_grey_addr[16]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+024721  point: type=toggle comment=i_rd_grey_addr[1]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+024720  point: type=toggle comment=i_rd_grey_addr[1]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+012360  point: type=toggle comment=i_rd_grey_addr[2]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+012359  point: type=toggle comment=i_rd_grey_addr[2]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+006180  point: type=toggle comment=i_rd_grey_addr[3]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+006180  point: type=toggle comment=i_rd_grey_addr[3]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+003091  point: type=toggle comment=i_rd_grey_addr[4]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+003090  point: type=toggle comment=i_rd_grey_addr[4]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+001545  point: type=toggle comment=i_rd_grey_addr[5]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+001545  point: type=toggle comment=i_rd_grey_addr[5]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000773  point: type=toggle comment=i_rd_grey_addr[6]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000772  point: type=toggle comment=i_rd_grey_addr[6]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000386  point: type=toggle comment=i_rd_grey_addr[7]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000386  point: type=toggle comment=i_rd_grey_addr[7]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000193  point: type=toggle comment=i_rd_grey_addr[8]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000193  point: type=toggle comment=i_rd_grey_addr[8]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000097  point: type=toggle comment=i_rd_grey_addr[9]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000097  point: type=toggle comment=i_rd_grey_addr[9]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
 049440         output reg  [p_addr_width:0] o_rd_ptr_sync   // Synchronized read pointer in the write clock domain
+049440  point: type=toggle comment=o_rd_ptr_sync[0]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+049440  point: type=toggle comment=o_rd_ptr_sync[0]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000048  point: type=toggle comment=o_rd_ptr_sync[10]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000048  point: type=toggle comment=o_rd_ptr_sync[10]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000024  point: type=toggle comment=o_rd_ptr_sync[11]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000024  point: type=toggle comment=o_rd_ptr_sync[11]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000012  point: type=toggle comment=o_rd_ptr_sync[12]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000012  point: type=toggle comment=o_rd_ptr_sync[12]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000006  point: type=toggle comment=o_rd_ptr_sync[13]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000006  point: type=toggle comment=o_rd_ptr_sync[13]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000003  point: type=toggle comment=o_rd_ptr_sync[14]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000003  point: type=toggle comment=o_rd_ptr_sync[14]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000003  point: type=toggle comment=o_rd_ptr_sync[15]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000003  point: type=toggle comment=o_rd_ptr_sync[15]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000003  point: type=toggle comment=o_rd_ptr_sync[16]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000003  point: type=toggle comment=o_rd_ptr_sync[16]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+024721  point: type=toggle comment=o_rd_ptr_sync[1]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+024720  point: type=toggle comment=o_rd_ptr_sync[1]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+012359  point: type=toggle comment=o_rd_ptr_sync[2]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+012359  point: type=toggle comment=o_rd_ptr_sync[2]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+006180  point: type=toggle comment=o_rd_ptr_sync[3]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+006180  point: type=toggle comment=o_rd_ptr_sync[3]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+003091  point: type=toggle comment=o_rd_ptr_sync[4]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+003090  point: type=toggle comment=o_rd_ptr_sync[4]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+001545  point: type=toggle comment=o_rd_ptr_sync[5]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+001545  point: type=toggle comment=o_rd_ptr_sync[5]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000773  point: type=toggle comment=o_rd_ptr_sync[6]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000772  point: type=toggle comment=o_rd_ptr_sync[6]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000386  point: type=toggle comment=o_rd_ptr_sync[7]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000386  point: type=toggle comment=o_rd_ptr_sync[7]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000193  point: type=toggle comment=o_rd_ptr_sync[8]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000193  point: type=toggle comment=o_rd_ptr_sync[8]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000097  point: type=toggle comment=o_rd_ptr_sync[9]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000097  point: type=toggle comment=o_rd_ptr_sync[9]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
            );
        
            // Internal register to hold the intermediate synchronized read pointer
 049441     reg [p_addr_width:0] r_rd_ptr_ff;
+049441  point: type=toggle comment=r_rd_ptr_ff[0]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+049441  point: type=toggle comment=r_rd_ptr_ff[0]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000048  point: type=toggle comment=r_rd_ptr_ff[10]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000048  point: type=toggle comment=r_rd_ptr_ff[10]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000024  point: type=toggle comment=r_rd_ptr_ff[11]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000024  point: type=toggle comment=r_rd_ptr_ff[11]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000012  point: type=toggle comment=r_rd_ptr_ff[12]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000012  point: type=toggle comment=r_rd_ptr_ff[12]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000006  point: type=toggle comment=r_rd_ptr_ff[13]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000006  point: type=toggle comment=r_rd_ptr_ff[13]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000003  point: type=toggle comment=r_rd_ptr_ff[14]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000003  point: type=toggle comment=r_rd_ptr_ff[14]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000003  point: type=toggle comment=r_rd_ptr_ff[15]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000003  point: type=toggle comment=r_rd_ptr_ff[15]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000003  point: type=toggle comment=r_rd_ptr_ff[16]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000003  point: type=toggle comment=r_rd_ptr_ff[16]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+024721  point: type=toggle comment=r_rd_ptr_ff[1]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+024720  point: type=toggle comment=r_rd_ptr_ff[1]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+012360  point: type=toggle comment=r_rd_ptr_ff[2]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+012359  point: type=toggle comment=r_rd_ptr_ff[2]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+006180  point: type=toggle comment=r_rd_ptr_ff[3]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+006180  point: type=toggle comment=r_rd_ptr_ff[3]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+003091  point: type=toggle comment=r_rd_ptr_ff[4]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+003090  point: type=toggle comment=r_rd_ptr_ff[4]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+001545  point: type=toggle comment=r_rd_ptr_ff[5]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+001545  point: type=toggle comment=r_rd_ptr_ff[5]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000773  point: type=toggle comment=r_rd_ptr_ff[6]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000772  point: type=toggle comment=r_rd_ptr_ff[6]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000386  point: type=toggle comment=r_rd_ptr_ff[7]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000386  point: type=toggle comment=r_rd_ptr_ff[7]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000193  point: type=toggle comment=r_rd_ptr_ff[8]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000193  point: type=toggle comment=r_rd_ptr_ff[8]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000097  point: type=toggle comment=r_rd_ptr_ff[9]:0->1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000097  point: type=toggle comment=r_rd_ptr_ff[9]:1->0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
        
            // Always block for synchronizing the read pointer to the write clock domain
 474372     always @(posedge i_wr_clk or negedge i_wr_rst_n) 
+474372  point: type=line comment=block hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
 474372     begin
+474372  point: type=line comment=block hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
 474212         if (!i_wr_rst_n) begin
+474212  point: type=branch comment=else hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000160  point: type=expr comment=(i_wr_rst_n==0) => 1 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+474212  point: type=expr comment=(i_wr_rst_n==1) => 0 hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
+000160  point: type=branch comment=if hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
                    // If reset is asserted (active low), reset the synchronized pointers to 0
 000160             o_rd_ptr_sync <= {p_addr_width+1{1'b0}};
+000160  point: type=branch comment=if hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
 000160             r_rd_ptr_ff <= {p_addr_width+1{1'b0}};
+000160  point: type=branch comment=if hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
 474212         end else begin
+474212  point: type=branch comment=else hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
                    // If reset is not asserted, synchronize the read pointer to the write clock domain
 474212             r_rd_ptr_ff <= i_rd_grey_addr;  // First stage of synchronization
+474212  point: type=branch comment=else hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
 474212             o_rd_ptr_sync <= r_rd_ptr_ff;   // Second stage of synchronization
+474212  point: type=branch comment=else hier=tb_async_fifo.dut.read_to_write_pointer_sync_inst
                end
            end
        
        endmodule
