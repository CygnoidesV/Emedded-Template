
cmake_minimum_required(VERSION 3.25)

set(CMAKE_SYSTEM_NAME Generic)
project(Emedded C CXX ASM)
set(TARGET "${PROJECT_NAME}")
set(BUILD_DIR "${CMAKE_CURRENT_SOURCE_DIR}/build")
set(CMAKE_VERBOSE_MAKEFILE ON)

# Docs CMake
set(EMEDDED_SOURCE_DIR                    "${CMAKE_CURRENT_SOURCE_DIR}")
add_subdirectory("Docs")


# Src
set(EMEDDED_SRC_DIRS
    Core/Src/*.c
    Drivers/STM32F4xx_HAL_Driver/Src/*.c
    Middlewares/Third_Party/FreeRTOS/Source/*.c
    Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS/*.c
    Middlewares/Third_Party/FreeRTOS/Source/portable/MemMang/*.c
    Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F/*.c
)
file(GLOB EMEDDED_SRC_FILES ${EMEDDED_SRC_DIRS})
list(APPEND EMEDDED_SRC_FILES startup_stm32f407xx.s)

include_directories(
    Core/Inc 
    Drivers/STM32F4xx_HAL_Driver/Inc 
    Drivers/STM32F4xx_HAL_Driver/Inc/Legacy 
    Middlewares/Third_Party/FreeRTOS/Source/include 
    Middlewares/Third_Party/FreeRTOS/Source/CMSIS_RTOS 
    Middlewares/Third_Party/FreeRTOS/Source/portable/GCC/ARM_CM4F 
    Drivers/CMSIS/Device/ST/STM32F4xx/Include 
    Drivers/CMSIS/Include
)


add_executable(${TARGET} ${EMEDDED_SRC_FILES})

# Select Compiler
include(CMake/gcc-arm-none-eabi.cmake)
#include(CMake/armclang.cmake)
#include(Cmake/armcc.cmake)
target_link_libraries(${TARGET})

