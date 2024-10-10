#ifndef LIB_LIB_HPP
#define LIB_LIB_HPP

/** @file
 * @brief Lib implementation related elements.
 *
 * It contains the Lib implementation related elements.
 */

#include "iLib.hpp"

#include <string>

namespace lib {
/**
 * @brief The Lib implementation.
 *
 * This class is an implementation of the ILib interface.
 */
class Lib : public ILib {
 public:
  /**
   * @brief See ILib::createUpperString
   */
  [[nodiscard]] std::string createUpperString(
      std::string string) const override;
};
}  // namespace lib

#endif  // LIB_LIB_HPP
