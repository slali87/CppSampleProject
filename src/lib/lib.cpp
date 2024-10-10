#include "lib/lib.hpp"

#include <algorithm>
#include <cctype>
#include <string>

namespace lib {
std::string Lib::createUpperString(std::string string) const {
  std::for_each(std::begin(string), std::end(string), ::toupper);
  return string;
}
}  // namespace lib