package zsp_gen_pkg;
  import zsp_rt_pkg::*;

  interface class import_api_if;
    pure virtual task exec_reset_write_domain(input bit [31:0] hold_cycles);
    pure virtual task exec_reset_read_domain(input bit [31:0] hold_cycles);
    pure virtual task exec_reset_both_domains(input bit [31:0] hold_cycles);
    pure virtual task exec_write_word(input bit [31:0] data, input bit blocking);
    pure virtual task exec_read_word(input bit blocking);
    pure virtual task exec_write_burst(input bit [31:0] count, input bit [31:0] start_data, input bit [31:0] increment, input bit [31:0] gap_cycles, input bit blocking);
    pure virtual task exec_read_burst(input bit [31:0] count, input bit [31:0] gap_cycles, input bit blocking);
    pure virtual task exec_write_random_burst(input bit [31:0] count, input bit [31:0] seed, input bit [31:0] min_data, input bit [31:0] max_data, input bit [31:0] gap_cycles, input bit blocking);
    pure virtual task exec_write_random_gap_burst(input bit [31:0] count, input bit [31:0] start_data, input bit [31:0] increment, input bit [31:0] seed, input bit [31:0] min_gap, input bit [31:0] max_gap, input bit blocking);
    pure virtual task exec_read_random_gap_burst(input bit [31:0] count, input bit [31:0] seed, input bit [31:0] min_gap, input bit [31:0] max_gap, input bit blocking);
    pure virtual task exec_wait_write_cycles(input bit [31:0] num_cycles);
    pure virtual task exec_wait_read_cycles(input bit [31:0] num_cycles);
    pure virtual task exec_sample_full();
    pure virtual task exec_sample_empty();
    pure virtual task exec_reset_scoreboard();
    pure virtual task exec_write_walking_burst(input bit [31:0] pattern, input bit [31:0] gap_cycles, input bit blocking);
    pure virtual task exec_write_random_data_gap_burst(input bit [31:0] count, input bit [31:0] data_seed, input bit [31:0] gap_seed, input bit [31:0] min_data, input bit [31:0] max_data, input bit [31:0] min_gap, input bit [31:0] max_gap, input bit blocking);
    pure virtual task exec_read_random_data_gap_burst(input bit [31:0] count, input bit [31:0] gap_seed, input bit [31:0] min_gap, input bit [31:0] max_gap, input bit blocking);
    pure virtual task begin_intent(input bit [31:0] index);
    pure virtual task end_intent(input bit [31:0] index);
  endclass
  class import_api_base implements import_api_if;

    virtual task exec_reset_write_domain(input bit [31:0] hold_cycles);
      $fatal(1, "exec_reset_write_domain not implemented");
    endtask

    virtual task exec_reset_read_domain(input bit [31:0] hold_cycles);
      $fatal(1, "exec_reset_read_domain not implemented");
    endtask

    virtual task exec_reset_both_domains(input bit [31:0] hold_cycles);
      $fatal(1, "exec_reset_both_domains not implemented");
    endtask

    virtual task exec_write_word(input bit [31:0] data, input bit blocking);
      $fatal(1, "exec_write_word not implemented");
    endtask

    virtual task exec_read_word(input bit blocking);
      $fatal(1, "exec_read_word not implemented");
    endtask

    virtual task exec_write_burst(input bit [31:0] count, input bit [31:0] start_data, input bit [31:0] increment, input bit [31:0] gap_cycles, input bit blocking);
      $fatal(1, "exec_write_burst not implemented");
    endtask

    virtual task exec_read_burst(input bit [31:0] count, input bit [31:0] gap_cycles, input bit blocking);
      $fatal(1, "exec_read_burst not implemented");
    endtask

    virtual task exec_write_random_burst(input bit [31:0] count, input bit [31:0] seed, input bit [31:0] min_data, input bit [31:0] max_data, input bit [31:0] gap_cycles, input bit blocking);
      $fatal(1, "exec_write_random_burst not implemented");
    endtask

    virtual task exec_write_random_gap_burst(input bit [31:0] count, input bit [31:0] start_data, input bit [31:0] increment, input bit [31:0] seed, input bit [31:0] min_gap, input bit [31:0] max_gap, input bit blocking);
      $fatal(1, "exec_write_random_gap_burst not implemented");
    endtask

    virtual task exec_read_random_gap_burst(input bit [31:0] count, input bit [31:0] seed, input bit [31:0] min_gap, input bit [31:0] max_gap, input bit blocking);
      $fatal(1, "exec_read_random_gap_burst not implemented");
    endtask

    virtual task exec_wait_write_cycles(input bit [31:0] num_cycles);
      $fatal(1, "exec_wait_write_cycles not implemented");
    endtask

    virtual task exec_wait_read_cycles(input bit [31:0] num_cycles);
      $fatal(1, "exec_wait_read_cycles not implemented");
    endtask

    virtual task exec_sample_full();
      $fatal(1, "exec_sample_full not implemented");
    endtask

    virtual task exec_sample_empty();
      $fatal(1, "exec_sample_empty not implemented");
    endtask

    virtual task exec_reset_scoreboard();
      $fatal(1, "exec_reset_scoreboard not implemented");
    endtask

    virtual task exec_write_walking_burst(input bit [31:0] pattern, input bit [31:0] gap_cycles, input bit blocking);
      $fatal(1, "exec_write_walking_burst not implemented");
    endtask

    virtual task exec_write_random_data_gap_burst(input bit [31:0] count, input bit [31:0] data_seed, input bit [31:0] gap_seed, input bit [31:0] min_data, input bit [31:0] max_data, input bit [31:0] min_gap, input bit [31:0] max_gap, input bit blocking);
      $fatal(1, "exec_write_random_data_gap_burst not implemented");
    endtask

    virtual task exec_read_random_data_gap_burst(input bit [31:0] count, input bit [31:0] gap_seed, input bit [31:0] min_gap, input bit [31:0] max_gap, input bit blocking);
      $fatal(1, "exec_read_random_data_gap_burst not implemented");
    endtask

    virtual task begin_intent(input bit [31:0] index);
      $fatal(1, "begin_intent not implemented");
    endtask

    virtual task end_intent(input bit [31:0] index);
      $fatal(1, "end_intent not implemented");
    endtask
  endclass
  interface class export_api_if;
    pure virtual task main_a();
  endclass
  interface class factory_if;
    pure virtual function export_api_if create(input import_api_if imp_if);
  endclass
  typedef enum logic[1:0] {
    EXCLUSIVE = 2'd0,
    SHARED = 2'd1
  } alloc_access_mode_e;
  typedef enum logic[1:0] {
    RANDOM = 2'd0,
    OVERLAP = 2'd1,
    SAME_ADDRESS = 2'd2
  } alloc_share_mode_e;
  typedef enum logic[1:0] {
    DONT_SKIP = 2'd0,
    SKIP = 2'd1
  } alloc_skip_mode_e;
  typedef enum logic[1:0] {
    C = 2'd0,
    CPP = 2'd1,
    SV = 2'd2
  } target_language_e;
  typedef enum logic[1:0] {
    TRUNCATE = 2'd0,
    APPEND = 2'd1,
    READ = 2'd2
  } file_option_e;
  typedef class pss_top;
  typedef class export_api_impl;
  class pss_top extends zsp_component implements factory_if;
    static pss_top self;
    import_api_if import_if;

    function new(input string name, input zsp_component parent);
      super.new(name, parent);
    endfunction

    static function pss_top type_id();
      if (self == null) self = new("factory", null);
      return self;
    endfunction

    virtual function export_api_if create(input import_api_if imp_if);
      export_api_impl ret = new(imp_if);
      return ret;
    endfunction
  endclass
  typedef class pss_top__reset_write_domain;
  typedef class pss_top__reset_read_domain;
  typedef class pss_top__reset_both_domains;
  typedef class pss_top__write_word;
  typedef class pss_top__read_word;
  typedef class pss_top__write_burst;
  typedef class pss_top__read_burst;
  typedef class pss_top__write_random_burst;
  typedef class pss_top__write_random_gap_burst;
  typedef class pss_top__read_random_gap_burst;
  typedef class pss_top__wait_write_cycles;
  typedef class pss_top__wait_read_cycles;
  typedef class pss_top__sample_full;
  typedef class pss_top__sample_empty;
  typedef class pss_top__reset_scoreboard;
  typedef class pss_top__write_walking_burst;
  typedef class pss_top__write_random_data_gap_burst;
  typedef class pss_top__read_random_data_gap_burst;
  typedef class pss_top__begin_intent_a;
  typedef class pss_top__end_intent_a;
  typedef class pss_top__reset_initialization_a;
  typedef class pss_top__single_write_read_roundtrip_a;
  typedef class pss_top__fill_to_full_and_block_a;
  typedef class pss_top__read_empty_underflow_a;
  typedef class pss_top__sequential_data_integrity_a;
  typedef class pss_top__concurrent_producer_consumer_a;
  typedef class pss_top__pointer_sync_flag_transitions_a;
  typedef class pss_top__coordinated_reset_mid_operation_a;
  typedef class pss_top__wrap_around_and_full_range_a;
  typedef class pss_top__randomized_stress_pattern_a;
  typedef class pss_top__main_a;
  class pss_top__reset_write_domain extends zsp_action;
    pss_top comp;
    rand bit [31:0] hold_cycles;

    virtual task body();
      comp.import_if.exec_reset_write_domain(hold_cycles);
    endtask
  endclass
  class pss_top__reset_read_domain extends zsp_action;
    pss_top comp;
    rand bit [31:0] hold_cycles;

    virtual task body();
      comp.import_if.exec_reset_read_domain(hold_cycles);
    endtask
  endclass
  class pss_top__reset_both_domains extends zsp_action;
    pss_top comp;
    rand bit [31:0] hold_cycles;

    virtual task body();
      comp.import_if.exec_reset_both_domains(hold_cycles);
    endtask
  endclass
  class pss_top__write_word extends zsp_action;
    pss_top comp;
    rand bit [31:0] data;
    rand bit blocking;

    virtual task body();
      comp.import_if.exec_write_word(data, blocking);
    endtask
  endclass
  class pss_top__read_word extends zsp_action;
    pss_top comp;
    rand bit blocking;

    virtual task body();
      comp.import_if.exec_read_word(blocking);
    endtask
  endclass
  class pss_top__write_burst extends zsp_action;
    pss_top comp;
    rand bit [31:0] count;
    rand bit [31:0] start_data;
    rand bit [31:0] increment;
    rand bit [31:0] gap_cycles;
    rand bit blocking;

    virtual task body();
      comp.import_if.exec_write_burst(count, start_data, increment, gap_cycles, blocking);
    endtask
  endclass
  class pss_top__read_burst extends zsp_action;
    pss_top comp;
    rand bit [31:0] count;
    rand bit [31:0] gap_cycles;
    rand bit blocking;

    virtual task body();
      comp.import_if.exec_read_burst(count, gap_cycles, blocking);
    endtask
  endclass
  class pss_top__write_random_burst extends zsp_action;
    pss_top comp;
    rand bit [31:0] count;
    rand bit [31:0] seed;
    rand bit [31:0] min_data;
    rand bit [31:0] max_data;
    rand bit [31:0] gap_cycles;
    rand bit blocking;

    virtual task body();
      comp.import_if.exec_write_random_burst(count, seed, min_data, max_data, gap_cycles, blocking);
    endtask
  endclass
  class pss_top__write_random_gap_burst extends zsp_action;
    pss_top comp;
    rand bit [31:0] count;
    rand bit [31:0] start_data;
    rand bit [31:0] increment;
    rand bit [31:0] seed;
    rand bit [31:0] min_gap;
    rand bit [31:0] max_gap;
    rand bit blocking;

    virtual task body();
      comp.import_if.exec_write_random_gap_burst(count, start_data, increment, seed, min_gap, max_gap, blocking);
    endtask
  endclass
  class pss_top__read_random_gap_burst extends zsp_action;
    pss_top comp;
    rand bit [31:0] count;
    rand bit [31:0] seed;
    rand bit [31:0] min_gap;
    rand bit [31:0] max_gap;
    rand bit blocking;

    virtual task body();
      comp.import_if.exec_read_random_gap_burst(count, seed, min_gap, max_gap, blocking);
    endtask
  endclass
  class pss_top__wait_write_cycles extends zsp_action;
    pss_top comp;
    rand bit [31:0] num_cycles;

    virtual task body();
      comp.import_if.exec_wait_write_cycles(num_cycles);
    endtask
  endclass
  class pss_top__wait_read_cycles extends zsp_action;
    pss_top comp;
    rand bit [31:0] num_cycles;

    virtual task body();
      comp.import_if.exec_wait_read_cycles(num_cycles);
    endtask
  endclass
  class pss_top__sample_full extends zsp_action;
    pss_top comp;

    virtual task body();
      comp.import_if.exec_sample_full();
    endtask
  endclass
  class pss_top__sample_empty extends zsp_action;
    pss_top comp;

    virtual task body();
      comp.import_if.exec_sample_empty();
    endtask
  endclass
  class pss_top__reset_scoreboard extends zsp_action;
    pss_top comp;

    virtual task body();
      comp.import_if.exec_reset_scoreboard();
    endtask
  endclass
  class pss_top__write_walking_burst extends zsp_action;
    pss_top comp;
    rand bit [31:0] pattern;
    rand bit [31:0] gap_cycles;
    rand bit blocking;

    virtual task body();
      comp.import_if.exec_write_walking_burst(pattern, gap_cycles, blocking);
    endtask
  endclass
  class pss_top__write_random_data_gap_burst extends zsp_action;
    pss_top comp;
    rand bit [31:0] count;
    rand bit [31:0] data_seed;
    rand bit [31:0] gap_seed;
    rand bit [31:0] min_data;
    rand bit [31:0] max_data;
    rand bit [31:0] min_gap;
    rand bit [31:0] max_gap;
    rand bit blocking;

    constraint min_data_c {
      (min_data == 0);
    }

    constraint max_data_c {
      (max_data == 4294967295);
    }

    constraint min_gap_c {
      (min_gap == 0);
    }

    virtual task body();
      comp.import_if.exec_write_random_data_gap_burst(count, data_seed, gap_seed, min_data, max_data, min_gap, max_gap, blocking);
    endtask
  endclass
  class pss_top__read_random_data_gap_burst extends zsp_action;
    pss_top comp;
    rand bit [31:0] count;
    rand bit [31:0] gap_seed;
    rand bit [31:0] min_gap;
    rand bit [31:0] max_gap;
    rand bit blocking;

    constraint min_gap_c {
      (min_gap == 0);
    }

    virtual task body();
      comp.import_if.exec_read_random_data_gap_burst(count, gap_seed, min_gap, max_gap, blocking);
    endtask
  endclass
  class pss_top__begin_intent_a extends zsp_action;
    pss_top comp;
    rand bit [31:0] index;

    virtual task body();
      comp.import_if.begin_intent(index);
    endtask
  endclass
  class pss_top__end_intent_a extends zsp_action;
    pss_top comp;
    rand bit [31:0] index;

    virtual task body();
      comp.import_if.end_intent(index);
    endtask
  endclass
  class pss_top__reset_initialization_a extends zsp_action;
    pss_top comp;

    virtual task body();
      `ZSP_TRACE_ACTION("begin_intent_a", comp.get_full_name());
      begin
        pss_top__begin_intent_a _anon_pss_top__begin_intent_a = new();
        _anon_pss_top__begin_intent_a.comp = comp;
        _anon_pss_top__begin_intent_a.pre_solve();
        if (!_anon_pss_top__begin_intent_a.randomize() with { (index == 0); })
          $fatal(1, "randomize failed: pss_top__begin_intent_a");
        _anon_pss_top__begin_intent_a.post_solve();
        _anon_pss_top__begin_intent_a.body();
      end
      `ZSP_TRACE_ACTION("reset_both_domains", comp.get_full_name());
      begin
        pss_top__reset_both_domains _anon_pss_top__reset_both_domains = new();
        _anon_pss_top__reset_both_domains.comp = comp;
        _anon_pss_top__reset_both_domains.pre_solve();
        if (!_anon_pss_top__reset_both_domains.randomize() with { (hold_cycles == 5); })
          $fatal(1, "randomize failed: pss_top__reset_both_domains");
        _anon_pss_top__reset_both_domains.post_solve();
        _anon_pss_top__reset_both_domains.body();
      end
      `ZSP_TRACE("parallel enter");
      fork
        `ZSP_TRACE_ACTION("wait_write_cycles", comp.get_full_name());
        begin
          pss_top__wait_write_cycles _anon_pss_top__wait_write_cycles = new();
          _anon_pss_top__wait_write_cycles.comp = comp;
          _anon_pss_top__wait_write_cycles.pre_solve();
          if (!_anon_pss_top__wait_write_cycles.randomize() with { (num_cycles == 10); })
            $fatal(1, "randomize failed: pss_top__wait_write_cycles");
          _anon_pss_top__wait_write_cycles.post_solve();
          _anon_pss_top__wait_write_cycles.body();
        end
        `ZSP_TRACE_ACTION("wait_read_cycles", comp.get_full_name());
        begin
          pss_top__wait_read_cycles _anon_pss_top__wait_read_cycles = new();
          _anon_pss_top__wait_read_cycles.comp = comp;
          _anon_pss_top__wait_read_cycles.pre_solve();
          if (!_anon_pss_top__wait_read_cycles.randomize() with { (num_cycles == 10); })
            $fatal(1, "randomize failed: pss_top__wait_read_cycles");
          _anon_pss_top__wait_read_cycles.post_solve();
          _anon_pss_top__wait_read_cycles.body();
        end
      join
      `ZSP_TRACE("parallel exit");
      `ZSP_TRACE("parallel enter");
      fork
        `ZSP_TRACE_ACTION("sample_full", comp.get_full_name());
        begin
          pss_top__sample_full _anon_pss_top__sample_full = new();
          _anon_pss_top__sample_full.comp = comp;
          _anon_pss_top__sample_full.pre_solve();
          if (!_anon_pss_top__sample_full.randomize())
            $fatal(1, "randomize failed: pss_top__sample_full");
          _anon_pss_top__sample_full.post_solve();
          _anon_pss_top__sample_full.body();
        end
        `ZSP_TRACE_ACTION("sample_empty", comp.get_full_name());
        begin
          pss_top__sample_empty _anon_pss_top__sample_empty = new();
          _anon_pss_top__sample_empty.comp = comp;
          _anon_pss_top__sample_empty.pre_solve();
          if (!_anon_pss_top__sample_empty.randomize())
            $fatal(1, "randomize failed: pss_top__sample_empty");
          _anon_pss_top__sample_empty.post_solve();
          _anon_pss_top__sample_empty.body();
        end
      join
      `ZSP_TRACE("parallel exit");
      `ZSP_TRACE_ACTION("end_intent_a", comp.get_full_name());
      begin
        pss_top__end_intent_a _anon_pss_top__end_intent_a = new();
        _anon_pss_top__end_intent_a.comp = comp;
        _anon_pss_top__end_intent_a.pre_solve();
        if (!_anon_pss_top__end_intent_a.randomize() with { (index == 0); })
          $fatal(1, "randomize failed: pss_top__end_intent_a");
        _anon_pss_top__end_intent_a.post_solve();
        _anon_pss_top__end_intent_a.body();
      end
    endtask
  endclass
  class pss_top__single_write_read_roundtrip_a extends zsp_action;
    pss_top comp;

    virtual task body();
      `ZSP_TRACE_ACTION("begin_intent_a", comp.get_full_name());
      begin
        pss_top__begin_intent_a _anon_pss_top__begin_intent_a = new();
        _anon_pss_top__begin_intent_a.comp = comp;
        _anon_pss_top__begin_intent_a.pre_solve();
        if (!_anon_pss_top__begin_intent_a.randomize() with { (index == 1); })
          $fatal(1, "randomize failed: pss_top__begin_intent_a");
        _anon_pss_top__begin_intent_a.post_solve();
        _anon_pss_top__begin_intent_a.body();
      end
      `ZSP_TRACE_ACTION("write_word", comp.get_full_name());
      begin
        pss_top__write_word _anon_pss_top__write_word = new();
        _anon_pss_top__write_word.comp = comp;
        _anon_pss_top__write_word.pre_solve();
        if (!_anon_pss_top__write_word.randomize() with { (data == 2779096485); (blocking == 1); })
          $fatal(1, "randomize failed: pss_top__write_word");
        _anon_pss_top__write_word.post_solve();
        _anon_pss_top__write_word.body();
      end
      `ZSP_TRACE_ACTION("wait_read_cycles", comp.get_full_name());
      begin
        pss_top__wait_read_cycles _anon_pss_top__wait_read_cycles = new();
        _anon_pss_top__wait_read_cycles.comp = comp;
        _anon_pss_top__wait_read_cycles.pre_solve();
        if (!_anon_pss_top__wait_read_cycles.randomize() with { (num_cycles == 10); })
          $fatal(1, "randomize failed: pss_top__wait_read_cycles");
        _anon_pss_top__wait_read_cycles.post_solve();
        _anon_pss_top__wait_read_cycles.body();
      end
      `ZSP_TRACE_ACTION("sample_empty", comp.get_full_name());
      begin
        pss_top__sample_empty _anon_pss_top__sample_empty = new();
        _anon_pss_top__sample_empty.comp = comp;
        _anon_pss_top__sample_empty.pre_solve();
        if (!_anon_pss_top__sample_empty.randomize())
          $fatal(1, "randomize failed: pss_top__sample_empty");
        _anon_pss_top__sample_empty.post_solve();
        _anon_pss_top__sample_empty.body();
      end
      `ZSP_TRACE_ACTION("read_word", comp.get_full_name());
      begin
        pss_top__read_word _anon_pss_top__read_word = new();
        _anon_pss_top__read_word.comp = comp;
        _anon_pss_top__read_word.pre_solve();
        if (!_anon_pss_top__read_word.randomize() with { (blocking == 1); })
          $fatal(1, "randomize failed: pss_top__read_word");
        _anon_pss_top__read_word.post_solve();
        _anon_pss_top__read_word.body();
      end
      `ZSP_TRACE_ACTION("wait_read_cycles", comp.get_full_name());
      begin
        pss_top__wait_read_cycles _anon_pss_top__wait_read_cycles = new();
        _anon_pss_top__wait_read_cycles.comp = comp;
        _anon_pss_top__wait_read_cycles.pre_solve();
        if (!_anon_pss_top__wait_read_cycles.randomize() with { (num_cycles == 10); })
          $fatal(1, "randomize failed: pss_top__wait_read_cycles");
        _anon_pss_top__wait_read_cycles.post_solve();
        _anon_pss_top__wait_read_cycles.body();
      end
      `ZSP_TRACE_ACTION("sample_empty", comp.get_full_name());
      begin
        pss_top__sample_empty _anon_pss_top__sample_empty = new();
        _anon_pss_top__sample_empty.comp = comp;
        _anon_pss_top__sample_empty.pre_solve();
        if (!_anon_pss_top__sample_empty.randomize())
          $fatal(1, "randomize failed: pss_top__sample_empty");
        _anon_pss_top__sample_empty.post_solve();
        _anon_pss_top__sample_empty.body();
      end
      `ZSP_TRACE_ACTION("end_intent_a", comp.get_full_name());
      begin
        pss_top__end_intent_a _anon_pss_top__end_intent_a = new();
        _anon_pss_top__end_intent_a.comp = comp;
        _anon_pss_top__end_intent_a.pre_solve();
        if (!_anon_pss_top__end_intent_a.randomize() with { (index == 1); })
          $fatal(1, "randomize failed: pss_top__end_intent_a");
        _anon_pss_top__end_intent_a.post_solve();
        _anon_pss_top__end_intent_a.body();
      end
    endtask
  endclass
  class pss_top__fill_to_full_and_block_a extends zsp_action;
    pss_top comp;

    virtual task body();
      `ZSP_TRACE_ACTION("begin_intent_a", comp.get_full_name());
      begin
        pss_top__begin_intent_a _anon_pss_top__begin_intent_a = new();
        _anon_pss_top__begin_intent_a.comp = comp;
        _anon_pss_top__begin_intent_a.pre_solve();
        if (!_anon_pss_top__begin_intent_a.randomize() with { (index == 2); })
          $fatal(1, "randomize failed: pss_top__begin_intent_a");
        _anon_pss_top__begin_intent_a.post_solve();
        _anon_pss_top__begin_intent_a.body();
      end
      `ZSP_TRACE_ACTION("write_burst", comp.get_full_name());
      begin
        pss_top__write_burst _anon_pss_top__write_burst = new();
        _anon_pss_top__write_burst.comp = comp;
        _anon_pss_top__write_burst.pre_solve();
        if (!_anon_pss_top__write_burst.randomize() with { (count == 65536); (start_data == 0); (increment == 1); (gap_cycles == 0); (blocking == 1); })
          $fatal(1, "randomize failed: pss_top__write_burst");
        _anon_pss_top__write_burst.post_solve();
        _anon_pss_top__write_burst.body();
      end
      `ZSP_TRACE_ACTION("wait_write_cycles", comp.get_full_name());
      begin
        pss_top__wait_write_cycles _anon_pss_top__wait_write_cycles = new();
        _anon_pss_top__wait_write_cycles.comp = comp;
        _anon_pss_top__wait_write_cycles.pre_solve();
        if (!_anon_pss_top__wait_write_cycles.randomize() with { (num_cycles == 10); })
          $fatal(1, "randomize failed: pss_top__wait_write_cycles");
        _anon_pss_top__wait_write_cycles.post_solve();
        _anon_pss_top__wait_write_cycles.body();
      end
      `ZSP_TRACE_ACTION("sample_full", comp.get_full_name());
      begin
        pss_top__sample_full _anon_pss_top__sample_full = new();
        _anon_pss_top__sample_full.comp = comp;
        _anon_pss_top__sample_full.pre_solve();
        if (!_anon_pss_top__sample_full.randomize())
          $fatal(1, "randomize failed: pss_top__sample_full");
        _anon_pss_top__sample_full.post_solve();
        _anon_pss_top__sample_full.body();
      end
      `ZSP_TRACE_ACTION("write_burst", comp.get_full_name());
      begin
        pss_top__write_burst _anon_pss_top__write_burst = new();
        _anon_pss_top__write_burst.comp = comp;
        _anon_pss_top__write_burst.pre_solve();
        if (!_anon_pss_top__write_burst.randomize() with { (count == 10); (start_data == 65536); (increment == 1); (gap_cycles == 0); (blocking == 0); })
          $fatal(1, "randomize failed: pss_top__write_burst");
        _anon_pss_top__write_burst.post_solve();
        _anon_pss_top__write_burst.body();
      end
      `ZSP_TRACE_ACTION("wait_write_cycles", comp.get_full_name());
      begin
        pss_top__wait_write_cycles _anon_pss_top__wait_write_cycles = new();
        _anon_pss_top__wait_write_cycles.comp = comp;
        _anon_pss_top__wait_write_cycles.pre_solve();
        if (!_anon_pss_top__wait_write_cycles.randomize() with { (num_cycles == 10); })
          $fatal(1, "randomize failed: pss_top__wait_write_cycles");
        _anon_pss_top__wait_write_cycles.post_solve();
        _anon_pss_top__wait_write_cycles.body();
      end
      `ZSP_TRACE_ACTION("read_burst", comp.get_full_name());
      begin
        pss_top__read_burst _anon_pss_top__read_burst = new();
        _anon_pss_top__read_burst.comp = comp;
        _anon_pss_top__read_burst.pre_solve();
        if (!_anon_pss_top__read_burst.randomize() with { (count == 1); (gap_cycles == 0); (blocking == 1); })
          $fatal(1, "randomize failed: pss_top__read_burst");
        _anon_pss_top__read_burst.post_solve();
        _anon_pss_top__read_burst.body();
      end
      `ZSP_TRACE_ACTION("wait_write_cycles", comp.get_full_name());
      begin
        pss_top__wait_write_cycles _anon_pss_top__wait_write_cycles = new();
        _anon_pss_top__wait_write_cycles.comp = comp;
        _anon_pss_top__wait_write_cycles.pre_solve();
        if (!_anon_pss_top__wait_write_cycles.randomize() with { (num_cycles == 10); })
          $fatal(1, "randomize failed: pss_top__wait_write_cycles");
        _anon_pss_top__wait_write_cycles.post_solve();
        _anon_pss_top__wait_write_cycles.body();
      end
      `ZSP_TRACE_ACTION("sample_full", comp.get_full_name());
      begin
        pss_top__sample_full _anon_pss_top__sample_full = new();
        _anon_pss_top__sample_full.comp = comp;
        _anon_pss_top__sample_full.pre_solve();
        if (!_anon_pss_top__sample_full.randomize())
          $fatal(1, "randomize failed: pss_top__sample_full");
        _anon_pss_top__sample_full.post_solve();
        _anon_pss_top__sample_full.body();
      end
      `ZSP_TRACE_ACTION("read_burst", comp.get_full_name());
      begin
        pss_top__read_burst _anon_pss_top__read_burst = new();
        _anon_pss_top__read_burst.comp = comp;
        _anon_pss_top__read_burst.pre_solve();
        if (!_anon_pss_top__read_burst.randomize() with { (count == 65535); (gap_cycles == 0); (blocking == 1); })
          $fatal(1, "randomize failed: pss_top__read_burst");
        _anon_pss_top__read_burst.post_solve();
        _anon_pss_top__read_burst.body();
      end
      `ZSP_TRACE_ACTION("end_intent_a", comp.get_full_name());
      begin
        pss_top__end_intent_a _anon_pss_top__end_intent_a = new();
        _anon_pss_top__end_intent_a.comp = comp;
        _anon_pss_top__end_intent_a.pre_solve();
        if (!_anon_pss_top__end_intent_a.randomize() with { (index == 2); })
          $fatal(1, "randomize failed: pss_top__end_intent_a");
        _anon_pss_top__end_intent_a.post_solve();
        _anon_pss_top__end_intent_a.body();
      end
    endtask
  endclass
  class pss_top__read_empty_underflow_a extends zsp_action;
    pss_top comp;

    virtual task body();
      `ZSP_TRACE_ACTION("begin_intent_a", comp.get_full_name());
      begin
        pss_top__begin_intent_a _anon_pss_top__begin_intent_a = new();
        _anon_pss_top__begin_intent_a.comp = comp;
        _anon_pss_top__begin_intent_a.pre_solve();
        if (!_anon_pss_top__begin_intent_a.randomize() with { (index == 3); })
          $fatal(1, "randomize failed: pss_top__begin_intent_a");
        _anon_pss_top__begin_intent_a.post_solve();
        _anon_pss_top__begin_intent_a.body();
      end
      `ZSP_TRACE_ACTION("read_burst", comp.get_full_name());
      begin
        pss_top__read_burst _anon_pss_top__read_burst = new();
        _anon_pss_top__read_burst.comp = comp;
        _anon_pss_top__read_burst.pre_solve();
        if (!_anon_pss_top__read_burst.randomize() with { (count == 10); (gap_cycles == 0); (blocking == 0); })
          $fatal(1, "randomize failed: pss_top__read_burst");
        _anon_pss_top__read_burst.post_solve();
        _anon_pss_top__read_burst.body();
      end
      `ZSP_TRACE_ACTION("wait_read_cycles", comp.get_full_name());
      begin
        pss_top__wait_read_cycles _anon_pss_top__wait_read_cycles = new();
        _anon_pss_top__wait_read_cycles.comp = comp;
        _anon_pss_top__wait_read_cycles.pre_solve();
        if (!_anon_pss_top__wait_read_cycles.randomize() with { (num_cycles == 10); })
          $fatal(1, "randomize failed: pss_top__wait_read_cycles");
        _anon_pss_top__wait_read_cycles.post_solve();
        _anon_pss_top__wait_read_cycles.body();
      end
      `ZSP_TRACE_ACTION("sample_empty", comp.get_full_name());
      begin
        pss_top__sample_empty _anon_pss_top__sample_empty = new();
        _anon_pss_top__sample_empty.comp = comp;
        _anon_pss_top__sample_empty.pre_solve();
        if (!_anon_pss_top__sample_empty.randomize())
          $fatal(1, "randomize failed: pss_top__sample_empty");
        _anon_pss_top__sample_empty.post_solve();
        _anon_pss_top__sample_empty.body();
      end
      `ZSP_TRACE_ACTION("write_word", comp.get_full_name());
      begin
        pss_top__write_word _anon_pss_top__write_word = new();
        _anon_pss_top__write_word.comp = comp;
        _anon_pss_top__write_word.pre_solve();
        if (!_anon_pss_top__write_word.randomize() with { (data == 42); (blocking == 1); })
          $fatal(1, "randomize failed: pss_top__write_word");
        _anon_pss_top__write_word.post_solve();
        _anon_pss_top__write_word.body();
      end
      `ZSP_TRACE_ACTION("wait_read_cycles", comp.get_full_name());
      begin
        pss_top__wait_read_cycles _anon_pss_top__wait_read_cycles = new();
        _anon_pss_top__wait_read_cycles.comp = comp;
        _anon_pss_top__wait_read_cycles.pre_solve();
        if (!_anon_pss_top__wait_read_cycles.randomize() with { (num_cycles == 10); })
          $fatal(1, "randomize failed: pss_top__wait_read_cycles");
        _anon_pss_top__wait_read_cycles.post_solve();
        _anon_pss_top__wait_read_cycles.body();
      end
      `ZSP_TRACE_ACTION("sample_empty", comp.get_full_name());
      begin
        pss_top__sample_empty _anon_pss_top__sample_empty = new();
        _anon_pss_top__sample_empty.comp = comp;
        _anon_pss_top__sample_empty.pre_solve();
        if (!_anon_pss_top__sample_empty.randomize())
          $fatal(1, "randomize failed: pss_top__sample_empty");
        _anon_pss_top__sample_empty.post_solve();
        _anon_pss_top__sample_empty.body();
      end
      `ZSP_TRACE_ACTION("read_word", comp.get_full_name());
      begin
        pss_top__read_word _anon_pss_top__read_word = new();
        _anon_pss_top__read_word.comp = comp;
        _anon_pss_top__read_word.pre_solve();
        if (!_anon_pss_top__read_word.randomize() with { (blocking == 1); })
          $fatal(1, "randomize failed: pss_top__read_word");
        _anon_pss_top__read_word.post_solve();
        _anon_pss_top__read_word.body();
      end
      `ZSP_TRACE_ACTION("wait_read_cycles", comp.get_full_name());
      begin
        pss_top__wait_read_cycles _anon_pss_top__wait_read_cycles = new();
        _anon_pss_top__wait_read_cycles.comp = comp;
        _anon_pss_top__wait_read_cycles.pre_solve();
        if (!_anon_pss_top__wait_read_cycles.randomize() with { (num_cycles == 10); })
          $fatal(1, "randomize failed: pss_top__wait_read_cycles");
        _anon_pss_top__wait_read_cycles.post_solve();
        _anon_pss_top__wait_read_cycles.body();
      end
      `ZSP_TRACE_ACTION("sample_empty", comp.get_full_name());
      begin
        pss_top__sample_empty _anon_pss_top__sample_empty = new();
        _anon_pss_top__sample_empty.comp = comp;
        _anon_pss_top__sample_empty.pre_solve();
        if (!_anon_pss_top__sample_empty.randomize())
          $fatal(1, "randomize failed: pss_top__sample_empty");
        _anon_pss_top__sample_empty.post_solve();
        _anon_pss_top__sample_empty.body();
      end
      `ZSP_TRACE_ACTION("end_intent_a", comp.get_full_name());
      begin
        pss_top__end_intent_a _anon_pss_top__end_intent_a = new();
        _anon_pss_top__end_intent_a.comp = comp;
        _anon_pss_top__end_intent_a.pre_solve();
        if (!_anon_pss_top__end_intent_a.randomize() with { (index == 3); })
          $fatal(1, "randomize failed: pss_top__end_intent_a");
        _anon_pss_top__end_intent_a.post_solve();
        _anon_pss_top__end_intent_a.body();
      end
    endtask
  endclass
  class pss_top__sequential_data_integrity_a extends zsp_action;
    pss_top comp;

    virtual task body();
      `ZSP_TRACE_ACTION("begin_intent_a", comp.get_full_name());
      begin
        pss_top__begin_intent_a _anon_pss_top__begin_intent_a = new();
        _anon_pss_top__begin_intent_a.comp = comp;
        _anon_pss_top__begin_intent_a.pre_solve();
        if (!_anon_pss_top__begin_intent_a.randomize() with { (index == 4); })
          $fatal(1, "randomize failed: pss_top__begin_intent_a");
        _anon_pss_top__begin_intent_a.post_solve();
        _anon_pss_top__begin_intent_a.body();
      end
      `ZSP_TRACE_ACTION("write_burst", comp.get_full_name());
      begin
        pss_top__write_burst _anon_pss_top__write_burst = new();
        _anon_pss_top__write_burst.comp = comp;
        _anon_pss_top__write_burst.pre_solve();
        if (!_anon_pss_top__write_burst.randomize() with { (count == 1000); (start_data == 0); (increment == 65538); (gap_cycles == 0); (blocking == 1); })
          $fatal(1, "randomize failed: pss_top__write_burst");
        _anon_pss_top__write_burst.post_solve();
        _anon_pss_top__write_burst.body();
      end
      `ZSP_TRACE_ACTION("read_burst", comp.get_full_name());
      begin
        pss_top__read_burst _anon_pss_top__read_burst = new();
        _anon_pss_top__read_burst.comp = comp;
        _anon_pss_top__read_burst.pre_solve();
        if (!_anon_pss_top__read_burst.randomize() with { (count == 1000); (gap_cycles == 0); (blocking == 1); })
          $fatal(1, "randomize failed: pss_top__read_burst");
        _anon_pss_top__read_burst.post_solve();
        _anon_pss_top__read_burst.body();
      end
      `ZSP_TRACE_ACTION("wait_read_cycles", comp.get_full_name());
      begin
        pss_top__wait_read_cycles _anon_pss_top__wait_read_cycles = new();
        _anon_pss_top__wait_read_cycles.comp = comp;
        _anon_pss_top__wait_read_cycles.pre_solve();
        if (!_anon_pss_top__wait_read_cycles.randomize() with { (num_cycles == 10); })
          $fatal(1, "randomize failed: pss_top__wait_read_cycles");
        _anon_pss_top__wait_read_cycles.post_solve();
        _anon_pss_top__wait_read_cycles.body();
      end
      `ZSP_TRACE_ACTION("sample_empty", comp.get_full_name());
      begin
        pss_top__sample_empty _anon_pss_top__sample_empty = new();
        _anon_pss_top__sample_empty.comp = comp;
        _anon_pss_top__sample_empty.pre_solve();
        if (!_anon_pss_top__sample_empty.randomize())
          $fatal(1, "randomize failed: pss_top__sample_empty");
        _anon_pss_top__sample_empty.post_solve();
        _anon_pss_top__sample_empty.body();
      end
      `ZSP_TRACE_ACTION("end_intent_a", comp.get_full_name());
      begin
        pss_top__end_intent_a _anon_pss_top__end_intent_a = new();
        _anon_pss_top__end_intent_a.comp = comp;
        _anon_pss_top__end_intent_a.pre_solve();
        if (!_anon_pss_top__end_intent_a.randomize() with { (index == 4); })
          $fatal(1, "randomize failed: pss_top__end_intent_a");
        _anon_pss_top__end_intent_a.post_solve();
        _anon_pss_top__end_intent_a.body();
      end
    endtask
  endclass
  class pss_top__concurrent_producer_consumer_a extends zsp_action;
    pss_top comp;

    virtual task body();
      `ZSP_TRACE_ACTION("begin_intent_a", comp.get_full_name());
      begin
        pss_top__begin_intent_a _anon_pss_top__begin_intent_a = new();
        _anon_pss_top__begin_intent_a.comp = comp;
        _anon_pss_top__begin_intent_a.pre_solve();
        if (!_anon_pss_top__begin_intent_a.randomize() with { (index == 5); })
          $fatal(1, "randomize failed: pss_top__begin_intent_a");
        _anon_pss_top__begin_intent_a.post_solve();
        _anon_pss_top__begin_intent_a.body();
      end
      `ZSP_TRACE("parallel enter");
      fork
        `ZSP_TRACE_ACTION("write_burst", comp.get_full_name());
        begin
          pss_top__write_burst _anon_pss_top__write_burst = new();
          _anon_pss_top__write_burst.comp = comp;
          _anon_pss_top__write_burst.pre_solve();
          if (!_anon_pss_top__write_burst.randomize() with { (count == 2000); (start_data == 0); (increment == 1); (gap_cycles == 0); (blocking == 1); })
            $fatal(1, "randomize failed: pss_top__write_burst");
          _anon_pss_top__write_burst.post_solve();
          _anon_pss_top__write_burst.body();
        end
        `ZSP_TRACE_ACTION("read_burst", comp.get_full_name());
        begin
          pss_top__read_burst _anon_pss_top__read_burst = new();
          _anon_pss_top__read_burst.comp = comp;
          _anon_pss_top__read_burst.pre_solve();
          if (!_anon_pss_top__read_burst.randomize() with { (count == 2000); (gap_cycles == 0); (blocking == 1); })
            $fatal(1, "randomize failed: pss_top__read_burst");
          _anon_pss_top__read_burst.post_solve();
          _anon_pss_top__read_burst.body();
        end
      join
      `ZSP_TRACE("parallel exit");
      `ZSP_TRACE_ACTION("end_intent_a", comp.get_full_name());
      begin
        pss_top__end_intent_a _anon_pss_top__end_intent_a = new();
        _anon_pss_top__end_intent_a.comp = comp;
        _anon_pss_top__end_intent_a.pre_solve();
        if (!_anon_pss_top__end_intent_a.randomize() with { (index == 5); })
          $fatal(1, "randomize failed: pss_top__end_intent_a");
        _anon_pss_top__end_intent_a.post_solve();
        _anon_pss_top__end_intent_a.body();
      end
    endtask
  endclass
  class pss_top__pointer_sync_flag_transitions_a extends zsp_action;
    pss_top comp;

    virtual task body();
      `ZSP_TRACE_ACTION("begin_intent_a", comp.get_full_name());
      begin
        pss_top__begin_intent_a _anon_pss_top__begin_intent_a = new();
        _anon_pss_top__begin_intent_a.comp = comp;
        _anon_pss_top__begin_intent_a.pre_solve();
        if (!_anon_pss_top__begin_intent_a.randomize() with { (index == 6); })
          $fatal(1, "randomize failed: pss_top__begin_intent_a");
        _anon_pss_top__begin_intent_a.post_solve();
        _anon_pss_top__begin_intent_a.body();
      end
      `ZSP_TRACE_ACTION("write_burst", comp.get_full_name());
      begin
        pss_top__write_burst _anon_pss_top__write_burst = new();
        _anon_pss_top__write_burst.comp = comp;
        _anon_pss_top__write_burst.pre_solve();
        if (!_anon_pss_top__write_burst.randomize() with { (count == 65530); (start_data == 0); (increment == 1); (gap_cycles == 0); (blocking == 1); })
          $fatal(1, "randomize failed: pss_top__write_burst");
        _anon_pss_top__write_burst.post_solve();
        _anon_pss_top__write_burst.body();
      end
      `ZSP_TRACE_ACTION("wait_write_cycles", comp.get_full_name());
      begin
        pss_top__wait_write_cycles _anon_pss_top__wait_write_cycles = new();
        _anon_pss_top__wait_write_cycles.comp = comp;
        _anon_pss_top__wait_write_cycles.pre_solve();
        if (!_anon_pss_top__wait_write_cycles.randomize() with { (num_cycles == 10); })
          $fatal(1, "randomize failed: pss_top__wait_write_cycles");
        _anon_pss_top__wait_write_cycles.post_solve();
        _anon_pss_top__wait_write_cycles.body();
      end
      `ZSP_TRACE_ACTION("sample_full", comp.get_full_name());
      begin
        pss_top__sample_full _anon_pss_top__sample_full = new();
        _anon_pss_top__sample_full.comp = comp;
        _anon_pss_top__sample_full.pre_solve();
        if (!_anon_pss_top__sample_full.randomize())
          $fatal(1, "randomize failed: pss_top__sample_full");
        _anon_pss_top__sample_full.post_solve();
        _anon_pss_top__sample_full.body();
      end
      `ZSP_TRACE_ACTION("wait_read_cycles", comp.get_full_name());
      begin
        pss_top__wait_read_cycles _anon_pss_top__wait_read_cycles = new();
        _anon_pss_top__wait_read_cycles.comp = comp;
        _anon_pss_top__wait_read_cycles.pre_solve();
        if (!_anon_pss_top__wait_read_cycles.randomize() with { (num_cycles == 10); })
          $fatal(1, "randomize failed: pss_top__wait_read_cycles");
        _anon_pss_top__wait_read_cycles.post_solve();
        _anon_pss_top__wait_read_cycles.body();
      end
      `ZSP_TRACE_ACTION("sample_empty", comp.get_full_name());
      begin
        pss_top__sample_empty _anon_pss_top__sample_empty = new();
        _anon_pss_top__sample_empty.comp = comp;
        _anon_pss_top__sample_empty.pre_solve();
        if (!_anon_pss_top__sample_empty.randomize())
          $fatal(1, "randomize failed: pss_top__sample_empty");
        _anon_pss_top__sample_empty.post_solve();
        _anon_pss_top__sample_empty.body();
      end
      `ZSP_TRACE_ACTION("write_burst", comp.get_full_name());
      begin
        pss_top__write_burst _anon_pss_top__write_burst = new();
        _anon_pss_top__write_burst.comp = comp;
        _anon_pss_top__write_burst.pre_solve();
        if (!_anon_pss_top__write_burst.randomize() with { (count == 6); (start_data == 65530); (increment == 1); (gap_cycles == 0); (blocking == 1); })
          $fatal(1, "randomize failed: pss_top__write_burst");
        _anon_pss_top__write_burst.post_solve();
        _anon_pss_top__write_burst.body();
      end
      `ZSP_TRACE_ACTION("wait_write_cycles", comp.get_full_name());
      begin
        pss_top__wait_write_cycles _anon_pss_top__wait_write_cycles = new();
        _anon_pss_top__wait_write_cycles.comp = comp;
        _anon_pss_top__wait_write_cycles.pre_solve();
        if (!_anon_pss_top__wait_write_cycles.randomize() with { (num_cycles == 10); })
          $fatal(1, "randomize failed: pss_top__wait_write_cycles");
        _anon_pss_top__wait_write_cycles.post_solve();
        _anon_pss_top__wait_write_cycles.body();
      end
      `ZSP_TRACE_ACTION("sample_full", comp.get_full_name());
      begin
        pss_top__sample_full _anon_pss_top__sample_full = new();
        _anon_pss_top__sample_full.comp = comp;
        _anon_pss_top__sample_full.pre_solve();
        if (!_anon_pss_top__sample_full.randomize())
          $fatal(1, "randomize failed: pss_top__sample_full");
        _anon_pss_top__sample_full.post_solve();
        _anon_pss_top__sample_full.body();
      end
      `ZSP_TRACE_ACTION("read_burst", comp.get_full_name());
      begin
        pss_top__read_burst _anon_pss_top__read_burst = new();
        _anon_pss_top__read_burst.comp = comp;
        _anon_pss_top__read_burst.pre_solve();
        if (!_anon_pss_top__read_burst.randomize() with { (count == 1); (gap_cycles == 0); (blocking == 1); })
          $fatal(1, "randomize failed: pss_top__read_burst");
        _anon_pss_top__read_burst.post_solve();
        _anon_pss_top__read_burst.body();
      end
      `ZSP_TRACE_ACTION("wait_write_cycles", comp.get_full_name());
      begin
        pss_top__wait_write_cycles _anon_pss_top__wait_write_cycles = new();
        _anon_pss_top__wait_write_cycles.comp = comp;
        _anon_pss_top__wait_write_cycles.pre_solve();
        if (!_anon_pss_top__wait_write_cycles.randomize() with { (num_cycles == 10); })
          $fatal(1, "randomize failed: pss_top__wait_write_cycles");
        _anon_pss_top__wait_write_cycles.post_solve();
        _anon_pss_top__wait_write_cycles.body();
      end
      `ZSP_TRACE_ACTION("sample_full", comp.get_full_name());
      begin
        pss_top__sample_full _anon_pss_top__sample_full = new();
        _anon_pss_top__sample_full.comp = comp;
        _anon_pss_top__sample_full.pre_solve();
        if (!_anon_pss_top__sample_full.randomize())
          $fatal(1, "randomize failed: pss_top__sample_full");
        _anon_pss_top__sample_full.post_solve();
        _anon_pss_top__sample_full.body();
      end
      `ZSP_TRACE_ACTION("read_burst", comp.get_full_name());
      begin
        pss_top__read_burst _anon_pss_top__read_burst = new();
        _anon_pss_top__read_burst.comp = comp;
        _anon_pss_top__read_burst.pre_solve();
        if (!_anon_pss_top__read_burst.randomize() with { (count == 65535); (gap_cycles == 0); (blocking == 1); })
          $fatal(1, "randomize failed: pss_top__read_burst");
        _anon_pss_top__read_burst.post_solve();
        _anon_pss_top__read_burst.body();
      end
      `ZSP_TRACE_ACTION("wait_read_cycles", comp.get_full_name());
      begin
        pss_top__wait_read_cycles _anon_pss_top__wait_read_cycles = new();
        _anon_pss_top__wait_read_cycles.comp = comp;
        _anon_pss_top__wait_read_cycles.pre_solve();
        if (!_anon_pss_top__wait_read_cycles.randomize() with { (num_cycles == 10); })
          $fatal(1, "randomize failed: pss_top__wait_read_cycles");
        _anon_pss_top__wait_read_cycles.post_solve();
        _anon_pss_top__wait_read_cycles.body();
      end
      `ZSP_TRACE_ACTION("sample_empty", comp.get_full_name());
      begin
        pss_top__sample_empty _anon_pss_top__sample_empty = new();
        _anon_pss_top__sample_empty.comp = comp;
        _anon_pss_top__sample_empty.pre_solve();
        if (!_anon_pss_top__sample_empty.randomize())
          $fatal(1, "randomize failed: pss_top__sample_empty");
        _anon_pss_top__sample_empty.post_solve();
        _anon_pss_top__sample_empty.body();
      end
      `ZSP_TRACE_ACTION("end_intent_a", comp.get_full_name());
      begin
        pss_top__end_intent_a _anon_pss_top__end_intent_a = new();
        _anon_pss_top__end_intent_a.comp = comp;
        _anon_pss_top__end_intent_a.pre_solve();
        if (!_anon_pss_top__end_intent_a.randomize() with { (index == 6); })
          $fatal(1, "randomize failed: pss_top__end_intent_a");
        _anon_pss_top__end_intent_a.post_solve();
        _anon_pss_top__end_intent_a.body();
      end
    endtask
  endclass
  class pss_top__coordinated_reset_mid_operation_a extends zsp_action;
    pss_top comp;

    virtual task body();
      `ZSP_TRACE_ACTION("begin_intent_a", comp.get_full_name());
      begin
        pss_top__begin_intent_a _anon_pss_top__begin_intent_a = new();
        _anon_pss_top__begin_intent_a.comp = comp;
        _anon_pss_top__begin_intent_a.pre_solve();
        if (!_anon_pss_top__begin_intent_a.randomize() with { (index == 7); })
          $fatal(1, "randomize failed: pss_top__begin_intent_a");
        _anon_pss_top__begin_intent_a.post_solve();
        _anon_pss_top__begin_intent_a.body();
      end
      `ZSP_TRACE_ACTION("write_burst", comp.get_full_name());
      begin
        pss_top__write_burst _anon_pss_top__write_burst = new();
        _anon_pss_top__write_burst.comp = comp;
        _anon_pss_top__write_burst.pre_solve();
        if (!_anon_pss_top__write_burst.randomize() with { (count == 100); (start_data == 0); (increment == 1); (gap_cycles == 0); (blocking == 1); })
          $fatal(1, "randomize failed: pss_top__write_burst");
        _anon_pss_top__write_burst.post_solve();
        _anon_pss_top__write_burst.body();
      end
      `ZSP_TRACE_ACTION("read_burst", comp.get_full_name());
      begin
        pss_top__read_burst _anon_pss_top__read_burst = new();
        _anon_pss_top__read_burst.comp = comp;
        _anon_pss_top__read_burst.pre_solve();
        if (!_anon_pss_top__read_burst.randomize() with { (count == 30); (gap_cycles == 0); (blocking == 1); })
          $fatal(1, "randomize failed: pss_top__read_burst");
        _anon_pss_top__read_burst.post_solve();
        _anon_pss_top__read_burst.body();
      end
      `ZSP_TRACE_ACTION("reset_both_domains", comp.get_full_name());
      begin
        pss_top__reset_both_domains _anon_pss_top__reset_both_domains = new();
        _anon_pss_top__reset_both_domains.comp = comp;
        _anon_pss_top__reset_both_domains.pre_solve();
        if (!_anon_pss_top__reset_both_domains.randomize() with { (hold_cycles == 5); })
          $fatal(1, "randomize failed: pss_top__reset_both_domains");
        _anon_pss_top__reset_both_domains.post_solve();
        _anon_pss_top__reset_both_domains.body();
      end
      `ZSP_TRACE("parallel enter");
      fork
        `ZSP_TRACE_ACTION("wait_write_cycles", comp.get_full_name());
        begin
          pss_top__wait_write_cycles _anon_pss_top__wait_write_cycles = new();
          _anon_pss_top__wait_write_cycles.comp = comp;
          _anon_pss_top__wait_write_cycles.pre_solve();
          if (!_anon_pss_top__wait_write_cycles.randomize() with { (num_cycles == 10); })
            $fatal(1, "randomize failed: pss_top__wait_write_cycles");
          _anon_pss_top__wait_write_cycles.post_solve();
          _anon_pss_top__wait_write_cycles.body();
        end
        `ZSP_TRACE_ACTION("wait_read_cycles", comp.get_full_name());
        begin
          pss_top__wait_read_cycles _anon_pss_top__wait_read_cycles = new();
          _anon_pss_top__wait_read_cycles.comp = comp;
          _anon_pss_top__wait_read_cycles.pre_solve();
          if (!_anon_pss_top__wait_read_cycles.randomize() with { (num_cycles == 10); })
            $fatal(1, "randomize failed: pss_top__wait_read_cycles");
          _anon_pss_top__wait_read_cycles.post_solve();
          _anon_pss_top__wait_read_cycles.body();
        end
      join
      `ZSP_TRACE("parallel exit");
      `ZSP_TRACE("parallel enter");
      fork
        `ZSP_TRACE_ACTION("sample_full", comp.get_full_name());
        begin
          pss_top__sample_full _anon_pss_top__sample_full = new();
          _anon_pss_top__sample_full.comp = comp;
          _anon_pss_top__sample_full.pre_solve();
          if (!_anon_pss_top__sample_full.randomize())
            $fatal(1, "randomize failed: pss_top__sample_full");
          _anon_pss_top__sample_full.post_solve();
          _anon_pss_top__sample_full.body();
        end
        `ZSP_TRACE_ACTION("sample_empty", comp.get_full_name());
        begin
          pss_top__sample_empty _anon_pss_top__sample_empty = new();
          _anon_pss_top__sample_empty.comp = comp;
          _anon_pss_top__sample_empty.pre_solve();
          if (!_anon_pss_top__sample_empty.randomize())
            $fatal(1, "randomize failed: pss_top__sample_empty");
          _anon_pss_top__sample_empty.post_solve();
          _anon_pss_top__sample_empty.body();
        end
      join
      `ZSP_TRACE("parallel exit");
      `ZSP_TRACE_ACTION("write_word", comp.get_full_name());
      begin
        pss_top__write_word _anon_pss_top__write_word = new();
        _anon_pss_top__write_word.comp = comp;
        _anon_pss_top__write_word.pre_solve();
        if (!_anon_pss_top__write_word.randomize() with { (data == 12345); (blocking == 1); })
          $fatal(1, "randomize failed: pss_top__write_word");
        _anon_pss_top__write_word.post_solve();
        _anon_pss_top__write_word.body();
      end
      `ZSP_TRACE_ACTION("read_word", comp.get_full_name());
      begin
        pss_top__read_word _anon_pss_top__read_word = new();
        _anon_pss_top__read_word.comp = comp;
        _anon_pss_top__read_word.pre_solve();
        if (!_anon_pss_top__read_word.randomize() with { (blocking == 1); })
          $fatal(1, "randomize failed: pss_top__read_word");
        _anon_pss_top__read_word.post_solve();
        _anon_pss_top__read_word.body();
      end
      `ZSP_TRACE_ACTION("end_intent_a", comp.get_full_name());
      begin
        pss_top__end_intent_a _anon_pss_top__end_intent_a = new();
        _anon_pss_top__end_intent_a.comp = comp;
        _anon_pss_top__end_intent_a.pre_solve();
        if (!_anon_pss_top__end_intent_a.randomize() with { (index == 7); })
          $fatal(1, "randomize failed: pss_top__end_intent_a");
        _anon_pss_top__end_intent_a.post_solve();
        _anon_pss_top__end_intent_a.body();
      end
    endtask
  endclass
  class pss_top__wrap_around_and_full_range_a extends zsp_action;
    pss_top comp;

    virtual task body();
      `ZSP_TRACE_ACTION("begin_intent_a", comp.get_full_name());
      begin
        pss_top__begin_intent_a _anon_pss_top__begin_intent_a = new();
        _anon_pss_top__begin_intent_a.comp = comp;
        _anon_pss_top__begin_intent_a.pre_solve();
        if (!_anon_pss_top__begin_intent_a.randomize() with { (index == 8); })
          $fatal(1, "randomize failed: pss_top__begin_intent_a");
        _anon_pss_top__begin_intent_a.post_solve();
        _anon_pss_top__begin_intent_a.body();
      end
      `ZSP_TRACE("parallel enter");
      fork
        `ZSP_TRACE_ACTION("write_burst", comp.get_full_name());
        begin
          pss_top__write_burst _anon_pss_top__write_burst = new();
          _anon_pss_top__write_burst.comp = comp;
          _anon_pss_top__write_burst.pre_solve();
          if (!_anon_pss_top__write_burst.randomize() with { (count == 80000); (start_data == 0); (increment == 1); (gap_cycles == 0); (blocking == 1); })
            $fatal(1, "randomize failed: pss_top__write_burst");
          _anon_pss_top__write_burst.post_solve();
          _anon_pss_top__write_burst.body();
        end
        `ZSP_TRACE_ACTION("read_burst", comp.get_full_name());
        begin
          pss_top__read_burst _anon_pss_top__read_burst = new();
          _anon_pss_top__read_burst.comp = comp;
          _anon_pss_top__read_burst.pre_solve();
          if (!_anon_pss_top__read_burst.randomize() with { (count == 80000); (gap_cycles == 0); (blocking == 1); })
            $fatal(1, "randomize failed: pss_top__read_burst");
          _anon_pss_top__read_burst.post_solve();
          _anon_pss_top__read_burst.body();
        end
      join
      `ZSP_TRACE("parallel exit");
      `ZSP_TRACE_ACTION("wait_read_cycles", comp.get_full_name());
      begin
        pss_top__wait_read_cycles _anon_pss_top__wait_read_cycles = new();
        _anon_pss_top__wait_read_cycles.comp = comp;
        _anon_pss_top__wait_read_cycles.pre_solve();
        if (!_anon_pss_top__wait_read_cycles.randomize() with { (num_cycles == 10); })
          $fatal(1, "randomize failed: pss_top__wait_read_cycles");
        _anon_pss_top__wait_read_cycles.post_solve();
        _anon_pss_top__wait_read_cycles.body();
      end
      `ZSP_TRACE_ACTION("sample_empty", comp.get_full_name());
      begin
        pss_top__sample_empty _anon_pss_top__sample_empty = new();
        _anon_pss_top__sample_empty.comp = comp;
        _anon_pss_top__sample_empty.pre_solve();
        if (!_anon_pss_top__sample_empty.randomize())
          $fatal(1, "randomize failed: pss_top__sample_empty");
        _anon_pss_top__sample_empty.post_solve();
        _anon_pss_top__sample_empty.body();
      end
      `ZSP_TRACE_ACTION("end_intent_a", comp.get_full_name());
      begin
        pss_top__end_intent_a _anon_pss_top__end_intent_a = new();
        _anon_pss_top__end_intent_a.comp = comp;
        _anon_pss_top__end_intent_a.pre_solve();
        if (!_anon_pss_top__end_intent_a.randomize() with { (index == 8); })
          $fatal(1, "randomize failed: pss_top__end_intent_a");
        _anon_pss_top__end_intent_a.post_solve();
        _anon_pss_top__end_intent_a.body();
      end
    endtask
  endclass
  class pss_top__randomized_stress_pattern_a extends zsp_action;
    pss_top comp;

    virtual task body();
      `ZSP_TRACE_ACTION("begin_intent_a", comp.get_full_name());
      begin
        pss_top__begin_intent_a _anon_pss_top__begin_intent_a = new();
        _anon_pss_top__begin_intent_a.comp = comp;
        _anon_pss_top__begin_intent_a.pre_solve();
        if (!_anon_pss_top__begin_intent_a.randomize() with { (index == 9); })
          $fatal(1, "randomize failed: pss_top__begin_intent_a");
        _anon_pss_top__begin_intent_a.post_solve();
        _anon_pss_top__begin_intent_a.body();
      end
      `ZSP_TRACE_ACTION("write_burst", comp.get_full_name());
      begin
        pss_top__write_burst _anon_pss_top__write_burst = new();
        _anon_pss_top__write_burst.comp = comp;
        _anon_pss_top__write_burst.pre_solve();
        if (!_anon_pss_top__write_burst.randomize() with { (count == 65530); (start_data == 0); (increment == 1); (gap_cycles == 0); (blocking == 1); })
          $fatal(1, "randomize failed: pss_top__write_burst");
        _anon_pss_top__write_burst.post_solve();
        _anon_pss_top__write_burst.body();
      end
      `ZSP_TRACE_ACTION("write_random_data_gap_burst", comp.get_full_name());
      begin
        pss_top__write_random_data_gap_burst _anon_pss_top__write_random_data_gap_burst = new();
        _anon_pss_top__write_random_data_gap_burst.comp = comp;
        _anon_pss_top__write_random_data_gap_burst.pre_solve();
        if (!_anon_pss_top__write_random_data_gap_burst.randomize() with { (count == 6); (data_seed == 12345); (gap_seed == 67890); (min_data == 0); (max_data == 4294967295); (min_gap == 0); (max_gap == 5); (blocking == 1); })
          $fatal(1, "randomize failed: pss_top__write_random_data_gap_burst");
        _anon_pss_top__write_random_data_gap_burst.post_solve();
        _anon_pss_top__write_random_data_gap_burst.body();
      end
      `ZSP_TRACE_ACTION("wait_write_cycles", comp.get_full_name());
      begin
        pss_top__wait_write_cycles _anon_pss_top__wait_write_cycles = new();
        _anon_pss_top__wait_write_cycles.comp = comp;
        _anon_pss_top__wait_write_cycles.pre_solve();
        if (!_anon_pss_top__wait_write_cycles.randomize() with { (num_cycles == 10); })
          $fatal(1, "randomize failed: pss_top__wait_write_cycles");
        _anon_pss_top__wait_write_cycles.post_solve();
        _anon_pss_top__wait_write_cycles.body();
      end
      `ZSP_TRACE_ACTION("sample_full", comp.get_full_name());
      begin
        pss_top__sample_full _anon_pss_top__sample_full = new();
        _anon_pss_top__sample_full.comp = comp;
        _anon_pss_top__sample_full.pre_solve();
        if (!_anon_pss_top__sample_full.randomize())
          $fatal(1, "randomize failed: pss_top__sample_full");
        _anon_pss_top__sample_full.post_solve();
        _anon_pss_top__sample_full.body();
      end
      `ZSP_TRACE_ACTION("write_random_data_gap_burst", comp.get_full_name());
      begin
        pss_top__write_random_data_gap_burst _anon_pss_top__write_random_data_gap_burst = new();
        _anon_pss_top__write_random_data_gap_burst.comp = comp;
        _anon_pss_top__write_random_data_gap_burst.pre_solve();
        if (!_anon_pss_top__write_random_data_gap_burst.randomize() with { (count == 20); (data_seed == 11111); (gap_seed == 22222); (min_data == 0); (max_data == 4294967295); (min_gap == 0); (max_gap == 5); (blocking == 0); })
          $fatal(1, "randomize failed: pss_top__write_random_data_gap_burst");
        _anon_pss_top__write_random_data_gap_burst.post_solve();
        _anon_pss_top__write_random_data_gap_burst.body();
      end
      `ZSP_TRACE_ACTION("read_burst", comp.get_full_name());
      begin
        pss_top__read_burst _anon_pss_top__read_burst = new();
        _anon_pss_top__read_burst.comp = comp;
        _anon_pss_top__read_burst.pre_solve();
        if (!_anon_pss_top__read_burst.randomize() with { (count == 65536); (gap_cycles == 0); (blocking == 1); })
          $fatal(1, "randomize failed: pss_top__read_burst");
        _anon_pss_top__read_burst.post_solve();
        _anon_pss_top__read_burst.body();
      end
      `ZSP_TRACE_ACTION("wait_write_cycles", comp.get_full_name());
      begin
        pss_top__wait_write_cycles _anon_pss_top__wait_write_cycles = new();
        _anon_pss_top__wait_write_cycles.comp = comp;
        _anon_pss_top__wait_write_cycles.pre_solve();
        if (!_anon_pss_top__wait_write_cycles.randomize() with { (num_cycles == 10); })
          $fatal(1, "randomize failed: pss_top__wait_write_cycles");
        _anon_pss_top__wait_write_cycles.post_solve();
        _anon_pss_top__wait_write_cycles.body();
      end
      `ZSP_TRACE_ACTION("sample_full", comp.get_full_name());
      begin
        pss_top__sample_full _anon_pss_top__sample_full = new();
        _anon_pss_top__sample_full.comp = comp;
        _anon_pss_top__sample_full.pre_solve();
        if (!_anon_pss_top__sample_full.randomize())
          $fatal(1, "randomize failed: pss_top__sample_full");
        _anon_pss_top__sample_full.post_solve();
        _anon_pss_top__sample_full.body();
      end
      `ZSP_TRACE_ACTION("wait_read_cycles", comp.get_full_name());
      begin
        pss_top__wait_read_cycles _anon_pss_top__wait_read_cycles = new();
        _anon_pss_top__wait_read_cycles.comp = comp;
        _anon_pss_top__wait_read_cycles.pre_solve();
        if (!_anon_pss_top__wait_read_cycles.randomize() with { (num_cycles == 10); })
          $fatal(1, "randomize failed: pss_top__wait_read_cycles");
        _anon_pss_top__wait_read_cycles.post_solve();
        _anon_pss_top__wait_read_cycles.body();
      end
      `ZSP_TRACE_ACTION("sample_empty", comp.get_full_name());
      begin
        pss_top__sample_empty _anon_pss_top__sample_empty = new();
        _anon_pss_top__sample_empty.comp = comp;
        _anon_pss_top__sample_empty.pre_solve();
        if (!_anon_pss_top__sample_empty.randomize())
          $fatal(1, "randomize failed: pss_top__sample_empty");
        _anon_pss_top__sample_empty.post_solve();
        _anon_pss_top__sample_empty.body();
      end
      `ZSP_TRACE_ACTION("read_random_data_gap_burst", comp.get_full_name());
      begin
        pss_top__read_random_data_gap_burst _anon_pss_top__read_random_data_gap_burst = new();
        _anon_pss_top__read_random_data_gap_burst.comp = comp;
        _anon_pss_top__read_random_data_gap_burst.pre_solve();
        if (!_anon_pss_top__read_random_data_gap_burst.randomize() with { (count == 20); (gap_seed == 33333); (min_gap == 0); (max_gap == 5); (blocking == 0); })
          $fatal(1, "randomize failed: pss_top__read_random_data_gap_burst");
        _anon_pss_top__read_random_data_gap_burst.post_solve();
        _anon_pss_top__read_random_data_gap_burst.body();
      end
      `ZSP_TRACE_ACTION("wait_read_cycles", comp.get_full_name());
      begin
        pss_top__wait_read_cycles _anon_pss_top__wait_read_cycles = new();
        _anon_pss_top__wait_read_cycles.comp = comp;
        _anon_pss_top__wait_read_cycles.pre_solve();
        if (!_anon_pss_top__wait_read_cycles.randomize() with { (num_cycles == 10); })
          $fatal(1, "randomize failed: pss_top__wait_read_cycles");
        _anon_pss_top__wait_read_cycles.post_solve();
        _anon_pss_top__wait_read_cycles.body();
      end
      `ZSP_TRACE_ACTION("sample_empty", comp.get_full_name());
      begin
        pss_top__sample_empty _anon_pss_top__sample_empty = new();
        _anon_pss_top__sample_empty.comp = comp;
        _anon_pss_top__sample_empty.pre_solve();
        if (!_anon_pss_top__sample_empty.randomize())
          $fatal(1, "randomize failed: pss_top__sample_empty");
        _anon_pss_top__sample_empty.post_solve();
        _anon_pss_top__sample_empty.body();
      end
      `ZSP_TRACE_ACTION("end_intent_a", comp.get_full_name());
      begin
        pss_top__end_intent_a _anon_pss_top__end_intent_a = new();
        _anon_pss_top__end_intent_a.comp = comp;
        _anon_pss_top__end_intent_a.pre_solve();
        if (!_anon_pss_top__end_intent_a.randomize() with { (index == 9); })
          $fatal(1, "randomize failed: pss_top__end_intent_a");
        _anon_pss_top__end_intent_a.post_solve();
        _anon_pss_top__end_intent_a.body();
      end
    endtask
  endclass
  class pss_top__main_a extends zsp_action;
    pss_top comp;

    virtual task body();
      `ZSP_TRACE_ACTION("reset_initialization_a", comp.get_full_name());
      begin
        pss_top__reset_initialization_a _anon_pss_top__reset_initialization_a = new();
        _anon_pss_top__reset_initialization_a.comp = comp;
        _anon_pss_top__reset_initialization_a.pre_solve();
        if (!_anon_pss_top__reset_initialization_a.randomize())
          $fatal(1, "randomize failed: pss_top__reset_initialization_a");
        _anon_pss_top__reset_initialization_a.post_solve();
        _anon_pss_top__reset_initialization_a.body();
      end
      `ZSP_TRACE_ACTION("single_write_read_roundtrip_a", comp.get_full_name());
      begin
        pss_top__single_write_read_roundtrip_a _anon_pss_top__single_write_read_roundtrip_a = new();
        _anon_pss_top__single_write_read_roundtrip_a.comp = comp;
        _anon_pss_top__single_write_read_roundtrip_a.pre_solve();
        if (!_anon_pss_top__single_write_read_roundtrip_a.randomize())
          $fatal(1, "randomize failed: pss_top__single_write_read_roundtrip_a");
        _anon_pss_top__single_write_read_roundtrip_a.post_solve();
        _anon_pss_top__single_write_read_roundtrip_a.body();
      end
      `ZSP_TRACE_ACTION("fill_to_full_and_block_a", comp.get_full_name());
      begin
        pss_top__fill_to_full_and_block_a _anon_pss_top__fill_to_full_and_block_a = new();
        _anon_pss_top__fill_to_full_and_block_a.comp = comp;
        _anon_pss_top__fill_to_full_and_block_a.pre_solve();
        if (!_anon_pss_top__fill_to_full_and_block_a.randomize())
          $fatal(1, "randomize failed: pss_top__fill_to_full_and_block_a");
        _anon_pss_top__fill_to_full_and_block_a.post_solve();
        _anon_pss_top__fill_to_full_and_block_a.body();
      end
      `ZSP_TRACE_ACTION("read_empty_underflow_a", comp.get_full_name());
      begin
        pss_top__read_empty_underflow_a _anon_pss_top__read_empty_underflow_a = new();
        _anon_pss_top__read_empty_underflow_a.comp = comp;
        _anon_pss_top__read_empty_underflow_a.pre_solve();
        if (!_anon_pss_top__read_empty_underflow_a.randomize())
          $fatal(1, "randomize failed: pss_top__read_empty_underflow_a");
        _anon_pss_top__read_empty_underflow_a.post_solve();
        _anon_pss_top__read_empty_underflow_a.body();
      end
      `ZSP_TRACE_ACTION("sequential_data_integrity_a", comp.get_full_name());
      begin
        pss_top__sequential_data_integrity_a _anon_pss_top__sequential_data_integrity_a = new();
        _anon_pss_top__sequential_data_integrity_a.comp = comp;
        _anon_pss_top__sequential_data_integrity_a.pre_solve();
        if (!_anon_pss_top__sequential_data_integrity_a.randomize())
          $fatal(1, "randomize failed: pss_top__sequential_data_integrity_a");
        _anon_pss_top__sequential_data_integrity_a.post_solve();
        _anon_pss_top__sequential_data_integrity_a.body();
      end
      `ZSP_TRACE_ACTION("concurrent_producer_consumer_a", comp.get_full_name());
      begin
        pss_top__concurrent_producer_consumer_a _anon_pss_top__concurrent_producer_consumer_a = new();
        _anon_pss_top__concurrent_producer_consumer_a.comp = comp;
        _anon_pss_top__concurrent_producer_consumer_a.pre_solve();
        if (!_anon_pss_top__concurrent_producer_consumer_a.randomize())
          $fatal(1, "randomize failed: pss_top__concurrent_producer_consumer_a");
        _anon_pss_top__concurrent_producer_consumer_a.post_solve();
        _anon_pss_top__concurrent_producer_consumer_a.body();
      end
      `ZSP_TRACE_ACTION("pointer_sync_flag_transitions_a", comp.get_full_name());
      begin
        pss_top__pointer_sync_flag_transitions_a _anon_pss_top__pointer_sync_flag_transitions_a = new();
        _anon_pss_top__pointer_sync_flag_transitions_a.comp = comp;
        _anon_pss_top__pointer_sync_flag_transitions_a.pre_solve();
        if (!_anon_pss_top__pointer_sync_flag_transitions_a.randomize())
          $fatal(1, "randomize failed: pss_top__pointer_sync_flag_transitions_a");
        _anon_pss_top__pointer_sync_flag_transitions_a.post_solve();
        _anon_pss_top__pointer_sync_flag_transitions_a.body();
      end
      `ZSP_TRACE_ACTION("coordinated_reset_mid_operation_a", comp.get_full_name());
      begin
        pss_top__coordinated_reset_mid_operation_a _anon_pss_top__coordinated_reset_mid_operation_a = new();
        _anon_pss_top__coordinated_reset_mid_operation_a.comp = comp;
        _anon_pss_top__coordinated_reset_mid_operation_a.pre_solve();
        if (!_anon_pss_top__coordinated_reset_mid_operation_a.randomize())
          $fatal(1, "randomize failed: pss_top__coordinated_reset_mid_operation_a");
        _anon_pss_top__coordinated_reset_mid_operation_a.post_solve();
        _anon_pss_top__coordinated_reset_mid_operation_a.body();
      end
      `ZSP_TRACE_ACTION("wrap_around_and_full_range_a", comp.get_full_name());
      begin
        pss_top__wrap_around_and_full_range_a _anon_pss_top__wrap_around_and_full_range_a = new();
        _anon_pss_top__wrap_around_and_full_range_a.comp = comp;
        _anon_pss_top__wrap_around_and_full_range_a.pre_solve();
        if (!_anon_pss_top__wrap_around_and_full_range_a.randomize())
          $fatal(1, "randomize failed: pss_top__wrap_around_and_full_range_a");
        _anon_pss_top__wrap_around_and_full_range_a.post_solve();
        _anon_pss_top__wrap_around_and_full_range_a.body();
      end
      `ZSP_TRACE_ACTION("randomized_stress_pattern_a", comp.get_full_name());
      begin
        pss_top__randomized_stress_pattern_a _anon_pss_top__randomized_stress_pattern_a = new();
        _anon_pss_top__randomized_stress_pattern_a.comp = comp;
        _anon_pss_top__randomized_stress_pattern_a.pre_solve();
        if (!_anon_pss_top__randomized_stress_pattern_a.randomize())
          $fatal(1, "randomize failed: pss_top__randomized_stress_pattern_a");
        _anon_pss_top__randomized_stress_pattern_a.post_solve();
        _anon_pss_top__randomized_stress_pattern_a.body();
      end
    endtask
  endclass
  class export_api_impl extends pss_top implements export_api_if;

    function new(input import_api_if imp_if);
      super.new("top", null);
      import_if = imp_if;
    endfunction

    task main_a();
      begin
        automatic pss_top__main_a root = new();
        root.comp = this;
        root.pre_solve();
        if (!root.randomize()) $fatal(1, "root action randomize failed");
        root.post_solve();
        root.activity();
      end
    endtask
  endclass
  class main_a_runner implements pss_action_run_if;
    export_api_if m_api;

    function new(input export_api_if ep);
      m_api = ep;
    endfunction

    static function pss_action_run_if create(input export_api_if ep);
      main_a_runner self = new(ep);
      return self;
    endfunction

    virtual task run();
      m_api.main_a();
    endtask
  endclass

endpackage : zsp_gen_pkg
