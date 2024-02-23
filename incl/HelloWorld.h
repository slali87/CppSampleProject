#ifndef HELLOWORLD_H
#define HELLOWORLD_H

/** @file
 * @brief HelloWorld related elements.
 *
 * It contains the HelloWorld related elements.
 */

#include "IHelloWorld.h"

/**
 * @brief The HelloWorld implementation.
 *
 * This class is an implementation of the IHelloWorld interface.
 */
class HelloWorld : public IHelloWorld {
 public:
  /**
   * @brief See IHelloWorld::hello
   */
  [[nodiscard]] const char* hello() const override;
};

#endif  // HELLOWORLD_H