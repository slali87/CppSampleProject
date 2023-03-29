#include "Lib.h"
#include "gtest/gtest.h"

// Silence because these warnings based on using google test
// clang-format off
// NOLINTNEXTLINE(cert-err58-cpp, cppcoreguidelines-owning-memory, fuchsia-default-arguments-calls, fuchsia-statically-constructed-objects, cppcoreguidelines-avoid-non-const-global-variables, clang-diagnostic-comment) // clang-format on
TEST(LibTestSuite, testHelloWorld_ReturnExpectedString) {
  Lib lib;
  const char* returnValue{lib.helloWorld()};

  EXPECT_STREQ(returnValue, "Hello LibWorld!");
}
