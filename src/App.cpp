#include "App.h"
#include "Lib.h"

#include <iostream>

using std::cout;

int App::main()
{
   cout << "Hello World!\n";
   cout << Lib{}.helloWorld() << "\n";

   return 0;
}
