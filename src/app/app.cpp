#include "app.hpp"

#include <iostream>

using std::cout;

namespace app {
int App::main() {
  cout << "Hello World!\n";
  // Silence since the default parameter was declared in std::basic_string
  // NOLINTNEXTLINE(fuchsia-default-arguments-calls)
  cout << mLib.createUpperString("Hello Big World!") << "\n";
  return 0;
}
}  // namespace app