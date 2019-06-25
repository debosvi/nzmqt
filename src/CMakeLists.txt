
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/common)
include_directories(${CMAKE_BINARY_DIR}/proto)

# for application
include_directories(${CMAKE_CURRENT_SOURCE_DIR})

set(NZMQT_LIB_NAME nzmqt)
set(NZMQT_APP_NAME nzmqt-app)
set(PBUF_APP_NAME pbuf-sample)

## library
CUSTOM_QT_WRAP_CPP(${NZMQT_LIB_NAME}_MOC_SRC_H
    ${NZMQT_INC_DIR}/nzmqt/nzmqt.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/common/SampleBase.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/pubsub/Publisher.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/pubsub/Subscriber.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/reqrep/Replier.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/reqrep/Requester.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/pushpull/Ventilator.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/pushpull/Sink.hpp
    ${CMAKE_CURRENT_SOURCE_DIR}/pushpull/Worker.hpp
)

add_library(${NZMQT_LIB_NAME} SHARED
    nzmqt/nzmqt.cpp
    
    # MOCs
    ${${NZMQT_LIB_NAME}_MOC_SRC_H}
)

target_link_libraries(${NZMQT_LIB_NAME} 
    ${CUSTOM_QT_LIBRARIES}
    ${ZeroMQ_LIBRARY}
)

## nzmqt application
CUSTOM_QT_WRAP_CPP(${NZMQT_APP_NAME}_MOC_SRC_H
    ${CMAKE_CURRENT_SOURCE_DIR}/app/NzmqtApp.hpp
)

add_executable(${NZMQT_APP_NAME}
    app/main.cpp
    
    # MOCs
    ${${NZMQT_APP_NAME}_MOC_SRC_H}
)

target_link_libraries(${NZMQT_APP_NAME} 
    ${NZMQT_LIB_NAME}
)

## protobuf sample application
CUSTOM_QT_WRAP_CPP(${PBUF_APP_NAME}_MOC_SRC_H
    ${CMAKE_CURRENT_SOURCE_DIR}/app/NzmqtApp.hpp
)

add_executable(${PBUF_APP_NAME}
    app/protobuf_sample.cpp
)

target_link_libraries(${PBUF_APP_NAME} 
    ${PROTOBUF_LIB_NAME}
)

# add_subdirectory(app)
