# the name of the target operating system
set(CMAKE_SYSTEM_NAME Linux)
set(CPACK_SYSTEM_NAME Linux32)

# which compilers to use for C and C++
#set(CMAKE_C_COMPILER gcc)
set(CMAKE_C_FLAGS -m32)
#set(CMAKE_CXX_COMPILER g++)
set(CMAKE_CXX_FLAGS -m32)
