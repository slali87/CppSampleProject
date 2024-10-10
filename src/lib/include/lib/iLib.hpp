#ifndef LIB_ILIB_HPP
#define LIB_ILIB_HPP

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
  constexpr ILib() = default;
  constexpr ILib(const ILib&) = delete;
  constexpr ILib(ILib&&) = delete;
  ILib& operator=(const ILib&) = delete;
  ILib& operator=(ILib&&) = delete;
  virtual ~ILib() = default;

  /**
   * @brief It creates an uppercase string from the input.
   *
   * This function creates an uppercase string from the input.
   *
   * @param string is an input string.
   * @return the uppercase string.
   */
  [[nodiscard]] virtual std::string createUpperString(
      std::string string) const = 0;
};
}  // namespace lib

#endif  // LIB_ILIB_HPP
