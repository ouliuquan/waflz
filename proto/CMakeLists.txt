# ------------------------------------------------------------------------------
# TODO boilerplate
# ------------------------------------------------------------------------------
project (waflz)
cmake_minimum_required(VERSION 3.5)


set(waflz_proto_files acl.proto action.proto rule.proto profile.proto event.proto request_info.proto scope.proto limit.proto)

protobuf_generate_cpp(WAFLZ_PROTO_SRCS WAFLZ_PROTO_HDRS ${waflz_proto_files})
protobuf_generate_python(WAFLZ_PROTO_PY ${waflz_proto_files})


# custom target for protobuf output
add_custom_target(protodata_py_out ALL DEPENDS
    ${WAFLZ_PROTO_PY}
)
# ------------------------------------------------------------------------------
# custom target for protobuf output
# ------------------------------------------------------------------------------
add_custom_target(protobuf_cpp_out ALL DEPENDS
    ${WAFLZ_PROTO_SRCS} ${WAFLZ_PROTO_HDRS}
)

set(WAFLZ_PROTO_HDRS ${WAFLZ_PROTO_HDRS} PARENT_SCOPE)
set(WAFLZ_PROTO_SRCS ${WAFLZ_PROTO_SRCS} PARENT_SCOPE)
