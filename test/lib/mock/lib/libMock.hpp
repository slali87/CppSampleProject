/** @file
 * @brief Mocks of ILib.
 *
 * It contains mocks of ILib.
 */

// Silence since the suggested name is wrong
// NOLINTNEXTLINE(llvm-header-guard)
#ifndef LIB_LIBMOCK_HPP
#define LIB_LIBMOCK_HPP

#include "gmock/gmock.h"
#include "lib/iLib.hpp"

#include <string>

namespace lib {
/**
 * @brief A mock of ILib.
 *
 * This class is a mock of ILib.
 */
class LibMock : public ILib {
 public:
  MOCK_METHOD(std::string, createUpperString, (std::string), (const, override));
};
}  // namespace lib

#endif  // LIB_LIBMOCK_HPP