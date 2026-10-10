`timescale 1ns/1ps
import zsp_gen_pkg::*;

int current_intent = -1;

interface fifo_if;
  logic i_wr_clk;
  logic i_wr_rst_n;
  logic i_wr_en;
  logic [31:0] i_wr_data;
  logic o_fifo_full;
  logic i_rd_clk;
  logic i_rd_rst_n;
  logic i_rd_en;
  logic [31:0] o_rd_data;
  logic o_fifo_empty;
endinterface

class fifo_imports extends import_api_base;
  virtual fifo_if vif;

  // Shadow memory and pointer state
  bit [31:0] mem [0:65535];
  bit [15:0] wr_addr;
  bit [15:0] rd_addr;

  // Global counters
  int unsigned accepted_writes;
  int unsigned accepted_reads;
  int unsigned full_write_attempts;
  int unsigned empty_read_attempts;
  int unsigned discarded_by_reset;
  int unsigned pending;
  int error_count;

  // Per-intent snapshots and pass flags
  int unsigned begin_writes[10];
  int unsigned begin_reads[10];
  int unsigned begin_full_attempts[10];
  int unsigned begin_empty_attempts[10];
  int unsigned begin_errors[10];
  bit intent_pass[10];

  function new(virtual fifo_if v);
    vif = v;
    accepted_writes = 0;
    accepted_reads = 0;
    full_write_attempts = 0;
    empty_read_attempts = 0;
    discarded_by_reset = 0;
    pending = 0;
    error_count = 0;
    wr_addr = 0;
    rd_addr = 0;
    foreach (mem[i]) mem[i] = 0;
    foreach (intent_pass[i]) intent_pass[i] = 0;
  endfunction

  // Helper to deassert write enable safely
  task deassert_wr_en();
    if (vif.i_wr_en) begin
      @(negedge vif.i_wr_clk);
      vif.i_wr_en = 1'b0;
      @(negedge vif.i_wr_clk);
    end else begin
      @(negedge vif.i_wr_clk);
    end
  endtask

  task deassert_rd_en();
    if (vif.i_rd_en) begin
      @(negedge vif.i_rd_clk);
      vif.i_rd_en = 1'b0;
      @(negedge vif.i_rd_clk);
    end else begin
      @(negedge vif.i_rd_clk);
    end
  endtask

  // Imported function implementations
  virtual task exec_reset_write();
    deassert_wr_en();
    vif.i_wr_rst_n = 1'b0;
    repeat (5) @(posedge vif.i_wr_clk);
    vif.i_wr_rst_n = 1'b1;
    repeat (2) @(posedge vif.i_wr_clk);
    wr_addr = 0;
  endtask

  virtual task exec_reset_read();
    deassert_rd_en();
    vif.i_rd_rst_n = 1'b0;
    repeat (5) @(posedge vif.i_rd_clk);
    vif.i_rd_rst_n = 1'b1;
    repeat (2) @(posedge vif.i_rd_clk);
    rd_addr = 0;
  endtask

  virtual task exec_reset_both();
    deassert_wr_en();
    deassert_rd_en();
    vif.i_wr_rst_n = 1'b0;
    vif.i_rd_rst_n = 1'b0;
    repeat (10) begin
      @(posedge vif.i_wr_clk);
      @(posedge vif.i_rd_clk);
    end
    vif.i_wr_rst_n = 1'b1;
    vif.i_rd_rst_n = 1'b1;
    repeat (2) @(posedge vif.i_wr_clk);
    repeat (2) @(posedge vif.i_rd_clk);
    wr_addr = 0;
    rd_addr = 0;
  endtask

  virtual task exec_wait_wr_cycles(input bit [31:0] cycles);
    deassert_wr_en();
    repeat (cycles) @(posedge vif.i_wr_clk);
  endtask

  virtual task exec_wait_rd_cycles(input bit [31:0] cycles);
    deassert_rd_en();
    repeat (cycles) @(posedge vif.i_rd_clk);
  endtask

  virtual task exec_write_single(input bit [31:0] data, input bit blocking);
    bit accepted;
    int timeout;
    deassert_wr_en();
    if (blocking) begin
      timeout = 0;
      while (1) begin
        @(negedge vif.i_wr_clk);
        if (vif.i_wr_rst_n && !vif.o_fifo_full) break;
        if (++timeout > 100000) begin
          error_count++;
          return;
        end
      end
      vif.i_wr_en = 1'b1;
      vif.i_wr_data = data;
      @(posedge vif.i_wr_clk);
      if (vif.i_wr_rst_n && !vif.o_fifo_full) begin
        mem[wr_addr] = data;
        wr_addr = wr_addr + 1;
        accepted_writes++;
      end else begin
        error_count++;
      end
      @(negedge vif.i_wr_clk);
      vif.i_wr_en = 1'b0;
    end else begin
      @(negedge vif.i_wr_clk);
      vif.i_wr_en = 1'b1;
      vif.i_wr_data = data;
      @(posedge vif.i_wr_clk);
      if (vif.i_wr_rst_n && !vif.o_fifo_full) begin
        mem[wr_addr] = data;
        wr_addr = wr_addr + 1;
        accepted_writes++;
      end else begin
        full_write_attempts++;
      end
      @(negedge vif.i_wr_clk);
      vif.i_wr_en = 1'b0;
    end
  endtask

  virtual task exec_read_single(input bit blocking);
    int timeout;
    deassert_rd_en();
    if (blocking) begin
      timeout = 0;
      while (1) begin
        @(negedge vif.i_rd_clk);
        if (vif.i_rd_rst_n && !vif.o_fifo_empty) break;
        if (++timeout > 100000) begin
          error_count++;
          return;
        end
      end
      vif.i_rd_en = 1'b1;
      @(posedge vif.i_rd_clk);
      if (vif.i_rd_rst_n && !vif.o_fifo_empty) begin
        #0.001;
        if (vif.o_rd_data !== mem[rd_addr]) error_count++;
        rd_addr = rd_addr + 1;
        accepted_reads++;
      end else begin
        error_count++;
      end
      @(negedge vif.i_rd_clk);
      vif.i_rd_en = 1'b0;
    end else begin
      @(negedge vif.i_rd_clk);
      vif.i_rd_en = 1'b1;
      @(posedge vif.i_rd_clk);
      if (vif.i_rd_rst_n && !vif.o_fifo_empty) begin
        #0.001;
        if (vif.o_rd_data !== mem[rd_addr]) error_count++;
        rd_addr = rd_addr + 1;
        accepted_reads++;
      end else begin
        empty_read_attempts++;
      end
      @(negedge vif.i_rd_clk);
      vif.i_rd_en = 1'b0;
    end
  endtask

  virtual task exec_write_burst(input bit [31:0] n_words, input bit [31:0] start_data, input bit blocking, input bit [31:0] gap_cycles);
    $display("[%0t] write_burst n_words=%0d start_data=%0d blocking=%0d gap_cycles=%0d", $time, n_words, start_data, blocking, gap_cycles);
    if (!blocking) begin
      for (int i=0; i<n_words; i++) begin
        exec_write_single(start_data + i, 1'b0);
        if (gap_cycles > 0) exec_wait_wr_cycles(gap_cycles);
      end
    end else begin
      if (gap_cycles == 0) begin
        int i;
        int timeout;
        deassert_wr_en();
        vif.i_wr_en = 1'b1;
        vif.i_wr_data = start_data;
        i = 0;
        timeout = 0;
        while (i < n_words) begin
          @(posedge vif.i_wr_clk);
          if (vif.i_wr_rst_n && !vif.o_fifo_full) begin
            mem[wr_addr] = vif.i_wr_data;
            wr_addr = wr_addr + 1;
            accepted_writes++;
            i++;
            if (i < n_words) begin
              @(negedge vif.i_wr_clk);
              vif.i_wr_data = start_data + i;
            end
          end else if (!vif.i_wr_rst_n) begin
            error_count++;
            vif.i_wr_en = 1'b0;
            return;
          end else begin
            if (++timeout > 100000) begin
              error_count++;
              vif.i_wr_en = 1'b0;
              return;
            end
          end
        end
        @(negedge vif.i_wr_clk);
        vif.i_wr_en = 1'b0;
      end else begin
        for (int i=0; i<n_words; i++) begin
          exec_write_single(start_data + i, 1'b1);
          if (gap_cycles > 0) exec_wait_wr_cycles(gap_cycles);
        end
      end
    end
  endtask

  virtual task exec_read_burst(input bit [31:0] n_words, input bit blocking, input bit [31:0] gap_cycles);
    $display("[%0t] read_burst n_words=%0d blocking=%0d gap_cycles=%0d", $time, n_words, blocking, gap_cycles);
    if (!blocking) begin
      for (int i=0; i<n_words; i++) begin
        exec_read_single(1'b0);
        if (gap_cycles > 0) exec_wait_rd_cycles(gap_cycles);
      end
    end else begin
      if (gap_cycles == 0) begin
        int i;
        int timeout;
        deassert_rd_en();
        vif.i_rd_en = 1'b1;
        i = 0;
        timeout = 0;
        while (i < n_words) begin
          @(posedge vif.i_rd_clk);
          if (vif.i_rd_rst_n && !vif.o_fifo_empty) begin
            #0.001;
            if (vif.o_rd_data !== mem[rd_addr]) error_count++;
            rd_addr = rd_addr + 1;
            accepted_reads++;
            i++;
          end else if (!vif.i_rd_rst_n) begin
            error_count++;
            vif.i_rd_en = 1'b0;
            return;
          end else begin
            if (++timeout > 100000) begin
              error_count++;
              vif.i_rd_en = 1'b0;
              return;
            end
          end
        end
        @(negedge vif.i_rd_clk);
        vif.i_rd_en = 1'b0;
      end else begin
        for (int i=0; i<n_words; i++) begin
          exec_read_single(1'b1);
          if (gap_cycles > 0) exec_wait_rd_cycles(gap_cycles);
        end
      end
    end
  endtask

  virtual task exec_begin_intent(input bit [31:0] index);
    begin_writes[index] = accepted_writes;
    begin_reads[index] = accepted_reads;
    begin_full_attempts[index] = full_write_attempts;
    begin_empty_attempts[index] = empty_read_attempts;
    begin_errors[index] = error_count;
    current_intent = index;
    $display("[%0t] Begin intent %0d", $time, index);
  endtask

  virtual task exec_end_intent(input bit [31:0] index);
    bit pass;
    int delta_writes, delta_reads;
    int delta_full_attempts, delta_empty_attempts;
    int delta_errors;
    current_intent = index;
    $display("[%0t] End intent %0d", $time, index);
    delta_writes = accepted_writes - begin_writes[index];
    delta_reads = accepted_reads - begin_reads[index];
    delta_full_attempts = full_write_attempts - begin_full_attempts[index];
    delta_empty_attempts = empty_read_attempts - begin_empty_attempts[index];
    delta_errors = error_count - begin_errors[index];

    case (index)
      0: begin // basic_ordered_write_read
        pass = (delta_writes == 16) && (delta_reads == 16) && (delta_errors == 0) && (full_write_attempts == 0) && (empty_read_attempts == 0);
        if (pass) begin
          int timeout;
          timeout = 0;
          while (!vif.o_fifo_empty && timeout < 200) begin
            @(posedge vif.i_rd_clk);
            timeout++;
          end
          pass = vif.o_fifo_empty;
        end
      end
      1: begin // full_detection_and_extra_write_blocking
        pass = (delta_writes == 65536) && (delta_full_attempts == 1) && (delta_errors == 0) && (delta_reads == 65536);
        if (pass) begin
          int timeout;
          timeout = 0;
          while (!vif.o_fifo_empty && timeout < 200) begin
            @(posedge vif.i_rd_clk);
            timeout++;
          end
          pass = vif.o_fifo_empty;
        end
      end
      2: begin // empty_detection_and_read_blocking
        pass = (delta_writes == 1) && (delta_reads == 1) && (delta_empty_attempts == 1) && (delta_errors == 0);
        if (pass) begin
          int timeout;
          timeout = 0;
          while (!vif.o_fifo_empty && timeout < 200) begin
            @(posedge vif.i_rd_clk);
            timeout++;
          end
          pass = vif.o_fifo_empty;
        end
      end
      3: begin // concurrent_producer_consumer
        pass = (delta_writes == 1000) && (delta_reads == 1000) && (delta_errors == 0);
      end
      4: begin // write_domain_reset_with_nonzero_read_pointer
        pass = (delta_writes == 8) && (delta_reads == 6) && (delta_errors == 0);
      end
      5: begin // read_domain_reset_with_nonzero_read_pointer
        pass = (delta_writes == 3) && (delta_reads == 4) && (delta_errors == 0);
      end
      6: begin // coordinated_reset_flush
        pass = (delta_writes == 15) && (delta_reads == 8) && (delta_errors == 0);
        if (pass) begin
          int timeout;
          timeout = 0;
          while (!vif.o_fifo_empty && timeout < 200) begin
            @(posedge vif.i_rd_clk);
            timeout++;
          end
          pass = vif.o_fifo_empty;
        end
      end
      7: begin // near_full_boundary_transition
        pass = (delta_writes == 65536) && (delta_reads == 65536) && (delta_errors == 0);
      end
      8: begin // pointer_synchronization_empty_full_flags
        pass = (delta_writes == 65537) && (delta_reads == 65537) && (delta_errors == 0);
      end
      9: begin // back_to_back_continuous_enable
        pass = (delta_writes == 100) && (delta_reads == 100) && (delta_errors == 0);
        if (pass) begin
          int timeout;
          timeout = 0;
          while (!vif.o_fifo_empty && timeout < 200) begin
            @(posedge vif.i_rd_clk);
            timeout++;
          end
          pass = vif.o_fifo_empty;
        end
      end
      default: pass = 0;
    endcase
    intent_pass[index] = pass;
  endtask
endclass

module tb_async_fifo;
  fifo_if ifc();

  async_fifo dut (
    .i_wr_clk(ifc.i_wr_clk),
    .i_wr_rst_n(ifc.i_wr_rst_n),
    .i_wr_en(ifc.i_wr_en),
    .i_wr_data(ifc.i_wr_data),
    .o_fifo_full(ifc.o_fifo_full),
    .i_rd_clk(ifc.i_rd_clk),
    .i_rd_rst_n(ifc.i_rd_rst_n),
    .i_rd_en(ifc.i_rd_en),
    .o_rd_data(ifc.o_rd_data),
    .o_fifo_empty(ifc.o_fifo_empty)
  );

  initial begin
    ifc.i_wr_clk = 1'b0;
    forever #5 ifc.i_wr_clk = ~ifc.i_wr_clk;
  end

  initial begin
    ifc.i_rd_clk = 1'b0;
    forever #7 ifc.i_rd_clk = ~ifc.i_rd_clk;
  end

  initial begin
    ifc.i_wr_rst_n = 1'b0;
    ifc.i_rd_rst_n = 1'b0;
    ifc.i_wr_en = 1'b0;
    ifc.i_rd_en = 1'b0;
    ifc.i_wr_data = 32'h0;
    #100;
    ifc.i_wr_rst_n = 1'b1;
    ifc.i_rd_rst_n = 1'b1;
  end

  import "DPI-C" function void coverage_zero();

  initial begin
    fifo_imports imp;
    export_api_if api;
    int fd;
    bit overall_pass;
    coverage_zero();
    imp = new(ifc);
    api = pss_top::type_id().create(imp);
    api.main_a();

    fd = $fopen("results/functional.json", "w");
    if (fd) begin
      overall_pass = 1;
      foreach (imp.intent_pass[i]) if (!imp.intent_pass[i]) overall_pass = 0;
      if (imp.error_count != 0) overall_pass = 0;
      $fdisplay(fd, "{");
      $fdisplay(fd, "  \"pass\": %s,", overall_pass ? "true" : "false");
      $fdisplay(fd, "  \"errors\": %0d,", imp.error_count);
      $fdisplay(fd, "  \"intents\": [");
      $fdisplay(fd, "    {\"id\": \"basic_ordered_write_read\", \"pass\": %s},", imp.intent_pass[0] ? "true" : "false");
      $fdisplay(fd, "    {\"id\": \"full_detection_and_extra_write_blocking\", \"pass\": %s},", imp.intent_pass[1] ? "true" : "false");
      $fdisplay(fd, "    {\"id\": \"empty_detection_and_read_blocking\", \"pass\": %s},", imp.intent_pass[2] ? "true" : "false");
      $fdisplay(fd, "    {\"id\": \"concurrent_producer_consumer\", \"pass\": %s},", imp.intent_pass[3] ? "true" : "false");
      $fdisplay(fd, "    {\"id\": \"write_domain_reset_with_nonzero_read_pointer\", \"pass\": %s},", imp.intent_pass[4] ? "true" : "false");
      $fdisplay(fd, "    {\"id\": \"read_domain_reset_with_nonzero_read_pointer\", \"pass\": %s},", imp.intent_pass[5] ? "true" : "false");
      $fdisplay(fd, "    {\"id\": \"coordinated_reset_flush\", \"pass\": %s},", imp.intent_pass[6] ? "true" : "false");
      $fdisplay(fd, "    {\"id\": \"near_full_boundary_transition\", \"pass\": %s},", imp.intent_pass[7] ? "true" : "false");
      $fdisplay(fd, "    {\"id\": \"pointer_synchronization_empty_full_flags\", \"pass\": %s},", imp.intent_pass[8] ? "true" : "false");
      $fdisplay(fd, "    {\"id\": \"back_to_back_continuous_enable\", \"pass\": %s}", imp.intent_pass[9] ? "true" : "false");
      $fdisplay(fd, "  ]");
      $fdisplay(fd, "}");
      $fclose(fd);
    end
    $finish;
  end

  initial begin
    #20000000;
    $fatal(1, "Simulation timeout at %0t, current intent %0d", $time, current_intent);
  end
endmodule
