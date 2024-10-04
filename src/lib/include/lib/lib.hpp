#ifndef LIB_H
#define LIB_H

/** @file
 * @brief Lib implementation related elements.
 *
 * It contains the Lib implementation related elements.
 */

#include "iLib.hpp"

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
      std::string string) const noexcept override;
};
}  // namespace lib

#endif  // LIB_H
