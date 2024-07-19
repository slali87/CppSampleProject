/** @file
 * @brief Mocks of IHelloWorld.
 *
 * It contains mocks of IHelloWorld.
 */

#include "IHelloWorld.h"
#include "gmock/gmock.h"

/**
 * @brief A mock of IHelloWorld.
 *
 * This class is a mock of IHelloWorld.
 */
class MockHelloWorld : public IHelloWorld {
 public:
  // clang-format off
  // NOLINTNEXTLINE(misc-non-private-member-variables-in-classes, modernize-type-traits) // clang-format on
  MOCK_METHOD(const char*, hello, (), (const, override));
};