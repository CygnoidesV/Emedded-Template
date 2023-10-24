

# specify the cross compiler
set(CROSS_COMPILE_PREFIX arm-none-eabi)
set(CMAKE_C_COMPILER ${CROSS_COMPILE_PREFIX}-gcc)
set(CMAKE_CXX_COMPILER ${CROSS_COMPILE_PREFIX}-g++)
set(CMAKE_ASM_COMPILER ${CROSS_COMPILE_PREFIX}-gcc)
set(CMAKE_OBJCOPY ${CROSS_COMPILE_PREFIX}-objcopy)
set(CMAKE_OBJDUMP ${CROSS_COMPILE_PREFIX}-objdump)

# Without this flag, CMake is unable to pass the test compilation check
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)

# search for program/library/include in the build host directories
set(CMAKE_EXECUTABLE_SUFFIX_ASM ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_C ".elf")
set(CMAKE_EXECUTABLE_SUFFIX_CXX ".elf")


# Target-specific flags
set(CPU "-mcpu=cortex-m4")
set(FPU "-mfpu=fpv4-sp-d16")
set(FLOAT_ABI "-mfloat-abi=hard")
set(MCU_FLAGS "${CPU} -mthumb ${FPU} ${FLOAT_ABI}")
set(OPT "-Og")
add_compile_definitions(
    USE_HAL_DRIVER 
    STM32F407xx
)


# Generate flags from user variables
if(CMAKE_BUILD_TYPE MATCHES Debug)
set(DBG_FLAGS "-g3 -gdwarf-2 -O0 -MMD -MP -MF")
elseif(CMAKE_BUILD_TYPE MATCHES Release)
set(DBG_FLAGS "-O3 -MMD -MP -MF")
endif()

set(CMAKE_C_STANDARD 99)
set(LIBS "-lc -lm -lnosys")
set(LIBS_DIR "")
set(LINKER_SCRIPT "${CMAKE_CURRENT_SOURCE_DIR}/CMake/STM32F407IGHx_FLASH.ld")
set(CMAKE_C_FLAGS "${MCU_FLAGS} ${OPT} -Wall -fdata-sections -ffunction-sections")
set(CMAKE_ASM_FLAGS "${MCU_FLAGS} ${OPT} -Wall -fdata-sections -ffunction-sections")
set(CMAKE_EXE_LINKER_FLAGS "${MCU_FLAGS} -specs=nano.specs -T${LINKER_SCRIPT} -Wl,-Map=${BUILD_DIR}/${TARGET}.map,--cref -Wl,--gc-sections")
set(CMAKE_SHARED_LIBRARY_LINK_C_FLAGS "${LIBS} ${LIBS_DIR}")

# elf to hex and bin
add_custom_command(TARGET ${TARGET} POST_BUILD
    COMMAND ${CMAKE_SIZE} $<TARGET_FILE:${TARGET}>
    COMMAND ${CMAKE_OBJCOPY} -O ihex $<TARGET_FILE:${TARGET}> ${TARGET}.hex
    COMMAND ${CMAKE_OBJCOPY} -O binary $<TARGET_FILE:${TARGET}> ${TARGET}.bin
)