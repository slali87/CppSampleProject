/** @file
 * @brief Unit tests for Lib.
 *
 * It contains unit tests to test the Lib.
 */

#include "Lib.h"
#include "gtest/gtest.h"

/** @test
 * @brief Test returning with expected string.
 *
 * It tests if Lib::helloWorld function returns with the expected (helloWorld)
 * c-string.
 */
// Silence because these warnings based on using google test
// clang-format off
// NOLINTNEXTLINE(cert-err58-cpp, cppcoreguidelines-owning-memory, fuchsia-default-arguments-calls, fuchsia-statically-constructed-objects, cppcoreguidelines-avoid-non-const-global-variables, clang-diagnostic-comment) // clang-format on
TEST(LibTestSuite, testHelloWorld_ReturnExpectedString) {
  Lib lib;
  const char* returnValue{lib.helloWorld()};

  EXPECT_STREQ(returnValue, "Hello LibWorld!");
}
