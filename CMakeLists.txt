# Barebones CMakeLists.txt file for my C++ projects. To use, do a find and replace all for {CHANGE_ME} with your
# project's name. As well as a find and replace all for {CHANGE_ME_UPPER} with the all caps version of your projects
# name.
#
# From there, you should be able to run "./scripts/build.nu build debug" to generate the CMake files and build. Then
# you can run "./script/build.nu run debug" to run the resulting executable.

cmake_minimum_required(VERSION 3.20)
project({CHANGE_ME})

# Set the C++ standard of the project to C++23 and require it
set(CMAKE_CXX_STANDARD 23)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# Root directory that binaries will be output to
set({CHANGE_ME_UPPER}_BINARY_ROOT_DIR ${CMAKE_SOURCE_DIR}/bin)

# Root directory that dependencies will be added to
set({CHANGE_ME_UPPER}_DEPENDENCY_ROOT_DIR ${CMAKE_SOURCE_DIR}/extern)

# Root directory of all source code in the project
set({CHANGE_ME_UPPER}_SOURCE_ROOT_DIR ${CMAKE_SOURCE_DIR}/src)

# Update all output directories for the debug configuration to our binary directory
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_DEBUG ${{CHANGE_ME_UPPER}_BINARY_ROOT_DIR}/debug)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_DEBUG ${{CHANGE_ME_UPPER}_BINARY_ROOT_DIR}/debug)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_DEBUG ${{CHANGE_ME_UPPER}_BINARY_ROOT_DIR}/debug)

# Update all output directories for the release configuration to our binary directory
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELEASE ${{CHANGE_ME_UPPER}_BINARY_ROOT_DIR}/release)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELEASE ${{CHANGE_ME_UPPER}_BINARY_ROOT_DIR}/release)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELEASE ${{CHANGE_ME_UPPER}_BINARY_ROOT_DIR}/release)

# Update all output directories for the relwithdebinfo configuration to our binary directory
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_RELWITHDEBINFO ${{CHANGE_ME_UPPER}_BINARY_ROOT_DIR}/relwithdebinfo)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_RELWITHDEBINFO ${{CHANGE_ME_UPPER}_BINARY_ROOT_DIR}/relwithdebinfo)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_RELWITHDEBINFO ${{CHANGE_ME_UPPER}_BINARY_ROOT_DIR}/relwithdebinfo)

# Update all output directories for the minsizerel configuration to our binary directory
set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY_MINSIZEREL ${{CHANGE_ME_UPPER}_BINARY_ROOT_DIR}/minsizerel)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY_MINSIZEREL ${{CHANGE_ME_UPPER}_BINARY_ROOT_DIR}/minsizerel)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY_MINSIZEREL ${{CHANGE_ME_UPPER}_BINARY_ROOT_DIR}/minsizerel)

# Any dependencies should be added here.

# Add our executable target with a single source file, our stub main.cpp
add_executable(${PROJECT_NAME}
	${{CHANGE_ME_UPPER}_SOURCE_ROOT_DIR}/main.cpp)

# Add the source directory as an include directory. I prefer doing this so that all includes can be relative to the root.
# Example: if I have a directory called "components" and I have a source file there, I prefer including with
# "components/xxx.h" vs "xxx.h".
target_include_directories(${PROJECT_NAME} PRIVATE
	${{CHANGE_ME_UPPER}_SOURCE_ROOT_DIR})

