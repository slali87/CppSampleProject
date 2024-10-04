#include "lib/lib.hpp"

namespace lib {
std::string Lib::createUpperString(std::string string) const noexcept {
  for (auto &c : string) {
    c = std::toupper(c);
  }
  return string;
}
}  // namespace lib