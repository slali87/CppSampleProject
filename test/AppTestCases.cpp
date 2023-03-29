/** @file
 * @brief Unit tests for App.
 *
 * It contains unit tests to test the App.
 */

#include "App.h"
#include "gtest/gtest.h"

/** @test
 * @brief Test returning with 0.
 *
 * It tests if App::main function returns with 0 (success).
 */
// Silence because these warnings based on using google test
// clang-format off
// NOLINTNEXTLINE(cert-err58-cpp, cppcoreguidelines-owning-memory, fuchsia-default-arguments-calls, fuchsia-statically-constructed-objects, cppcoreguidelines-avoid-non-const-global-variables, clang-diagnostic-comment) // clang-format on
TEST(AppTestSuite, testMain_Return0) {
  App app;
  auto returnValue{app.main()};

  EXPECT_EQ(returnValue, 0);
}
