/** @file
 * @brief It contains the unit tests's global main function.
 */

#include "gtest/gtest.h"

/**
 * @brief The unit tests's global main function.
 *
 * This function is the unit tests's global main function.
 *
 * @return the error code, 0 means everything went well.
 */
int main(int argc, char **argv) {
  ::testing::InitGoogleTest(&argc, argv);
  return RUN_ALL_TESTS();
}
