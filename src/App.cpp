#include "App.h"

#include "HelloWorld.h"
#include "Lib.h"

#include <iostream>

using std::cout;

// Silence because meber function is used by desing since it is a demo code, and
// the exception related one is false positive
// clang-format off
// NOLINTNEXTLINE(readability-convert-member-functions-to-static, bugprone-exception-escape) // clang-format on
int App::main() {
  cout << "Hello World!\n";

  cout << Lib{}.getString(HelloWorld{}) << "\n";

  return 0;
}
