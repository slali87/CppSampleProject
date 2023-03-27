#include "App.h"
#include "gtest/gtest.h"

// Silence because these warnings based on using google test
// NOLINTNEXTLINE(cert-err58-cpp, cppcoreguidelines-owning-memory, fuchsia-default-arguments-calls, fuchsia-statically-constructed-objects, cppcoreguidelines-avoid-non-const-global-variables)
TEST(AppTestSuite, testMain_Return0)
{
    App app;
    auto returnValue { app.main() };

    EXPECT_EQ(returnValue, 0);
}
