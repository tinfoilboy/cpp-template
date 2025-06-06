# Maxwell's C++ Template

A barebones template for a C++23 project built with CMake. Intended mostly for my own use when creating new projects. In particular, there is:

1. A simple CMakeLists file with a single executable target
2. A Nushell script for managing building, running, and cleaning the project
3. An ignore file used for my Neovim config
4. A clang-format file for auto formatting code

Note that the CMakeLists file and build script contain a placeholder name for the project name. This should be changed with your own intended project name.

## Structure

This template follows this general structure:

    {root}/
        bin/ - All binaries should be here
            debug/ - Per build type directories for binaries
            ...
        src/ - All source files should be here
        extern/ - All external dependencies should be here
        script/ - Any scripts relating to management of the project, such as build, should be here
        build/ - All CMake build files should be here

Most projects I develop are not external libraries these days. But if intended for external use, a separate 'include' directory should be created.

