#ifndef LIB_H
#define LIB_H

/** @file
 * @brief Lib related elements.
 *
 * It contains the Lib related elements.
 */

class IHelloWorld;

/**
 * @brief A template for libraries.
 *
 * This class is a template to create libraries.
 */
class Lib {
 public:
  /**
   * @brief It returns with an IHelloWorld based string.
   *
   * This function returns with the hello world c-string based on a IHelloWorld
   * implementation.
   *
   * @param helloWorld is a reference to the Hello World interface
   * @return the IHelloWorld based c-string.
   */
  [[nodiscard]] const char* getString(const IHelloWorld& helloWorld) const;
};

#endif  // LIB_H
