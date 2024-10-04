/** @file
 * @brief It contains the global main function.
 */

#include "app.hpp"
#include "lib/lib.hpp"

/**
 * @brief The global main function.
 *
 * This function is the global main.
 * Currently, it just calls app::App::main function with the injected lib::Lib.
 *
 * @return the error code, 0 means everything went well.
 */
int main() { return app::App{lib::Lib{}}.main(); }