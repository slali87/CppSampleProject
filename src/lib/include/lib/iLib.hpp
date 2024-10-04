#ifndef ILIB_H
#define ILIB_H

/** @file
 * @brief ILib interface related elements.
 *
 * It contains the ILib interface related elements.
 */

#include <string>

namespace lib {
/**
 * @brief An template interface for libraries.
 *
 * This interface is a template to create libraries.
 */
class ILib {
 public:
  /**
   * @brief It creates an uppercase string from the input.
   *
   * This function creates an uppercase string from the input.
   *
   * @param string is an input string.
   * @return the uppercase string.
   */
  [[nodiscard]] virtual std::string createUpperString(
      std::string string) const noexcept = 0;
};
}  // namespace lib

#endif  // ILIB_H
