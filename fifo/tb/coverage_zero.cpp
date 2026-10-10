#include "verilated.h"
#include "verilated_cov.h"
extern "C" void coverage_zero() {
  Verilated::threadContextp()->coveragep()->zero();
}
