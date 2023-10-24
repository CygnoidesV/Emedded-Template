


#设置编译器
set(CMAKE_C_COMPILER armclang.exe)
set(CMAKE_CXX_COMPILER armclang.exe)
set(CMAKE_ASM_COMPILER armclang.exe)
set(CMAKE_C_COMPILER_WORKS TRUE)
set(CMAKE_CXX_COMPILER_WORKS TRUE)
set(CMAKE_ASM_COMPILER_WORKS TRUE)
set(CMAKE_EXECUTABLE_SUFFIX_ASM ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_C ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_CXX ".elf")

add_compile_definitions(
    USE_HAL_DRIVER 
    STM32F407xx
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

set(COMPILE_RULE_FLAG "--target=arm-arm-none-eabi -mcpu=cortex-m4")
set(CMAKE_C_FLAGS "${COMPILE_RULE_FLAG} -fno-rtti -c -ffunction-sections ${DBG_FLAGS} -w")
set(CMAKE_ASM_FLAGS "${COMPILE_RULE_FLAG} -masm=auto -c -gdwarf-4")
set(CMAKE_C_LINK_FLAGS "\
        --cpu=Cortex-M4.fp.sp  \
        --strict \
        --scatter ${CMAKE_CURRENT_SOURCE_DIR}/CMake/test.sct \
        --summary_stderr \
        --info summarysizes \
        --list \"test2.map\" \
        --map --load_addr_map_info --xref --callgraph --symbols \
        --info sizes --info totals --info unused --info veneers" ) 

target_compile_options(${TARGET} PRIVATE

)

set(CMAKE_C_LINK_EXECUTABLE "armlink.exe <CMAKE_C_LINK_FLAGS> <LINK_FLAGS> <OBJECTS> -o <TARGET> <LINK_LIBRARIES>")


