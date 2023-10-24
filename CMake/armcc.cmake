
#设置编译器
set(CMAKE_C_COMPILER armcc.exe)
set(CMAKE_CXX_COMPILER armcc.exe)
set(CMAKE_ASM_COMPILER armcc.exe)
set(CMAKE_C_COMPILER_WORKS TRUE)
set(CMAKE_CXX_COMPILER_WORKS TRUE)
set(CMAKE_ASM_COMPILER_WORKS TRUE)

#设置链接器
#set(CMAKE_C_LINK_EXECUTABLE armlink.exe)
#set(CMAKE_CXX_LINK_EXECUTABLE armlink.exe)
#set(CMAKE_ASM_LINK_EXECUTABLE armlink.exe)

set(CMAKE_EXECUTABLE_SUFFIX_ASM ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_C ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_CXX ".elf")


add_definitions(
    -DUSE_HAL_DRIVER 
    -DSTM32F407xx
)

# generate flags from user variables
if(CMAKE_BUILD_TYPE MATCHES Debug)
set(DBG_FLAGS "-O0")
elseif(CMAKE_BUILD_TYPE MATCHES Release)
set(DBG_FLAGS "-O3")
elseif(CMAKE_BUILD_TYPE MATCHES MinSizeRel)
set(DBG_FLAGS "-Oz")
elseif(CMAKE_BUILD_TYPE MATCHES RelWithDebInfo)
set(DBG_FLAGS "-Ofast")
endif()

set(CMAKE_C_FLAGS "--c99 -c --cpu Cortex-M4.fp.sp -g ${DBG_FLAGS} --apcs=interwork --split_sections")
set(CMAKE_ASM_FLAGS "--cpu Cortex-M4.fp.sp -g --apcs=interwork")
