#include "Lib.h"

#include "IHelloWorld.h"

const char*
// Silence because meber function is used by desing since it is a demo code
// NOLINTNEXTLINE(readability-convert-member-functions-to-static)
Lib::getString(const IHelloWorld& helloWorld) const {
  return helloWorld.hello();
}
