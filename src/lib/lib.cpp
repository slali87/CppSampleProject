#include "lib/lib.hpp"

#include <algorithm>
#include <cctype>
#include <string>

namespace lib {
std::string Lib::createUpperString(std::string string) const {
  std::transform(cbegin(string), cend(string), begin(string), ::toupper);
  return string;
}
}  // namespace lib