#include "App.h"
#include "Lib.h"

#include <iostream>

using std::cout;

// Silence because meber function is used by desing since it is a demo code
// NOLINTNEXTLINE(readability-convert-member-functions-to-static)
int App::main()
{
   cout << "Hello World!\n";
   cout << Lib{}.helloWorld() << "\n";

   return 0;
}
