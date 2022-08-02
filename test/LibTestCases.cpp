#include "Lib.h"
#include "gtest/gtest.h"

TEST(LibTestSuite, testHelloWorld_ReturnExpectedString)
{
    Lib lib;
    const char* returnValue {lib.helloWorld()};

    EXPECT_STREQ(returnValue, "Hello LibWorld!");
}
