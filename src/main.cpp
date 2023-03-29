/** @file
 * @brief It contains the global main function.
 */

#include "App.h"

/**
 * @brief The global main function.
 *
 * This function is the global main.
 * Currently, it just calls App::main function.
 *
 * @return the error code, 0 means everything went well.
 */
int main() { return App{}.main(); }
