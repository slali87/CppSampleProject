#ifndef APP_HPP
#define APP_HPP

/** @file
 * @brief App related elements.
 *
 * It contains the App related elements.
 */

#include "lib/iLib.hpp"

namespace app {
/**
 * @brief A template for executables.
 *
 * This class is a template to create executables.
 */
class App {
 public:
  constexpr explicit App(const lib::ILib& lib) : mLib(lib) {}
  constexpr App(const App&) = delete;
  constexpr App(App&&) = delete;
  App& operator=(const App&) = delete;
  App& operator=(App&&) = delete;
  constexpr ~App() = default;

  /**
   * @brief The entry point of App.
   *
   * This function is the entry point of the App.
   * Currently, it just prints out the hello world 2 times: directly and
   * indirectly (calls the Lib).
   *
   * @return the error code: 0 means everything went well.
   */
  int main();

 private:
  const lib::ILib& mLib;
};
}  // namespace app

#endif  // APP_HPP
