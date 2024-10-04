#include "app.hpp"

#include <iostream>

using std::cout;

namespace app {
int App::main() {
  cout << "Hello World!\n";
  cout << mLib.createUpperString("Hello Big World!") << "\n";
  return 0;
}
}  // namespace app