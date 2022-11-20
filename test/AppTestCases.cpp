#include "App.h"
#include "gtest/gtest.h"

TEST(AppTestSuite, testMain_Return0)
{
    App app;
    auto returnValue { app.main() };

    EXPECT_EQ(returnValue, 0);
}
