//      // verilator_coverage annotation
        module write_to_read_pointer_sync 
            #(
                parameter p_addr_width = 16  // Parameter to define the address width of the FIFO
            )(
 338829         input  wire              i_rd_clk,         // Read clock
+338829  point: type=toggle comment=i_rd_clk:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+338829  point: type=toggle comment=i_rd_clk:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
 000013         input  wire              i_rd_rst_n,       // Read reset (active low)
+000013  point: type=toggle comment=i_rd_rst_n:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000012  point: type=toggle comment=i_rd_rst_n:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
 049442         input  wire [p_addr_width:0] i_wr_grey_addr, // Input Gray-coded write address
+049442  point: type=toggle comment=i_wr_grey_addr[0]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+049442  point: type=toggle comment=i_wr_grey_addr[0]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000048  point: type=toggle comment=i_wr_grey_addr[10]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000048  point: type=toggle comment=i_wr_grey_addr[10]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000024  point: type=toggle comment=i_wr_grey_addr[11]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000024  point: type=toggle comment=i_wr_grey_addr[11]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000012  point: type=toggle comment=i_wr_grey_addr[12]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000012  point: type=toggle comment=i_wr_grey_addr[12]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000006  point: type=toggle comment=i_wr_grey_addr[13]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000006  point: type=toggle comment=i_wr_grey_addr[13]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000003  point: type=toggle comment=i_wr_grey_addr[14]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000003  point: type=toggle comment=i_wr_grey_addr[14]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000003  point: type=toggle comment=i_wr_grey_addr[15]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000003  point: type=toggle comment=i_wr_grey_addr[15]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000003  point: type=toggle comment=i_wr_grey_addr[16]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000003  point: type=toggle comment=i_wr_grey_addr[16]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+024722  point: type=toggle comment=i_wr_grey_addr[1]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+024721  point: type=toggle comment=i_wr_grey_addr[1]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+012362  point: type=toggle comment=i_wr_grey_addr[2]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+012361  point: type=toggle comment=i_wr_grey_addr[2]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+006181  point: type=toggle comment=i_wr_grey_addr[3]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+006181  point: type=toggle comment=i_wr_grey_addr[3]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+003091  point: type=toggle comment=i_wr_grey_addr[4]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+003090  point: type=toggle comment=i_wr_grey_addr[4]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+001545  point: type=toggle comment=i_wr_grey_addr[5]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+001545  point: type=toggle comment=i_wr_grey_addr[5]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000773  point: type=toggle comment=i_wr_grey_addr[6]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000772  point: type=toggle comment=i_wr_grey_addr[6]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000386  point: type=toggle comment=i_wr_grey_addr[7]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000386  point: type=toggle comment=i_wr_grey_addr[7]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000193  point: type=toggle comment=i_wr_grey_addr[8]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000193  point: type=toggle comment=i_wr_grey_addr[8]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000097  point: type=toggle comment=i_wr_grey_addr[9]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000097  point: type=toggle comment=i_wr_grey_addr[9]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
 049442         output reg  [p_addr_width:0] o_wr_ptr_sync // Output synchronized write pointer
+049442  point: type=toggle comment=o_wr_ptr_sync[0]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+049442  point: type=toggle comment=o_wr_ptr_sync[0]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000048  point: type=toggle comment=o_wr_ptr_sync[10]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000048  point: type=toggle comment=o_wr_ptr_sync[10]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000024  point: type=toggle comment=o_wr_ptr_sync[11]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000024  point: type=toggle comment=o_wr_ptr_sync[11]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000012  point: type=toggle comment=o_wr_ptr_sync[12]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000012  point: type=toggle comment=o_wr_ptr_sync[12]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000006  point: type=toggle comment=o_wr_ptr_sync[13]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000006  point: type=toggle comment=o_wr_ptr_sync[13]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000003  point: type=toggle comment=o_wr_ptr_sync[14]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000003  point: type=toggle comment=o_wr_ptr_sync[14]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000003  point: type=toggle comment=o_wr_ptr_sync[15]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000003  point: type=toggle comment=o_wr_ptr_sync[15]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000003  point: type=toggle comment=o_wr_ptr_sync[16]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000003  point: type=toggle comment=o_wr_ptr_sync[16]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+024724  point: type=toggle comment=o_wr_ptr_sync[1]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+024723  point: type=toggle comment=o_wr_ptr_sync[1]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+012362  point: type=toggle comment=o_wr_ptr_sync[2]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+012361  point: type=toggle comment=o_wr_ptr_sync[2]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+006181  point: type=toggle comment=o_wr_ptr_sync[3]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+006181  point: type=toggle comment=o_wr_ptr_sync[3]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+003091  point: type=toggle comment=o_wr_ptr_sync[4]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+003090  point: type=toggle comment=o_wr_ptr_sync[4]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+001545  point: type=toggle comment=o_wr_ptr_sync[5]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+001545  point: type=toggle comment=o_wr_ptr_sync[5]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000773  point: type=toggle comment=o_wr_ptr_sync[6]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000772  point: type=toggle comment=o_wr_ptr_sync[6]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000386  point: type=toggle comment=o_wr_ptr_sync[7]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000386  point: type=toggle comment=o_wr_ptr_sync[7]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000193  point: type=toggle comment=o_wr_ptr_sync[8]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000193  point: type=toggle comment=o_wr_ptr_sync[8]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000097  point: type=toggle comment=o_wr_ptr_sync[9]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000097  point: type=toggle comment=o_wr_ptr_sync[9]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
                
            );
        
            // Internal register to hold the intermediate synchronized write pointer
 049442     reg [p_addr_width:0] r_wr_ptr_ff;
