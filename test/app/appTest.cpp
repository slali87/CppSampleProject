/** @file
 * @brief Unit tests for App.
 *
 * It contains unit tests to test the App.
 */

#include "app.hpp"
#include "gmock/gmock.h"
#include "gtest/gtest.h"
#include "lib/lib.hpp"
#include "lib/libMock.hpp"

/** @test
 * @brief Test returning with 0.
 *
 * It tests if App::main function returns with 0 (success).
 */
TEST(AppTestSuite, testMain_Return0) {
  // GIVEN
  lib::Lib lib;

  // WHEN
  auto returnValue{app::App{lib}.main()};

  // THEN
  EXPECT_EQ(returnValue, 0);
}

/** @test
 * @brief Test calling the expected function.
 *
 * It tests if App::main function calls the expected function
 * (LibMock::createUpperString).
 */
TEST(AppTestSuite, testMain_CallCreateUpperString) {
  // GIVEN
  lib::LibMock lib;
  EXPECT_CALL(lib, createUpperString("Hello Big World!")).Times(1);

  // WHEN
  auto returnValue{app::App{lib}.main()};

  // THEN
  EXPECT_EQ(returnValue, 0);
}