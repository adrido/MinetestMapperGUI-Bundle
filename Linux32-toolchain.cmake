# the name of the target operating system
set(CMAKE_SYSTEM_NAME Linux)
set(CPACK_SYSTEM_NAME Linux32)

message(STATUS "BUILDING x86-Linux")

# Which compilers to use for C and C++
set(CMAKE_C_COMPILER gcc -m32)
set(CMAKE_CXX_COMPILER g++ -m32)
