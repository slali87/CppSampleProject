from conan import ConanFile
from conan.tools.cmake import cmake_layout

class ConanTrialRecipe(ConanFile):
    settings = "os", "compiler", "build_type", "arch"
    generators = "CMakeDeps", "CMakeToolchain"
    
    def build_requirements(self):
        self.test_requires("gtest/[>=1.0 <2]")

    def layout(self):
        cmake_layout(self)