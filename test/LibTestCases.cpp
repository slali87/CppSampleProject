/** @file
 * @brief Unit tests for Lib.
 *
 * It contains unit tests to test the Lib.
 */

#include "HelloWorld.h"
#include "Lib.h"
#include "MockHelloWorld.h"
#include "gmock/gmock.h"
#include "gtest/gtest.h"

/** @test
 * @brief Test returning with expected string.
 *
 * It tests if Lib::getString function returns with the expected (Hello
 * LibWorld!) c-string.
 */
// Silence because these warnings based on using google test
// clang-format off
// NOLINTNEXTLINE(cert-err58-cpp, cppcoreguidelines-owning-memory, fuchsia-default-arguments-calls, fuchsia-statically-constructed-objects, cppcoreguidelines-avoid-non-const-global-variables, clang-diagnostic-comment) // clang-format on
TEST(LibTestSuite, testGetString_ReturnExpectedString) {
  Lib lib;
  const char* returnValue{lib.getString(HelloWorld{})};

  EXPECT_STREQ(returnValue, "Hello LibWorld!");
}

/** @test
 * @brief Test calling the expected function.
 *
 * It tests if Lib::getString function calls the expected function (MockHelloWorld::hello).
 */
// Silence because these warnings based on using google test
// clang-format off
// NOLINTNEXTLINE(cert-err58-cpp, cppcoreguidelines-owning-memory, fuchsia-default-arguments-calls, fuchsia-statically-constructed-objects, cppcoreguidelines-avoid-non-const-global-variables, clang-diagnostic-comment) // clang-format on
TEST(LibTestSuite, testGetString_CallHello) {
  Lib lib;
  MockHelloWorld helloWorld;
  EXPECT_CALL(helloWorld, hello())
    .Times(1);
    
  lib.getString(helloWorld);
}