

## protobuf sample application
set(APP_NAME ptr_vector_sample)

add_executable(${APP_NAME}
    ptr_vector.cpp
    main.cpp
)

#target_link_libraries(${APP_NAME} 
#    ${PROTOBUF_LIB_NAME}
#)

set_target_properties(${APP_NAME} PROPERTIES
    CXX_STANDARD 17
    CXX_STANDARD_REQUIRED ON
    #   CXX_EXTENSIONS OFF
    )
