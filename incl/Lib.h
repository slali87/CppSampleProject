#ifndef LIB_H
#define LIB_H

/** @file
 * @brief Lib related elements.
 *
 * It contains the Lib related elements.
 */

/**
 * @brief A template for libraries.
 *
 * This class is a template to create libraries.
 */
class Lib {
 public:
  /**
   * @brief It returns with the hello world string.
   *
   * This function returns with the hello world c-string.
   *
   * @return the hello world c-string.
   */
  const char* helloWorld();
};

#endif  // LIB_H
