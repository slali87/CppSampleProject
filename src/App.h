#ifndef APP_H
#define APP_H

/** @file
 * @brief App related elements.
 *
 * It contains the App related elements.
 */

/**
 * @brief A template for executables.
 *
 * This class is a template to create executables.
 */
class App {
 public:
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
};

#endif  // APP_H
