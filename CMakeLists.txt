cmake_minimum_required(VERSION 3.10)
project(nzmqt)

add_definitions(-fPIC)

include(custom.cmake)
include(protobuf.cmake)
include(qt_compliancy.cmake)

include_directories(${CMAKE_CURRENT_SOURCE_DIR}/3rdparty/cppzmq)

set(NZMQT_INC_DIR ${CMAKE_CURRENT_SOURCE_DIR}/include)
include_directories(${NZMQT_INC_DIR})

add_subdirectory(src)
# add_subdirectory(app)

PROTOBUF_GEN_MSG(
    DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}/proto
#     FILES sample/header.proto sample/request/search.proto
)
