/** @file
 * @brief Unit tests for Lib.
 *
 * It contains unit tests to test the Lib.
 */

#include "gtest/gtest.h"
#include "lib/lib.hpp"

#include <string>

/** @test
 * @brief Test returning with expected string.
 *
 * It tests if Lib::createUpperString function returns with the expected (HELLO
 *  LIBWORLD!) string.
 */
TEST(LibTestSuite, testCreateUpperString_ReturnExpectedString) {
  // GIVEN
  const lib::Lib lib;
  // Silence since the default parameter was declared in std::basic_string
  // NOLINTNEXTLINE(fuchsia-default-arguments-calls)
  const std::string inputString{"Hello LibWorld!"};

  // WHEN
  const std::string outputString{lib.createUpperString(inputString)};

  // THEN
  EXPECT_STREQ(outputString.c_str(), "HELLO LIBWORLD!");
}