+049442  point: type=toggle comment=r_wr_ptr_ff[0]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+049442  point: type=toggle comment=r_wr_ptr_ff[0]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000048  point: type=toggle comment=r_wr_ptr_ff[10]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000048  point: type=toggle comment=r_wr_ptr_ff[10]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000024  point: type=toggle comment=r_wr_ptr_ff[11]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000024  point: type=toggle comment=r_wr_ptr_ff[11]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000012  point: type=toggle comment=r_wr_ptr_ff[12]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000012  point: type=toggle comment=r_wr_ptr_ff[12]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000006  point: type=toggle comment=r_wr_ptr_ff[13]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000006  point: type=toggle comment=r_wr_ptr_ff[13]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000003  point: type=toggle comment=r_wr_ptr_ff[14]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000003  point: type=toggle comment=r_wr_ptr_ff[14]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000003  point: type=toggle comment=r_wr_ptr_ff[15]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000003  point: type=toggle comment=r_wr_ptr_ff[15]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000003  point: type=toggle comment=r_wr_ptr_ff[16]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000003  point: type=toggle comment=r_wr_ptr_ff[16]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+024724  point: type=toggle comment=r_wr_ptr_ff[1]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+024723  point: type=toggle comment=r_wr_ptr_ff[1]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+012362  point: type=toggle comment=r_wr_ptr_ff[2]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+012361  point: type=toggle comment=r_wr_ptr_ff[2]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+006181  point: type=toggle comment=r_wr_ptr_ff[3]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+006181  point: type=toggle comment=r_wr_ptr_ff[3]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+003091  point: type=toggle comment=r_wr_ptr_ff[4]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+003090  point: type=toggle comment=r_wr_ptr_ff[4]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+001545  point: type=toggle comment=r_wr_ptr_ff[5]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+001545  point: type=toggle comment=r_wr_ptr_ff[5]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000773  point: type=toggle comment=r_wr_ptr_ff[6]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000772  point: type=toggle comment=r_wr_ptr_ff[6]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000386  point: type=toggle comment=r_wr_ptr_ff[7]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000386  point: type=toggle comment=r_wr_ptr_ff[7]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000193  point: type=toggle comment=r_wr_ptr_ff[8]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000193  point: type=toggle comment=r_wr_ptr_ff[8]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000097  point: type=toggle comment=r_wr_ptr_ff[9]:0->1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000097  point: type=toggle comment=r_wr_ptr_ff[9]:1->0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
        
            // Always block for synchronizing the write pointer to the read clock domain
 338841     always @(posedge i_rd_clk or negedge i_rd_rst_n) 
+338841  point: type=line comment=block hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
 338841     begin
+338841  point: type=line comment=block hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
 338719         if (!i_rd_rst_n) begin
+338719  point: type=branch comment=else hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000122  point: type=expr comment=(i_rd_rst_n==0) => 1 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+338719  point: type=expr comment=(i_rd_rst_n==1) => 0 hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
+000122  point: type=branch comment=if hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
                    // If reset is asserted (active low), reset the synchronized pointers to 0
 000122             o_wr_ptr_sync <= {p_addr_width+1{1'b0}};
+000122  point: type=branch comment=if hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
 000122             r_wr_ptr_ff <= {p_addr_width+1{1'b0}};
+000122  point: type=branch comment=if hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
 338719         end else begin
+338719  point: type=branch comment=else hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
                    // If reset is not asserted, synchronize the write pointer to the read clock domain
 338719             r_wr_ptr_ff <= i_wr_grey_addr;  // First stage of synchronization
+338719  point: type=branch comment=else hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
 338719             o_wr_ptr_sync <= r_wr_ptr_ff;   // Second stage of synchronization
+338719  point: type=branch comment=else hier=tb_async_fifo.dut.write_to_read_pointer_sync_inst
                end
            end
        
        endmodule
