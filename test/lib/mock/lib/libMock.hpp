/** @file
 * @brief Mocks of ILib.
 *
 * It contains mocks of ILib.
 */

#ifndef LIBMOCK_H
#define LIBMOCK_H

#include "gmock/gmock.h"
#include "lib/iLib.hpp"

namespace lib {
/**
 * @brief A mock of ILib.
 *
 * This class is a mock of ILib.
 */
class LibMock : public ILib {
 public:
  MOCK_METHOD(std::string, createUpperString, (std::string),
              (const, noexcept, override));
};
}  // namespace lib

#endif  // LIBMOCK_H