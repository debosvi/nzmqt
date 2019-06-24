
find_program (PROTOC_BIN
    NAMES protoc
    DOC "Protobuf compiler binary string"
    )
         
message(STATUS "Protobuf compiler: ${PROTOC_BIN}")

function(PROTOBUF_GEN_MSG) 
    set(options OPTIONAL)
    set(oneValueArgs DIRECTORY)
    set(multiValueArgs FILES)
    cmake_parse_arguments(PROTOBUF_GEN_MSG "${options}" "${oneValueArgs}"
                          "${multiValueArgs}" ${ARGN} )
                          
    if("${PROTOBUF_GEN_MSG_FILES}" STREQUAL "")
        file(GLOB_RECURSE ALL_FILES 
            RELATIVE ${PROTOBUF_GEN_MSG_DIRECTORY}
            ${PROTOBUF_GEN_MSG_DIRECTORY}/*.proto)
        set(PROTOBUF_GEN_MSG_FILES ${ALL_FILES})
    endif()

    message(STATUS "protobuf DIRECTORY: ${PROTOBUF_GEN_MSG_DIRECTORY}")
    message(STATUS "protobuf FILES: ${PROTOBUF_GEN_MSG_FILES}")
    
    set(GEN_CPP_ROOTDIR ${CMAKE_BINARY_DIR}/gen_cpp/nzmqt)
    file(MAKE_DIRECTORY ${GEN_CPP_ROOTDIR})
        
    foreach(IN_PROTO ${PROTOBUF_GEN_MSG_FILES})
        set(in_file ${PROTOBUF_GEN_MSG_DIRECTORY}/${IN_PROTO})
        if(NOT EXISTS ${in_file})
            message(FATAL_ERROR "Protobuf file ${in_file} does not exist!")
        endif()
        
        file(RELATIVE_PATH in_dir ${PROTOBUF_GEN_MSG_DIRECTORY} ${in_file})
#         message(STATUS "in dir: ${in_dir}")
#         message(STATUS "in: ${in_file}")
        
        file(STRINGS ${PROTOBUF_GEN_MSG_DIRECTORY}/${IN_PROTO} content REGEX package)
#         message(STATUS "pkg line: (${content})")
        set(pkg_string ${CMAKE_PROJECT_NAME})
        if(NOT "${content}" STREQUAL "")
            string(REGEX REPLACE "(.*)/(.*)\.proto"  "\\1" pkg_check ${in_dir})
            string(REGEX REPLACE "/"  "\." pkg_check ${pkg_check})
#             message(STATUS "pkg check: ${pkg_check}")
            string(REGEX REPLACE "^package (.*)\\;$"  "\\1" pkg_name ${content})
#             message(STATUS "pkg name: ${pkg_name}")
            if(NOT "${pkg_check}" STREQUAL "${pkg_name}")
                message(FATAL_ERROR "Protobuf file package in ${in_file} mismatch file tree location!")
            endif()
            
            set(pkg_string "${pkg_string}.${pkg_name}")
        endif()
#         message(STATUS "pkg string: ${pkg_string}")
        string(REGEX REPLACE "\\."  "/" pkg_dir ${pkg_string})
#         message(STATUS "pkg dir: ${pkg_dir}")
            
        exec_program(${PROTOC_BIN} ${CMAKE_BINARY_DIR}
             ARGS --cpp_out=${GEN_CPP_ROOTDIR} --proto_path=${PROTOBUF_GEN_MSG_DIRECTORY} ${in_file}
             OUTPUT_VARIABLE no_out
#              [RETURN_VALUE <var>]
)
    
    endforeach()
endfunction()
