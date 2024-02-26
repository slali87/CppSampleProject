#ifndef IHELLOWORLD_H
#define IHELLOWORLD_H

/** @file
 * @brief IHelloWorld interface related elements.
 *
 * It contains the Hello World interface related elements.
 */

/**
 * @brief The IHelloWorld interface.
 *
 * This class is the interface of Hello World.
 */
class IHelloWorld {
 public:
  IHelloWorld() = default;
  virtual ~IHelloWorld() = default;
  constexpr IHelloWorld(const IHelloWorld&) = default;
  constexpr IHelloWorld(IHelloWorld&&) = default;
  IHelloWorld& operator=(const IHelloWorld&) = default;
  IHelloWorld& operator=(IHelloWorld&&) = default;

  /**
   * @brief It returns with the hello world string.
   *
   * This function returns with the hello world c-string.
   *
   * @return the hello world c-string.
   */
  [[nodiscard]] virtual const char* hello() const = 0;
};

#endif  // IHELLOWORLD_H