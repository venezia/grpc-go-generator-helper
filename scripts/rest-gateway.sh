#!/bin/bash

source $(dirname "${BASH_SOURCE}")/variables.sh

if [[ ${DESTINATION_LIBRARY} ]]; then
    echo "Using ${DESTINATION_LIBRARY} as the DESTINATION_LIBRARY"
else
    DESTINATION_LIBRARY=pkg/generated/api
    echo "Defaulting to ${DESTINATION_LIBRARY} as the DESTINATION_LIBRARY"
fi

echo "Ensuring Destination Directory ( ${PROJECT_DIRECTORY}/${DESTINATION_LIBRARY} ) Exists..."
mkdir -p ${PROJECT_DIRECTORY}/${DESTINATION_LIBRARY}

echo
echo "generating REST gateway stubs..."
echo "protoc ${FULL_API_FILE_PATH} -I ${PROTOBUF_LIBRARY_LOCATION}/ -I ${INPUT_API_DIRECTORY}/ -I $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis -I $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway --grpc-gateway_out=logtostderr=true:${PROJECT_DIRECTORY}/${DESTINATION_LIBRARY}"
protoc ${FULL_API_FILE_PATH} -I ${PROTOBUF_LIBRARY_LOCATION}/ -I ${INPUT_API_DIRECTORY}/ -I $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis -I $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway --grpc-gateway_out=logtostderr=true:${PROJECT_DIRECTORY}/${DESTINATION_LIBRARY}
