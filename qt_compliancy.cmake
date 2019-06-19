
# if("$ENV{ROS_DISTRO}" STREQUAL "indigo") 

#     find_package(Qt4 REQUIRED QtCore QtNetwork)
#     include(${QT_USE_FILE})
#     add_definitions( ${QT_DEFINITIONS} )
#     
#     macro(CUSTOM_QT_WRAP_CPP )
#         QT4_WRAP_CPP(${ARGN})
#     endmacro()
#     
#     set(CUSTOM_QT_LIBRARIES ${QT_LIBRARIES})
    
# elseif("$ENV{ROS_DISTRO}" STREQUAL "kinetic") 

    find_package(Qt5 REQUIRED Core)
    
    include_directories(${Qt5Core_INCLUDE_DIRS})
    add_definitions(${Qt5Core_DEFINITIONS})
    
#     include_directories(${Qt5Network_INCLUDE_DIRS})
#     add_definitions(${Qt5Network_DEFINITIONS})
    
    macro(CUSTOM_QT_WRAP_CPP )
        QT5_WRAP_CPP(${ARGN})
    endmacro()
    
    set(CUSTOM_QT_LIBRARIES ${Qt5Core_LIBRARIES} ${Qt5Network_LIBRARIES})

# else()
#     message(FATAL_ERROR "ROS version not set!!")
# endif()

