`timescale 1ns/1ps
interface fifo_if;
  logic wr_clk;
  logic rd_clk;
  logic wr_rst_n;
  logic rd_rst_n;
  logic wr_en;
  logic [31:0] wr_data;
  logic full;
  logic rd_en;
  logic [31:0] rd_data;
  logic empty;
endinterface

module tb_async_fifo;
  import zsp_gen_pkg::*;
  import "DPI-C" function void coverage_zero();

  fifo_if bus();

  bit finished = 0;
  bit prev_full = 0;
  bit prev_empty = 0;
  bit prev_wr_rst_n = 1;
  bit prev_rd_rst_n = 1;

  async_fifo dut (
    .i_wr_clk(bus.wr_clk),
    .i_wr_rst_n(bus.wr_rst_n),
    .i_wr_en(bus.wr_en),
    .i_wr_data(bus.wr_data),
    .o_fifo_full(bus.full),
    .i_rd_clk(bus.rd_clk),
    .i_rd_rst_n(bus.rd_rst_n),
    .i_rd_en(bus.rd_en),
    .o_rd_data(bus.rd_data),
    .o_fifo_empty(bus.empty)
  );

  class fifo_imports extends import_api_base;
    int unsigned WATCHDOG = 2000000;

    bit [31:0] exp_q[$];
    int unsigned accepted_writes = 0;
    int unsigned accepted_reads = 0;
    int unsigned full_write_attempts = 0;
    int unsigned empty_read_attempts = 0;
    int unsigned discarded_by_reset = 0;
    int unsigned pending = 0;
    int unsigned errors = 0;

    longint unsigned wr_edges = 0;
    longint unsigned rd_edges = 0;

    time op_write_time[$];
    longint unsigned op_write_wr_edge[$];
    longint unsigned op_write_rd_edge[$];
    time op_read_time[$];
    longint unsigned op_read_rd_edge[$];
    longint unsigned op_read_wr_edge[$];

    bit [31:0] read_data_q[$];
    bit [31:0] random_write_data_q[$];
    bit [31:0] random_write_gap_q[$];
    bit [31:0] random_read_gap_q[$];

    bit write_beat_accepted = 0;
    bit write_beat_blocked = 0;
    time write_beat_t = 0;
    longint unsigned write_beat_wr_edge = 0;
    longint unsigned write_beat_rd_edge = 0;

    bit read_beat_accepted = 0;
    bit read_beat_blocked = 0;
    time read_beat_t = 0;
    longint unsigned read_beat_wr_edge = 0;
    longint unsigned read_beat_rd_edge = 0;

    typedef struct {
      bit flag;
      int unsigned accepted_writes;
      int unsigned accepted_reads;
      int unsigned pending;
      int unsigned full_write_attempts;
      int unsigned empty_read_attempts;
    } obs_t;

    obs_t full_obs[$];
    obs_t empty_obs[$];

    typedef struct {
      int unsigned intent_idx;
      string intent_id;
      string flag_name;
      string dest_domain;
      string src_kind;
      bit direction;
      time t;
      longint unsigned dest_cycle;
      time src_op_time;
      longint unsigned src_op_cycle_src;
      longint unsigned src_op_cycle_dst;
      longint unsigned elapsed_dst_edges;
      bit reset_caused;
    } cdc_event_t;

    cdc_event_t cdc_events[$];
    time full_rise_time[$];
    time full_fall_time[$];
    time empty_rise_time[$];
    time empty_fall_time[$];

    typedef struct {
      int unsigned accepted_writes;
      int unsigned accepted_reads;
      int unsigned pending;
      int unsigned full_write_attempts;
      int unsigned empty_read_attempts;
      longint unsigned wr_edges;
      longint unsigned rd_edges;
      time t;
    } phase_snapshot_t;

    phase_snapshot_t phaseA_start, phaseA_end;
    phase_snapshot_t phaseB_start, phaseB_end;
    phase_snapshot_t phaseC_start, phaseC_end;
    phase_snapshot_t phaseD_start, phaseD_end;
    phase_snapshot_t phaseE_start, phaseE_end;

    int unsigned phaseB_start_rand_idx = 0;
    int unsigned phaseB_end_rand_idx = 0;
    int unsigned phaseD_start_read_idx = 0;
    int unsigned phaseD_end_read_idx = 0;

    int unsigned start_writes[10];
    int unsigned start_reads[10];
    int unsigned start_full_attempts[10];
    int unsigned start_empty_attempts[10];
    int unsigned start_discards[10];
    int unsigned start_errors[10];
    int unsigned start_pending[10];
    int unsigned start_full_obs[10];
    int unsigned start_empty_obs[10];
    longint unsigned start_wr_edges[10];
    longint unsigned start_rd_edges[10];
    longint unsigned end_wr_edges[10];
    longint unsigned end_rd_edges[10];
    time start_time[10];
    time end_time[10];
    bit intent_begun[10];
    bit intent_pass[10];
    string intent_ids[10];

    int current_intent_idx = -1;

    typedef struct {
      string call_name;
      string phase;
      bit blocking;
      bit [31:0] count;
      bit [31:0] data_seed;
      bit [31:0] gap_seed;
      bit [31:0] min_data;
      bit [31:0] max_data;
      bit [31:0] min_gap;
      bit [31:0] max_gap;
      int unsigned start_writes;
      int unsigned start_reads;
      int unsigned start_full_attempts;
      int unsigned start_empty_attempts;
      int unsigned end_writes;
      int unsigned end_reads;
      int unsigned end_full_attempts;
      int unsigned end_empty_attempts;
    } rng_call_t;

    rng_call_t rng_calls[$];

    typedef struct {
      string call_name;
      int unsigned request_idx;
      bit [31:0] data;
      bit [31:0] gap;
      bit accepted;
      bit blocked;
      time t;
      longint unsigned wr_edges;
      longint unsigned rd_edges;
    } rng_request_t;

    rng_request_t rng_requests[$];

    function automatic phase_snapshot_t zero_phase();
      phase_snapshot_t s;
      s.accepted_writes = 0;
      s.accepted_reads = 0;
      s.pending = 0;
      s.full_write_attempts = 0;
      s.empty_read_attempts = 0;
      s.wr_edges = 0;
      s.rd_edges = 0;
      s.t = 0;
      return s;
    endfunction

    function new();
      intent_ids[0] = "reset_initialization";
      intent_ids[1] = "single_write_read_roundtrip";
      intent_ids[2] = "fill_to_full_and_block";
      intent_ids[3] = "read_empty_underflow";
      intent_ids[4] = "sequential_data_integrity";
      intent_ids[5] = "concurrent_producer_consumer";
      intent_ids[6] = "pointer_sync_flag_transitions";
      intent_ids[7] = "coordinated_reset_mid_operation";
      intent_ids[8] = "wrap_around_and_full_range";
      intent_ids[9] = "randomized_stress_pattern";
      phaseA_start = zero_phase(); phaseA_end = zero_phase();
      phaseB_start = zero_phase(); phaseB_end = zero_phase();
      phaseC_start = zero_phase(); phaseC_end = zero_phase();
      phaseD_start = zero_phase(); phaseD_end = zero_phase();
      phaseE_start = zero_phase(); phaseE_end = zero_phase();
    endfunction

    function automatic bit [31:0] lfsr_next(input bit [31:0] state);
      bit fb;
      fb = state[31] ^ state[21] ^ state[1] ^ state[0];
      return {state[30:0], fb};
    endfunction

    function automatic void accept_write(bit [31:0] data);
      exp_q.push_back(data);
      accepted_writes++;
      pending = exp_q.size();
      op_write_time.push_back(write_beat_t);
      op_write_wr_edge.push_back(write_beat_wr_edge);
      op_write_rd_edge.push_back(write_beat_rd_edge);
    endfunction

    function automatic void accept_read(bit [31:0] data_read);
      if (exp_q.size() == 0) begin
        errors++;
      end else begin
        bit [31:0] expected;
        expected = exp_q.pop_front();
        pending = exp_q.size();
        if (data_read !== expected) errors++;
      end
      accepted_reads++;
      op_read_time.push_back(read_beat_t);
      op_read_rd_edge.push_back(read_beat_rd_edge);
      op_read_wr_edge.push_back(read_beat_wr_edge);
      read_data_q.push_back(data_read);
    endfunction

    function automatic void record_cdc_full_event(input int unsigned intent_idx, input bit direction, input time t, input longint unsigned dest_cycle, input bit reset_caused);
      cdc_event_t e;
      int i;
      e.intent_idx = intent_idx;
      e.intent_id = (intent_idx < 10) ? intent_ids[intent_idx] : "unknown";
      e.flag_name = "full";
      e.dest_domain = "write";
      e.direction = direction;
      e.t = t;
      e.dest_cycle = dest_cycle;
      e.reset_caused = reset_caused;
      e.src_op_time = 0;
      e.src_op_cycle_src = 0;
      e.src_op_cycle_dst = 0;
      e.elapsed_dst_edges = 0;
      e.src_kind = "none";
      if (direction == 1) begin
        e.src_kind = "write";
        for (i = op_write_time.size(); i > 0; i--) begin
          if (op_write_time[i-1] <= t) begin
            e.src_op_time = op_write_time[i-1];
            e.src_op_cycle_src = op_write_wr_edge[i-1];
            e.src_op_cycle_dst = op_write_wr_edge[i-1];
            break;
          end
        end
      end else begin
        e.src_kind = "read";
        for (i = op_read_time.size(); i > 0; i--) begin
          if (op_read_time[i-1] <= t) begin
            e.src_op_time = op_read_time[i-1];
            e.src_op_cycle_src = op_read_rd_edge[i-1];
            e.src_op_cycle_dst = op_read_wr_edge[i-1];
            break;
          end
        end
      end
      if (e.src_op_time != 0 && e.src_op_cycle_dst != 0)
        e.elapsed_dst_edges = dest_cycle - e.src_op_cycle_dst;
      else
        e.elapsed_dst_edges = 0;
      cdc_events.push_back(e);
    endfunction

    function automatic void record_cdc_empty_event(input int unsigned intent_idx, input bit direction, input time t, input longint unsigned dest_cycle, input bit reset_caused);
      cdc_event_t e;
      int i;
      e.intent_idx = intent_idx;
      e.intent_id = (intent_idx < 10) ? intent_ids[intent_idx] : "unknown";
      e.flag_name = "empty";
      e.dest_domain = "read";
      e.direction = direction;
      e.t = t;
      e.dest_cycle = dest_cycle;
      e.reset_caused = reset_caused;
      e.src_op_time = 0;
      e.src_op_cycle_src = 0;
      e.src_op_cycle_dst = 0;
      e.elapsed_dst_edges = 0;
      e.src_kind = "none";
      if (direction == 1) begin
        e.src_kind = "read";
        for (i = op_read_time.size(); i > 0; i--) begin
          if (op_read_time[i-1] <= t) begin
            e.src_op_time = op_read_time[i-1];
            e.src_op_cycle_src = op_read_rd_edge[i-1];
            e.src_op_cycle_dst = op_read_rd_edge[i-1];
            break;
          end
        end
      end else begin
        e.src_kind = "write";
        for (i = op_write_time.size(); i > 0; i--) begin
          if (op_write_time[i-1] <= t) begin
            e.src_op_time = op_write_time[i-1];
            e.src_op_cycle_src = op_write_wr_edge[i-1];
            e.src_op_cycle_dst = op_write_rd_edge[i-1];
            break;
          end
        end
      end
      if (e.src_op_time != 0 && e.src_op_cycle_dst != 0)
        e.elapsed_dst_edges = dest_cycle - e.src_op_cycle_dst;
      else
        e.elapsed_dst_edges = 0;
      cdc_events.push_back(e);
    endfunction

    task automatic wait_full_low(output bit ok);
      int unsigned cnt = 0;
      ok = 1;
      while (bus.full !== 0) begin
        @(negedge bus.wr_clk);
        cnt++;
        if (cnt > WATCHDOG) begin
          errors++;
          ok = 0;
          return;
        end
        if (bus.wr_rst_n === 0) begin
          ok = 0;
          return;
        end
      end
    endtask

    task automatic wait_empty_low(output bit ok);
      int unsigned cnt = 0;
      ok = 1;
      while (bus.empty !== 0) begin
        @(negedge bus.rd_clk);
        cnt++;
        if (cnt > WATCHDOG) begin
          errors++;
          ok = 0;
          return;
        end
        if (bus.rd_rst_n === 0) begin
          ok = 0;
          return;
        end
      end
    endtask

    task automatic write_beat(input bit [31:0] data, input bit gap_zero, input bit not_last, input bit blocking);
      bit wr_rst_sampled;
      bit wr_en_sampled;
      bit full_sampled;
      bit accepted;
      bit blocked;
      if (bus.wr_en === 0) begin
        @(negedge bus.wr_clk);
        bus.wr_data = data;
        bus.wr_en = 1;
      end else begin
        @(negedge bus.wr_clk);
        bus.wr_data = data;
      end
      @(posedge bus.wr_clk);
      wr_rst_sampled = bus.wr_rst_n;
      wr_en_sampled = bus.wr_en;
      full_sampled = bus.full;
      accepted = (wr_rst_sampled && wr_en_sampled && !full_sampled);
      blocked = (wr_rst_sampled && wr_en_sampled && full_sampled);
      write_beat_accepted = accepted;
      write_beat_blocked = blocked;
      write_beat_t = $time;
      write_beat_wr_edge = wr_edges;
      write_beat_rd_edge = rd_edges;
      if (accepted) accept_write(data);
      else if (blocked) full_write_attempts++;
      #0.001;
      if (!bus.wr_rst_n) bus.wr_en = 0;
      else if (blocked) bus.wr_en = 0;
      else if (blocking && not_last && bus.full) bus.wr_en = 0;
      else if (!gap_zero || !not_last) bus.wr_en = 0;
    endtask

    task automatic read_beat(input bit gap_zero, input bit not_last, input bit blocking);
      bit rd_rst_sampled;
      bit rd_en_sampled;
      bit empty_sampled;
      bit accepted;
      bit blocked;
      bit [31:0] rd_val;
      if (bus.rd_en === 0) begin
        @(negedge bus.rd_clk);
        bus.rd_en = 1;
      end else begin
        @(negedge bus.rd_clk);
      end
      @(posedge bus.rd_clk);
      rd_rst_sampled = bus.rd_rst_n;
      rd_en_sampled = bus.rd_en;
      empty_sampled = bus.empty;
      accepted = (rd_rst_sampled && rd_en_sampled && !empty_sampled);
      blocked = (rd_rst_sampled && rd_en_sampled && empty_sampled);
      read_beat_accepted = accepted;
      read_beat_blocked = blocked;
      read_beat_t = $time;
      read_beat_wr_edge = wr_edges;
      read_beat_rd_edge = rd_edges;
      #0.001;
      if (accepted) rd_val = bus.rd_data;
      if (!bus.rd_rst_n) bus.rd_en = 0;
      else if (blocked) bus.rd_en = 0;
      else if (blocking && not_last && bus.empty) bus.rd_en = 0;
      else if (!gap_zero || !not_last) bus.rd_en = 0;
      if (accepted) accept_read(rd_val);
      else if (blocked) empty_read_attempts++;
    endtask

    virtual task exec_reset_write_domain(input bit [31:0] hold_cycles);
      bus.wr_rst_n = 0;
      repeat(hold_cycles) @(negedge bus.wr_clk);
      bus.wr_rst_n = 1;
    endtask

    virtual task exec_reset_read_domain(input bit [31:0] hold_cycles);
      bus.rd_rst_n = 0;
      repeat(hold_cycles) @(negedge bus.rd_clk);
      bus.rd_rst_n = 1;
    endtask

    virtual task exec_reset_both_domains(input bit [31:0] hold_cycles);
      bus.wr_rst_n = 0;
      bus.rd_rst_n = 0;
      fork
        repeat(hold_cycles) @(negedge bus.wr_clk);
        repeat(hold_cycles) @(negedge bus.rd_clk);
      join
      bus.wr_rst_n = 1;
      bus.rd_rst_n = 1;
      discarded_by_reset += exp_q.size();
      exp_q.delete();
      pending = 0;
    endtask

    virtual task exec_write_word(input bit [31:0] data, input bit blocking);
      bit ok;
      bit wr_rst_sampled;
      bit wr_en_sampled;
      bit full_sampled;
      bit accepted;
      bit blocked;
      bus.wr_en = 0;
      if (blocking) begin
        wait_full_low(ok);
        if (!ok) begin
          bus.wr_en = 0;
          return;
        end
      end
      @(negedge bus.wr_clk);
      bus.wr_data = data;
      bus.wr_en = 1;
      @(posedge bus.wr_clk);
      wr_rst_sampled = bus.wr_rst_n;
      wr_en_sampled = bus.wr_en;
      full_sampled = bus.full;
      accepted = (wr_rst_sampled && wr_en_sampled && !full_sampled);
      blocked = (wr_rst_sampled && wr_en_sampled && full_sampled);
      write_beat_accepted = accepted;
      write_beat_blocked = blocked;
      write_beat_t = $time;
      write_beat_wr_edge = wr_edges;
      write_beat_rd_edge = rd_edges;
      if (accepted) accept_write(data);
      else if (blocked) full_write_attempts++;
      #0.001;
      bus.wr_en = 0;
    endtask

    virtual task exec_read_word(input bit blocking);
      bit ok;
      bit rd_rst_sampled;
      bit rd_en_sampled;
      bit empty_sampled;
      bit accepted;
      bit blocked;
      bit [31:0] rd_val;
      bus.rd_en = 0;
      if (blocking) begin
        wait_empty_low(ok);
        if (!ok) begin
          bus.rd_en = 0;
          return;
        end
      end
      @(negedge bus.rd_clk);
      bus.rd_en = 1;
      @(posedge bus.rd_clk);
      rd_rst_sampled = bus.rd_rst_n;
      rd_en_sampled = bus.rd_en;
      empty_sampled = bus.empty;
      accepted = (rd_rst_sampled && rd_en_sampled && !empty_sampled);
      blocked = (rd_rst_sampled && rd_en_sampled && empty_sampled);
      read_beat_accepted = accepted;
      read_beat_blocked = blocked;
      read_beat_t = $time;
      read_beat_wr_edge = wr_edges;
      read_beat_rd_edge = rd_edges;
      #0.001;
      rd_val = bus.rd_data;
      if (accepted) accept_read(rd_val);
      else if (blocked) empty_read_attempts++;
      bus.rd_en = 0;
    endtask

    virtual task exec_write_burst(input bit [31:0] count, input bit [31:0] start_data, input bit [31:0] increment, input bit [31:0] gap_cycles, input bit blocking);
      bit [31:0] data;
      bit ok;
      bit is_phaseA;
      int unsigned n;
      int unsigned i;
      bus.wr_en = 0;
      is_phaseA = 0;
      n = count;
      if (current_intent_idx == 9 && count == 65530 && start_data == 0 && increment == 1 && gap_cycles == 0 && blocking == 1) begin
        is_phaseA = 1;
        phaseA_start.accepted_writes = accepted_writes;
        phaseA_start.accepted_reads = accepted_reads;
        phaseA_start.pending = exp_q.size();
        phaseA_start.full_write_attempts = full_write_attempts;
        phaseA_start.empty_read_attempts = empty_read_attempts;
        phaseA_start.wr_edges = wr_edges;
        phaseA_start.rd_edges = rd_edges;
        phaseA_start.t = $time;
      end
      for (i = 0; i < n; i++) begin
        data = start_data + i * increment;
        if (gap_cycles > 0) begin
          bus.wr_en = 0;
          repeat(gap_cycles) @(negedge bus.wr_clk);
        end
        if (blocking && bus.wr_en === 0) begin
          wait_full_low(ok);
          if (!ok) begin
            bus.wr_en = 0;
            return;
          end
        end
        write_beat(data, gap_cycles == 0, i < n - 1, blocking);
      end
      if (is_phaseA) begin
        phaseA_end.accepted_writes = accepted_writes;
        phaseA_end.accepted_reads = accepted_reads;
        phaseA_end.pending = exp_q.size();
        phaseA_end.full_write_attempts = full_write_attempts;
        phaseA_end.empty_read_attempts = empty_read_attempts;
        phaseA_end.wr_edges = wr_edges;
        phaseA_end.rd_edges = rd_edges;
        phaseA_end.t = $time;
      end
      bus.wr_en = 0;
    endtask

    virtual task exec_read_burst(input bit [31:0] count, input bit [31:0] gap_cycles, input bit blocking);
      bit ok;
      bit is_phaseD;
      int unsigned n;
      int unsigned i;
      bus.rd_en = 0;
      is_phaseD = 0;
      n = count;
      if (current_intent_idx == 9 && count == 65536 && gap_cycles == 0 && blocking == 1) begin
        is_phaseD = 1;
        phaseD_start.accepted_writes = accepted_writes;
        phaseD_start.accepted_reads = accepted_reads;
        phaseD_start.pending = exp_q.size();
        phaseD_start.full_write_attempts = full_write_attempts;
        phaseD_start.empty_read_attempts = empty_read_attempts;
        phaseD_start.wr_edges = wr_edges;
        phaseD_start.rd_edges = rd_edges;
        phaseD_start.t = $time;
        phaseD_start_read_idx = read_data_q.size();
      end
      for (i = 0; i < n; i++) begin
        if (gap_cycles > 0) begin
          bus.rd_en = 0;
          repeat(gap_cycles) @(negedge bus.rd_clk);
        end
        if (blocking && bus.rd_en === 0) begin
          wait_empty_low(ok);
          if (!ok) begin
            bus.rd_en = 0;
            return;
          end
        end
        read_beat(gap_cycles == 0, i < n - 1, blocking);
      end
      if (is_phaseD) begin
        phaseD_end.accepted_writes = accepted_writes;
        phaseD_end.accepted_reads = accepted_reads;
        phaseD_end.pending = exp_q.size();
        phaseD_end.full_write_attempts = full_write_attempts;
        phaseD_end.empty_read_attempts = empty_read_attempts;
        phaseD_end.wr_edges = wr_edges;
        phaseD_end.rd_edges = rd_edges;
        phaseD_end.t = $time;
        phaseD_end_read_idx = read_data_q.size();
      end
      bus.rd_en = 0;
    endtask

    virtual task exec_write_random_burst(input bit [31:0] count, input bit [31:0] seed, input bit [31:0] min_data, input bit [31:0] max_data, input bit [31:0] gap_cycles, input bit blocking);
      bit [31:0] rng;
      bit [31:0] data;
      bit [63:0] range64;
      bit ok;
      int unsigned n;
      int unsigned i;
      bus.wr_en = 0;
      rng = seed;
      n = count;
      for (i = 0; i < n; i++) begin
        rng = lfsr_next(rng);
        range64 = 64'(max_data) - 64'(min_data) + 1;
        data = min_data + (64'(rng) % range64);
        if (gap_cycles > 0) begin
          bus.wr_en = 0;
          repeat(gap_cycles) @(negedge bus.wr_clk);
        end
        if (blocking && bus.wr_en === 0) begin
          wait_full_low(ok);
          if (!ok) begin bus.wr_en = 0; return; end
        end
        write_beat(data, gap_cycles == 0, i < n - 1, blocking);
      end
      bus.wr_en = 0;
    endtask

    virtual task exec_write_random_gap_burst(input bit [31:0] count, input bit [31:0] start_data, input bit [31:0] increment, input bit [31:0] seed, input bit [31:0] min_gap, input bit [31:0] max_gap, input bit blocking);
      bit [31:0] rng;
      bit [31:0] data;
      int unsigned gap_val;
      bit [63:0] range64;
      bit ok;
      int unsigned n;
      int unsigned i;
      bus.wr_en = 0;
      rng = seed;
      n = count;
      for (i = 0; i < n; i++) begin
        data = start_data + i * increment;
        rng = lfsr_next(rng);
        range64 = 64'(max_gap) - 64'(min_gap) + 1;
        gap_val = min_gap + (64'(rng) % range64);
        if (gap_val > 0) begin
          bus.wr_en = 0;
          repeat(gap_val) @(negedge bus.wr_clk);
        end
        if (blocking && bus.wr_en === 0) begin
          wait_full_low(ok);
          if (!ok) begin bus.wr_en = 0; return; end
        end
        write_beat(data, gap_val == 0, i < n - 1, blocking);
      end
      bus.wr_en = 0;
    endtask

    virtual task exec_read_random_gap_burst(input bit [31:0] count, input bit [31:0] seed, input bit [31:0] min_gap, input bit [31:0] max_gap, input bit blocking);
      bit [31:0] rng_gap;
      int unsigned gap_val;
      bit [63:0] range64;
      bit ok;
      int unsigned n;
      int unsigned i;
      bus.rd_en = 0;
      rng_gap = seed;
      n = count;
      for (i = 0; i < n; i++) begin
        rng_gap = lfsr_next(rng_gap);
        range64 = 64'(max_gap) - 64'(min_gap) + 1;
        gap_val = min_gap + (64'(rng_gap) % range64);
        random_read_gap_q.push_back(gap_val);
        if (gap_val > 0) begin
          bus.rd_en = 0;
          repeat(gap_val) @(negedge bus.rd_clk);
        end
        if (blocking && bus.rd_en === 0) begin
          wait_empty_low(ok);
          if (!ok) begin bus.rd_en = 0; return; end
        end
        read_beat(gap_val == 0, i < n - 1, blocking);
      end
      bus.rd_en = 0;
    endtask

    virtual task exec_write_random_data_gap_burst(input bit [31:0] count, input bit [31:0] data_seed, input bit [31:0] gap_seed, input bit [31:0] min_data, input bit [31:0] max_data, input bit [31:0] min_gap, input bit [31:0] max_gap, input bit blocking);
      bit [31:0] rng_data;
      bit [31:0] rng_gap;
      bit [31:0] data;
      int unsigned gap_val;
      bit [63:0] range64;
      bit ok;
      bit is_phaseB;
      bit is_phaseC;
      int unsigned n;
      int unsigned i;
      rng_call_t rc;
      rng_request_t rr;
      bus.wr_en = 0;
      rng_data = data_seed;
      rng_gap = gap_seed;
      n = count;
      is_phaseB = 0;
      is_phaseC = 0;
      if (current_intent_idx == 9 && count == 6 && data_seed == 12345 && gap_seed == 67890 && blocking == 1) begin
        is_phaseB = 1;
        phaseB_start.accepted_writes = accepted_writes;
        phaseB_start.accepted_reads = accepted_reads;
        phaseB_start.pending = exp_q.size();
        phaseB_start.full_write_attempts = full_write_attempts;
        phaseB_start.empty_read_attempts = empty_read_attempts;
        phaseB_start.wr_edges = wr_edges;
        phaseB_start.rd_edges = rd_edges;
        phaseB_start.t = $time;
        phaseB_start_rand_idx = random_write_data_q.size();
      end else if (current_intent_idx == 9 && count == 20 && data_seed == 11111 && gap_seed == 22222 && blocking == 0) begin
        is_phaseC = 1;
        phaseC_start.accepted_writes = accepted_writes;
        phaseC_start.accepted_reads = accepted_reads;
        phaseC_start.pending = exp_q.size();
        phaseC_start.full_write_attempts = full_write_attempts;
        phaseC_start.empty_read_attempts = empty_read_attempts;
        phaseC_start.wr_edges = wr_edges;
        phaseC_start.rd_edges = rd_edges;
        phaseC_start.t = $time;
      end
      if (is_phaseB || is_phaseC) begin
        rc.call_name = "write_random_data_gap_burst";
        rc.phase = is_phaseB ? "B" : "C";
        rc.blocking = blocking;
        rc.count = count;
        rc.data_seed = data_seed;
        rc.gap_seed = gap_seed;
        rc.min_data = min_data;
        rc.max_data = max_data;
        rc.min_gap = min_gap;
        rc.max_gap = max_gap;
        rc.start_writes = accepted_writes;
        rc.start_reads = accepted_reads;
        rc.start_full_attempts = full_write_attempts;
        rc.start_empty_attempts = empty_read_attempts;
        rc.end_writes = 0;
        rc.end_reads = 0;
        rc.end_full_attempts = 0;
        rc.end_empty_attempts = 0;
        rng_calls.push_back(rc);
      end
      for (i = 0; i < n; i++) begin
        rng_data = lfsr_next(rng_data);
        range64 = 64'(max_data) - 64'(min_data) + 1;
        data = min_data + (64'(rng_data) % range64);
        rng_gap = lfsr_next(rng_gap);
        range64 = 64'(max_gap) - 64'(min_gap) + 1;
        gap_val = min_gap + (64'(rng_gap) % range64);
        if (is_phaseB || is_phaseC) random_write_gap_q.push_back(gap_val);
        if (gap_val > 0) begin
          bus.wr_en = 0;
          repeat(gap_val) @(negedge bus.wr_clk);
        end
        if (blocking && bus.wr_en === 0) begin
          wait_full_low(ok);
          if (!ok) begin bus.wr_en = 0; return; end
        end
        write_beat(data, gap_val == 0, i < n - 1, blocking);
        rr.call_name = is_phaseB ? "B" : (is_phaseC ? "C" : "write_random_data_gap_burst");
        rr.request_idx = i;
        rr.data = data;
        rr.gap = gap_val;
        rr.accepted = write_beat_accepted;
        rr.blocked = write_beat_blocked;
        rr.t = write_beat_t;
        rr.wr_edges = write_beat_wr_edge;
        rr.rd_edges = write_beat_rd_edge;
        rng_requests.push_back(rr);
        if (is_phaseB && write_beat_accepted) random_write_data_q.push_back(data);
      end
      if (is_phaseB) begin
        phaseB_end.accepted_writes = accepted_writes;
        phaseB_end.accepted_reads = accepted_reads;
        phaseB_end.pending = exp_q.size();
        phaseB_end.full_write_attempts = full_write_attempts;
        phaseB_end.empty_read_attempts = empty_read_attempts;
        phaseB_end.wr_edges = wr_edges;
        phaseB_end.rd_edges = rd_edges;
        phaseB_end.t = $time;
        phaseB_end_rand_idx = random_write_data_q.size();
      end else if (is_phaseC) begin
        phaseC_end.accepted_writes = accepted_writes;
        phaseC_end.accepted_reads = accepted_reads;
        phaseC_end.pending = exp_q.size();
        phaseC_end.full_write_attempts = full_write_attempts;
        phaseC_end.empty_read_attempts = empty_read_attempts;
        phaseC_end.wr_edges = wr_edges;
        phaseC_end.rd_edges = rd_edges;
        phaseC_end.t = $time;
      end
      if (rng_calls.size() > 0) begin
        if (rng_calls[rng_calls.size()-1].phase == "B" || rng_calls[rng_calls.size()-1].phase == "C") begin
          rng_calls[rng_calls.size()-1].end_writes = accepted_writes;
          rng_calls[rng_calls.size()-1].end_reads = accepted_reads;
          rng_calls[rng_calls.size()-1].end_full_attempts = full_write_attempts;
          rng_calls[rng_calls.size()-1].end_empty_attempts = empty_read_attempts;
        end
      end
      bus.wr_en = 0;
    endtask

    virtual task exec_read_random_data_gap_burst(input bit [31:0] count, input bit [31:0] gap_seed, input bit [31:0] min_gap, input bit [31:0] max_gap, input bit blocking);
      bit [31:0] rng_gap;
      int unsigned gap_val;
      bit [63:0] range64;
      bit ok;
      bit is_phaseE;
      int unsigned n;
      int unsigned i;
      rng_call_t rc;
      rng_request_t rr;
      bus.rd_en = 0;
      rng_gap = gap_seed;
      n = count;
      is_phaseE = 0;
      if (current_intent_idx == 9 && count == 20 && gap_seed == 33333 && blocking == 0) begin
        is_phaseE = 1;
        phaseE_start.accepted_writes = accepted_writes;
        phaseE_start.accepted_reads = accepted_reads;
        phaseE_start.pending = exp_q.size();
        phaseE_start.full_write_attempts = full_write_attempts;
        phaseE_start.empty_read_attempts = empty_read_attempts;
        phaseE_start.wr_edges = wr_edges;
        phaseE_start.rd_edges = rd_edges;
        phaseE_start.t = $time;
        rc.call_name = "read_random_data_gap_burst";
        rc.phase = "E";
        rc.blocking = blocking;
        rc.count = count;
        rc.data_seed = 0;
        rc.gap_seed = gap_seed;
        rc.min_data = 0;
        rc.max_data = 0;
        rc.min_gap = min_gap;
        rc.max_gap = max_gap;
        rc.start_writes = accepted_writes;
        rc.start_reads = accepted_reads;
        rc.start_full_attempts = full_write_attempts;
        rc.start_empty_attempts = empty_read_attempts;
        rc.end_writes = 0;
        rc.end_reads = 0;
        rc.end_full_attempts = 0;
        rc.end_empty_attempts = 0;
        rng_calls.push_back(rc);
      end
      for (i = 0; i < n; i++) begin
        rng_gap = lfsr_next(rng_gap);
        range64 = 64'(max_gap) - 64'(min_gap) + 1;
        gap_val = min_gap + (64'(rng_gap) % range64);
        random_read_gap_q.push_back(gap_val);
        if (gap_val > 0) begin
          bus.rd_en = 0;
          repeat(gap_val) @(negedge bus.rd_clk);
        end
        if (blocking && bus.rd_en === 0) begin
          wait_empty_low(ok);
          if (!ok) begin bus.rd_en = 0; return; end
        end
        read_beat(gap_val == 0, i < n - 1, blocking);
        rr.call_name = "E";
        rr.request_idx = i;
        rr.data = 0;
        rr.gap = gap_val;
        rr.accepted = read_beat_accepted;
        rr.blocked = read_beat_blocked;
        rr.t = read_beat_t;
        rr.wr_edges = read_beat_wr_edge;
        rr.rd_edges = read_beat_rd_edge;
        rng_requests.push_back(rr);
      end
      if (is_phaseE) begin
        phaseE_end.accepted_writes = accepted_writes;
        phaseE_end.accepted_reads = accepted_reads;
        phaseE_end.pending = exp_q.size();
        phaseE_end.full_write_attempts = full_write_attempts;
        phaseE_end.empty_read_attempts = empty_read_attempts;
        phaseE_end.wr_edges = wr_edges;
        phaseE_end.rd_edges = rd_edges;
        phaseE_end.t = $time;
        if (rng_calls.size() > 0) begin
          rng_calls[rng_calls.size()-1].end_writes = accepted_writes;
          rng_calls[rng_calls.size()-1].end_reads = accepted_reads;
          rng_calls[rng_calls.size()-1].end_full_attempts = full_write_attempts;
          rng_calls[rng_calls.size()-1].end_empty_attempts = empty_read_attempts;
        end
      end
      bus.rd_en = 0;
    endtask

    virtual task exec_wait_write_cycles(input bit [31:0] num_cycles);
      repeat(num_cycles) @(negedge bus.wr_clk);
    endtask

    virtual task exec_wait_read_cycles(input bit [31:0] num_cycles);
      repeat(num_cycles) @(negedge bus.rd_clk);
    endtask

    virtual task exec_sample_full();
      obs_t s;
      #0.001;
      s.flag = bus.full;
      s.accepted_writes = accepted_writes;
      s.accepted_reads = accepted_reads;
      s.pending = exp_q.size();
      s.full_write_attempts = full_write_attempts;
      s.empty_read_attempts = empty_read_attempts;
      full_obs.push_back(s);
    endtask

    virtual task exec_sample_empty();
      obs_t s;
      #0.001;
      s.flag = bus.empty;
      s.accepted_writes = accepted_writes;
      s.accepted_reads = accepted_reads;
      s.pending = exp_q.size();
      s.full_write_attempts = full_write_attempts;
      s.empty_read_attempts = empty_read_attempts;
      empty_obs.push_back(s);
    endtask

    virtual task exec_reset_scoreboard();
      discarded_by_reset += exp_q.size();
      exp_q.delete();
      pending = 0;
    endtask

    virtual task exec_write_walking_burst(input bit [31:0] pattern, input bit [31:0] gap_cycles, input bit blocking);
      bit [31:0] data;
      bit ok;
      int unsigned i;
      bus.wr_en = 0;
      for (i = 0; i < 32; i++) begin
        data = (pattern == 32'd0) ? (32'd1 << i) : ~(32'd1 << i);
        if (gap_cycles > 0) begin
          bus.wr_en = 0;
          repeat(gap_cycles) @(negedge bus.wr_clk);
        end
        if (blocking && bus.wr_en === 0) begin
          wait_full_low(ok);
          if (!ok) begin bus.wr_en = 0; return; end
        end
        write_beat(data, gap_cycles == 0, i < 31, blocking);
      end
      bus.wr_en = 0;
    endtask

    virtual task begin_intent(input bit [31:0] index);
      int unsigned idx = index;
      if (idx >= 10) return;
      current_intent_idx = idx;
      start_writes[idx] = accepted_writes;
      start_reads[idx] = accepted_reads;
      start_full_attempts[idx] = full_write_attempts;
      start_empty_attempts[idx] = empty_read_attempts;
      start_discards[idx] = discarded_by_reset;
      start_errors[idx] = errors;
      start_pending[idx] = exp_q.size();
      start_full_obs[idx] = full_obs.size();
      start_empty_obs[idx] = empty_obs.size();
      start_wr_edges[idx] = wr_edges;
      start_rd_edges[idx] = rd_edges;
      start_time[idx] = $time;
      intent_begun[idx] = 1;
    endtask

    virtual task end_intent(input bit [31:0] index);
      int unsigned idx = index;
      int unsigned dw, dr, dfa, dea, derr, pending_now;
      int unsigned fp, ep, fp0, ep0;
      int unsigned local_full_count, local_empty_count;
      bit pass;
      int unsigned i, d_start, d_len, b_idx, k;
      if (idx >= 10) return;
      end_wr_edges[idx] = wr_edges;
      end_rd_edges[idx] = rd_edges;
      end_time[idx] = $time;
      dw = accepted_writes - start_writes[idx];
      dr = accepted_reads - start_reads[idx];
      dfa = full_write_attempts - start_full_attempts[idx];
      dea = empty_read_attempts - start_empty_attempts[idx];
      derr = errors - start_errors[idx];
      pending_now = exp_q.size();
      fp = full_obs.size();
      ep = empty_obs.size();
      fp0 = start_full_obs[idx];
      ep0 = start_empty_obs[idx];
      local_full_count = fp - fp0;
      local_empty_count = ep - ep0;
      pass = 0;
      case (idx)
        0: begin
          pass = (dw == 0 && dr == 0 && derr == 0 && pending_now == 0 &&
                  local_full_count >= 1 && local_empty_count >= 1);
          if (pass) pass = (full_obs[fp0].flag == 0 && empty_obs[ep0].flag == 1);
        end
        1: begin
          pass = (dw == 1 && dr == 1 && dfa == 0 && dea == 0 && derr == 0 && pending_now == 0 &&
                  local_empty_count >= 2);
          if (pass) pass = (empty_obs[ep0].flag == 0 && empty_obs[ep0+1].flag == 1);
        end
        2: begin
          pass = (dw == 65536 && dr == 65536 && dfa == 10 && dea == 0 && derr == 0 && pending_now == 0 &&
                  local_full_count >= 2);
          if (pass) begin
            obs_t f0 = full_obs[fp0];
            obs_t f1 = full_obs[fp0+1];
            pass = (f0.flag == 1 && f1.flag == 0);
            if (pass) pass = (f1.accepted_writes == f0.accepted_writes);
            if (pass) pass = (f0.accepted_reads == start_reads[idx] && f1.accepted_reads == start_reads[idx] + 1);
          end
        end
        3: begin
          pass = (dw == 1 && dr == 1 && dfa == 0 && dea == 10 && derr == 0 && pending_now == 0 &&
                  local_empty_count >= 3);
          if (pass) begin
            obs_t e0 = empty_obs[ep0];
            obs_t e1 = empty_obs[ep0+1];
            obs_t e2 = empty_obs[ep0+2];
            pass = (e0.flag == 1 && e1.flag == 0 && e2.flag == 1);
            if (pass) pass = (e0.accepted_reads == start_reads[idx]);
          end
        end
        4: begin
          pass = (dw == 1000 && dr == 1000 && dfa == 0 && dea == 0 && derr == 0 && pending_now == 0 &&
                  local_empty_count >= 1);
          if (pass) pass = (empty_obs[ep0].flag == 1);
        end
        5: begin
          pass = (dw == 2000 && dr == 2000 && dfa == 0 && dea == 0 && derr == 0 && pending_now == 0);
        end
        6: begin
          pass = (dw == 65536 && dr == 65536 && dfa == 0 && dea == 0 && derr == 0 && pending_now == 0 &&
                  local_full_count >= 3 && local_empty_count >= 2);
          if (pass) begin
            obs_t f0 = full_obs[fp0];
            obs_t f1 = full_obs[fp0+1];
            obs_t f2 = full_obs[fp0+2];
            obs_t e0 = empty_obs[ep0];
            obs_t e1 = empty_obs[ep0+1];
            pass = (f0.flag == 0 && f1.flag == 1 && f2.flag == 0 &&
                    e0.flag == 0 && e1.flag == 1);
            if (pass) pass = (f0.accepted_writes == start_writes[idx] + 65530 &&
                              f0.accepted_reads == start_reads[idx] &&
                              f0.pending == 65530);
            if (pass) begin
              bit found_empty_fall_write = 0;
              bit found_full_fall_read = 0;
              for (i = 0; i < cdc_events.size(); i++) begin
                if (cdc_events[i].t >= start_time[idx] && cdc_events[i].t <= end_time[idx]) begin
                  if (cdc_events[i].flag_name == "empty" && cdc_events[i].dest_domain == "read" &&
                      cdc_events[i].direction == 0 && cdc_events[i].src_kind == "write") begin
                    if (cdc_events[i].src_op_time >= start_time[idx]) found_empty_fall_write = 1;
                  end
                  if (cdc_events[i].flag_name == "full" && cdc_events[i].dest_domain == "write" &&
                      cdc_events[i].direction == 0 && cdc_events[i].src_kind == "read") begin
                    if (cdc_events[i].src_op_time >= start_time[idx]) found_full_fall_read = 1;
                  end
                end
              end
              pass = found_empty_fall_write && found_full_fall_read;
            end
          end
        end
        7: begin
          pass = (dw == 101 && dr == 31 && dfa == 0 && dea == 0 && derr == 0 && pending_now == 0 &&
                  local_full_count >= 1 && local_empty_count >= 1);
          if (pass) begin
            obs_t f0 = full_obs[fp0];
            obs_t e0 = empty_obs[ep0];
            pass = (f0.flag == 0 && e0.flag == 1);
            if (pass) pass = (f0.accepted_writes == start_writes[idx] + 100 &&
                              f0.accepted_reads == start_reads[idx] + 30 &&
                              f0.pending == 0 && e0.pending == 0);
            if (pass) pass = ((discarded_by_reset - start_discards[idx]) == 70);
          end
        end
        8: begin
          pass = (dw == 80000 && dr == 80000 && dfa == 0 && dea == 0 && derr == 0 && pending_now == 0 &&
                  local_empty_count >= 1);
          if (pass) pass = (empty_obs[ep0].flag == 1);
        end
        9: begin
          pass = (dw == 65536 && dr == 65536 && dfa == 20 && dea == 20 && derr == 0 && pending_now == 0 &&
                  local_full_count >= 2 && local_empty_count >= 2);
          if (pass) pass = (full_obs[fp0].flag == 1 && full_obs[fp0+1].flag == 0 &&
                            empty_obs[ep0].flag == 1 && empty_obs[ep0+1].flag == 1);
          if (pass) begin
            pass = (phaseA_end.accepted_writes == start_writes[idx] + 65530 &&
                    phaseA_end.accepted_reads == start_reads[idx] &&
                    phaseA_end.pending == 65530 &&
                    phaseA_end.full_write_attempts == start_full_attempts[idx] &&
                    phaseA_end.empty_read_attempts == start_empty_attempts[idx]);
          end
          if (pass) begin
            pass = (phaseB_end.accepted_writes == phaseA_end.accepted_writes + 6 &&
                    phaseB_end.accepted_reads == start_reads[idx] &&
                    phaseB_end.pending == 65536 &&
                    phaseB_end.full_write_attempts == start_full_attempts[idx] &&
                    phaseB_end.empty_read_attempts == start_empty_attempts[idx]);
          end
          if (pass) begin
            pass = (phaseC_end.accepted_writes == phaseB_end.accepted_writes &&
                    phaseC_end.accepted_reads == start_reads[idx] &&
                    phaseC_end.pending == 65536 &&
                    phaseC_end.full_write_attempts == start_full_attempts[idx] + 20 &&
                    phaseC_end.empty_read_attempts == start_empty_attempts[idx]);
          end
          if (pass) begin
            pass = (phaseD_end.accepted_writes == phaseC_end.accepted_writes &&
                    phaseD_end.accepted_reads == start_reads[idx] + 65536 &&
                    phaseD_end.pending == 0 &&
                    phaseD_end.full_write_attempts == start_full_attempts[idx] + 20 &&
                    phaseD_end.empty_read_attempts == start_empty_attempts[idx]);
          end
          if (pass) begin
            pass = (phaseE_end.accepted_writes == phaseD_end.accepted_writes &&
                    phaseE_end.accepted_reads == phaseD_end.accepted_reads &&
                    phaseE_end.pending == 0 &&
                    phaseE_end.full_write_attempts == phaseD_end.full_write_attempts &&
                    phaseE_end.empty_read_attempts == start_empty_attempts[idx] + 20);
          end
          if (pass) begin
            d_start = phaseD_start_read_idx;
            d_len = phaseD_end_read_idx - phaseD_start_read_idx;
            if (d_len != 65536) pass = 0;
            else begin
              for (k = 0; k < 65530; k++) begin
                if (read_data_q[d_start + k] !== k[31:0]) begin
                  pass = 0;
                  break;
                end
              end
              if (pass) begin
                b_idx = phaseB_start_rand_idx;
                for (k = 0; k < 6; k++) begin
                  if (read_data_q[d_start + 65530 + k] !== random_write_data_q[b_idx + k]) begin
                    pass = 0;
                    break;
                  end
                end
              end
            end
          end
        end
      endcase
      intent_pass[idx] = pass;
      current_intent_idx = -1;
    endtask
  endclass

  fifo_imports imp;
  export_api_if api;

  always @(posedge bus.wr_clk) begin
    if (imp != null) begin
      int unsigned ev_intent;
      longint unsigned ev_cycle;
      bit ev_reset_cause;
      time ev_time;
      bit old_full;
      ev_intent = imp.current_intent_idx;
      imp.wr_edges++;
      ev_cycle = imp.wr_edges;
      ev_time = $time;
      ev_reset_cause = (!prev_wr_rst_n && bus.wr_rst_n);
      old_full = prev_full;
      #0.002;
      if (bus.wr_rst_n) begin
        if (old_full === 0 && bus.full === 1) begin
          imp.record_cdc_full_event(ev_intent, 1, ev_time, ev_cycle, ev_reset_cause);
          imp.full_rise_time.push_back(ev_time);
        end else if (old_full === 1 && bus.full === 0) begin
          imp.record_cdc_full_event(ev_intent, 0, ev_time, ev_cycle, ev_reset_cause);
          imp.full_fall_time.push_back(ev_time);
        end
        prev_full <= bus.full;
      end else begin
        prev_full <= 0;
      end
    end
    prev_wr_rst_n <= bus.wr_rst_n;
  end

  always @(posedge bus.rd_clk) begin
    if (imp != null) begin
      int unsigned ev_intent;
      longint unsigned ev_cycle;
      bit ev_reset_cause;
      time ev_time;
      bit old_empty;
      ev_intent = imp.current_intent_idx;
      imp.rd_edges++;
      ev_cycle = imp.rd_edges;
      ev_time = $time;
      ev_reset_cause = (!prev_rd_rst_n && bus.rd_rst_n);
      old_empty = prev_empty;
      #0.002;
      if (bus.rd_rst_n) begin
        if (old_empty === 0 && bus.empty === 1) begin
          imp.record_cdc_empty_event(ev_intent, 1, ev_time, ev_cycle, ev_reset_cause);
          imp.empty_rise_time.push_back(ev_time);
        end else if (old_empty === 1 && bus.empty === 0) begin
          imp.record_cdc_empty_event(ev_intent, 0, ev_time, ev_cycle, ev_reset_cause);
          imp.empty_fall_time.push_back(ev_time);
        end
        prev_empty <= bus.empty;
      end else begin
        prev_empty <= 0;
      end
    end
    prev_rd_rst_n <= bus.rd_rst_n;
  end

  function automatic void write_report();
    integer fp;
    bit overall_pass;
    int unsigned i;
    overall_pass = (imp.errors == 0);
    for (i = 0; i < 10; i++) begin
      if (!imp.intent_pass[i]) overall_pass = 0;
    end
    fp = $fopen("results/functional.json", "w");
    if (fp == 0) begin
      $display("ERROR: cannot open results/functional.json");
      return;
    end
    $fdisplay(fp, "{");
    $fdisplay(fp, "  \"pass\": %s,", overall_pass ? "true" : "false");
    $fdisplay(fp, "  \"errors\": %0d,", imp.errors);
    $fdisplay(fp, "  \"intents\": [");
    for (i = 0; i < 10; i++) begin
      if (i != 0) $fdisplay(fp, ",");
      $fdisplay(fp, "    {\"id\": \"%s\", \"pass\": %s}", imp.intent_ids[i], imp.intent_pass[i] ? "true" : "false");
    end
    $fdisplay(fp, "  ],");
    $fdisplay(fp, "  \"observations\": {");
    $fdisplay(fp, "    \"accepted_writes\": %0d,", imp.accepted_writes);
    $fdisplay(fp, "    \"accepted_reads\": %0d,", imp.accepted_reads);
    $fdisplay(fp, "    \"discarded_by_reset\": %0d,", imp.discarded_by_reset);
    $fdisplay(fp, "    \"pending\": %0d,", imp.pending);
    $fdisplay(fp, "    \"full_write_attempts\": %0d,", imp.full_write_attempts);
    $fdisplay(fp, "    \"empty_read_attempts\": %0d,", imp.empty_read_attempts);
    $fdisplay(fp, "    \"wr_edges\": %0d,", imp.wr_edges);
    $fdisplay(fp, "    \"rd_edges\": %0d,", imp.rd_edges);
    $fdisplay(fp, "    \"random_write_data\": [");
    for (i = 0; i < imp.random_write_data_q.size(); i++) begin
      if (i != 0) $fdisplay(fp, ",");
      $fwrite(fp, "      %0d", imp.random_write_data_q[i]);
    end
    $fdisplay(fp, "    ],");
    $fdisplay(fp, "    \"random_write_gaps\": [");
    for (i = 0; i < imp.random_write_gap_q.size(); i++) begin
      if (i != 0) $fdisplay(fp, ",");
      $fwrite(fp, "      %0d", imp.random_write_gap_q[i]);
    end
    $fdisplay(fp, "    ],");
    $fdisplay(fp, "    \"random_read_gaps\": [");
    for (i = 0; i < imp.random_read_gap_q.size(); i++) begin
      if (i != 0) $fdisplay(fp, ",");
      $fwrite(fp, "      %0d", imp.random_read_gap_q[i]);
    end
    $fdisplay(fp, "    ],");
    $fdisplay(fp, "    \"phases\": [");
    $fdisplay(fp, "      {\"phase\":\"A\",\"start\":{\"aw\":%0d,\"ar\":%0d,\"pending\":%0d,\"fa\":%0d,\"ea\":%0d,\"wr\":%0d,\"rd\":%0d},\"end\":{\"aw\":%0d,\"ar\":%0d,\"pending\":%0d,\"fa\":%0d,\"ea\":%0d,\"wr\":%0d,\"rd\":%0d}}",
      imp.phaseA_start.accepted_writes, imp.phaseA_start.accepted_reads, imp.phaseA_start.pending, imp.phaseA_start.full_write_attempts, imp.phaseA_start.empty_read_attempts, imp.phaseA_start.wr_edges, imp.phaseA_start.rd_edges,
      imp.phaseA_end.accepted_writes, imp.phaseA_end.accepted_reads, imp.phaseA_end.pending, imp.phaseA_end.full_write_attempts, imp.phaseA_end.empty_read_attempts, imp.phaseA_end.wr_edges, imp.phaseA_end.rd_edges);
    $fdisplay(fp, "      ,{\"phase\":\"B\",\"start\":{\"aw\":%0d,\"ar\":%0d,\"pending\":%0d,\"fa\":%0d,\"ea\":%0d,\"wr\":%0d,\"rd\":%0d},\"end\":{\"aw\":%0d,\"ar\":%0d,\"pending\":%0d,\"fa\":%0d,\"ea\":%0d,\"wr\":%0d,\"rd\":%0d}}",
      imp.phaseB_start.accepted_writes, imp.phaseB_start.accepted_reads, imp.phaseB_start.pending, imp.phaseB_start.full_write_attempts, imp.phaseB_start.empty_read_attempts, imp.phaseB_start.wr_edges, imp.phaseB_start.rd_edges,
      imp.phaseB_end.accepted_writes, imp.phaseB_end.accepted_reads, imp.phaseB_end.pending, imp.phaseB_end.full_write_attempts, imp.phaseB_end.empty_read_attempts, imp.phaseB_end.wr_edges, imp.phaseB_end.rd_edges);
    $fdisplay(fp, "      ,{\"phase\":\"C\",\"start\":{\"aw\":%0d,\"ar\":%0d,\"pending\":%0d,\"fa\":%0d,\"ea\":%0d,\"wr\":%0d,\"rd\":%0d},\"end\":{\"aw\":%0d,\"ar\":%0d,\"pending\":%0d,\"fa\":%0d,\"ea\":%0d,\"wr\":%0d,\"rd\":%0d}}",
      imp.phaseC_start.accepted_writes, imp.phaseC_start.accepted_reads, imp.phaseC_start.pending, imp.phaseC_start.full_write_attempts, imp.phaseC_start.empty_read_attempts, imp.phaseC_start.wr_edges, imp.phaseC_start.rd_edges,
      imp.phaseC_end.accepted_writes, imp.phaseC_end.accepted_reads, imp.phaseC_end.pending, imp.phaseC_end.full_write_attempts, imp.phaseC_end.empty_read_attempts, imp.phaseC_end.wr_edges, imp.phaseC_end.rd_edges);
    $fdisplay(fp, "      ,{\"phase\":\"D\",\"start\":{\"aw\":%0d,\"ar\":%0d,\"pending\":%0d,\"fa\":%0d,\"ea\":%0d,\"wr\":%0d,\"rd\":%0d},\"end\":{\"aw\":%0d,\"ar\":%0d,\"pending\":%0d,\"fa\":%0d,\"ea\":%0d,\"wr\":%0d,\"rd\":%0d}}",
      imp.phaseD_start.accepted_writes, imp.phaseD_start.accepted_reads, imp.phaseD_start.pending, imp.phaseD_start.full_write_attempts, imp.phaseD_start.empty_read_attempts, imp.phaseD_start.wr_edges, imp.phaseD_start.rd_edges,
      imp.phaseD_end.accepted_writes, imp.phaseD_end.accepted_reads, imp.phaseD_end.pending, imp.phaseD_end.full_write_attempts, imp.phaseD_end.empty_read_attempts, imp.phaseD_end.wr_edges, imp.phaseD_end.rd_edges);
    $fdisplay(fp, "      ,{\"phase\":\"E\",\"start\":{\"aw\":%0d,\"ar\":%0d,\"pending\":%0d,\"fa\":%0d,\"ea\":%0d,\"wr\":%0d,\"rd\":%0d},\"end\":{\"aw\":%0d,\"ar\":%0d,\"pending\":%0d,\"fa\":%0d,\"ea\":%0d,\"wr\":%0d,\"rd\":%0d}}",
      imp.phaseE_start.accepted_writes, imp.phaseE_start.accepted_reads, imp.phaseE_start.pending, imp.phaseE_start.full_write_attempts, imp.phaseE_start.empty_read_attempts, imp.phaseE_start.wr_edges, imp.phaseE_start.rd_edges,
      imp.phaseE_end.accepted_writes, imp.phaseE_end.accepted_reads, imp.phaseE_end.pending, imp.phaseE_end.full_write_attempts, imp.phaseE_end.empty_read_attempts, imp.phaseE_end.wr_edges, imp.phaseE_end.rd_edges);
    $fdisplay(fp, "    ],");
    $fdisplay(fp, "    \"rng_calls\": [");
    for (i = 0; i < imp.rng_calls.size(); i++) begin
      if (i != 0) $fdisplay(fp, ",");
      $fwrite(fp, "      {\"call\":\"%s\",\"phase\":\"%s\",\"blocking\":%s,\"count\":%0d,\"data_seed\":%0d,\"gap_seed\":%0d,\"min_data\":%0d,\"max_data\":%0d,\"min_gap\":%0d,\"max_gap\":%0d,\"sw\":%0d,\"sr\":%0d,\"sfa\":%0d,\"sea\":%0d,\"ew\":%0d,\"er\":%0d,\"efa\":%0d,\"eea\":%0d}",
        imp.rng_calls[i].call_name, imp.rng_calls[i].phase, imp.rng_calls[i].blocking ? "true" : "false", imp.rng_calls[i].count, imp.rng_calls[i].data_seed, imp.rng_calls[i].gap_seed, imp.rng_calls[i].min_data, imp.rng_calls[i].max_data, imp.rng_calls[i].min_gap, imp.rng_calls[i].max_gap,
        imp.rng_calls[i].start_writes, imp.rng_calls[i].start_reads, imp.rng_calls[i].start_full_attempts, imp.rng_calls[i].start_empty_attempts,
        imp.rng_calls[i].end_writes, imp.rng_calls[i].end_reads, imp.rng_calls[i].end_full_attempts, imp.rng_calls[i].end_empty_attempts);
    end
    $fdisplay(fp, "    ],");
    $fdisplay(fp, "    \"rng_requests\": [");
    for (i = 0; i < imp.rng_requests.size(); i++) begin
      if (i != 0) $fdisplay(fp, ",");
      $fwrite(fp, "      {\"call\":\"%s\",\"idx\":%0d,\"data\":%0d,\"gap\":%0d,\"accepted\":%s,\"blocked\":%s,\"time\":%0d,\"wr\":%0d,\"rd\":%0d}",
        imp.rng_requests[i].call_name, imp.rng_requests[i].request_idx, imp.rng_requests[i].data, imp.rng_requests[i].gap, imp.rng_requests[i].accepted ? "true" : "false", imp.rng_requests[i].blocked ? "true" : "false", imp.rng_requests[i].t, imp.rng_requests[i].wr_edges, imp.rng_requests[i].rd_edges);
    end
    $fdisplay(fp, "    ],");
    $fdisplay(fp, "    \"cdc_events\": [");
    for (i = 0; i < imp.cdc_events.size(); i++) begin
      if (i != 0) $fdisplay(fp, ",");
      $fwrite(fp, "      {\"intent\":\"%s\",\"flag\":\"%s\",\"domain\":\"%s\",\"src_kind\":\"%s\",\"direction\":\"%s\",\"time\":%0d,\"dest_cycle\":%0d,\"src_op_time\":%0d,\"src_op_cycle_src\":%0d,\"src_op_cycle_dst\":%0d,\"elapsed_dst_edges\":%0d,\"reset_caused\":%s}",
        imp.cdc_events[i].intent_id, imp.cdc_events[i].flag_name, imp.cdc_events[i].dest_domain, imp.cdc_events[i].src_kind, imp.cdc_events[i].direction ? "rise" : "fall", imp.cdc_events[i].t, imp.cdc_events[i].dest_cycle, imp.cdc_events[i].src_op_time, imp.cdc_events[i].src_op_cycle_src, imp.cdc_events[i].src_op_cycle_dst, imp.cdc_events[i].elapsed_dst_edges, imp.cdc_events[i].reset_caused ? "true" : "false");
    end
    $fdisplay(fp, "    ]");
    $fdisplay(fp, "  }");
    $fdisplay(fp, "}");
    $fclose(fp);
  endfunction

  initial begin
    bus.wr_clk = 0;
    bus.rd_clk = 0;
  end
  always #5 bus.wr_clk = ~bus.wr_clk;
  always #7 bus.rd_clk = ~bus.rd_clk;

  initial begin
    bus.wr_rst_n = 1;
    bus.rd_rst_n = 1;
    bus.wr_en = 0;
    bus.rd_en = 0;
    bus.wr_data = 0;
    prev_full = 0;
    prev_empty = 0;
    prev_wr_rst_n = 1;
    prev_rd_rst_n = 1;
    finished = 0;
    imp = new();
    api = pss_top::type_id().create(imp);
    coverage_zero();
    api.main_a();
    write_report();
    finished = 1;
    $finish;
  end

  initial begin
    #20000000;
    if (!finished) begin
      if (imp != null) begin
        imp.errors++;
        write_report();
      end
      $finish;
    end
  end
endmodule
