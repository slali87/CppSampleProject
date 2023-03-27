#include "Lib.h"
#include "gtest/gtest.h"

// Silence because these warnings based on using google test
// NOLINTNEXTLINE(cert-err58-cpp, cppcoreguidelines-owning-memory, fuchsia-default-arguments-calls, fuchsia-statically-constructed-objects)
TEST(LibTestSuite, testHelloWorld_ReturnExpectedString)
{
    Lib lib;
    const char* returnValue {lib.helloWorld()};

    EXPECT_STREQ(returnValue, "Hello LibWorld!");
}
