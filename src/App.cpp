#include "App.h"
#include "Lib.h"

#include <iostream>

using std::cout;

// Silence because meber function is used by desing since it is a demo code, and the exception related one is false positive 
// NOLINTNEXTLINE(readability-convert-member-functions-to-static, bugprone-exception-escape)
int App::main()
{
   cout << "Hello World!\n";
   cout << Lib{}.helloWorld() << "\n";

   return 0;
}
