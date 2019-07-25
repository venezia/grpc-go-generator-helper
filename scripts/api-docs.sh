#!/bin/bash

source $(dirname "${BASH_SOURCE}")/variables.sh

if [[ ${DOCUMENTATION_DESTINATION} ]]; then
    echo "Using ${DOCUMENTATION_DESTINATION} as the DOCUMENTATION_DESTINATION"
else
    DOCUMENTATION_DESTINATION=docs/api-generated
    echo "Defaulting to ${DOCUMENTATION_DESTINATION} as the DOCUMENTATION_DESTINATION"
fi

echo "Ensuring Documentation Destination Directory ( ${PROJECT_DIRECTORY}/${DOCUMENTATION_DESTINATION} ) Exists..."
mkdir -p ${PROJECT_DIRECTORY}/${DOCUMENTATION_DESTINATION}

echo
echo "generating api docs..."
echo "protoc ${FULL_API_FILE_PATH} -I ${PROTOBUF_LIBRARY_LOCATION}/ -I ${INPUT_API_DIRECTORY}/ -I $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis -I $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway ${FULL_API_FILE_PATH} --doc_out ${PROJECT_DIRECTORY}/${DOCUMENTATION_DESTINATION} --doc_opt=markdown,api.md"
protoc ${FULL_API_FILE_PATH} -I ${PROTOBUF_LIBRARY_LOCATION}/ -I ${INPUT_API_DIRECTORY}/ -I $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis -I $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway ${FULL_API_FILE_PATH} --doc_out ${PROJECT_DIRECTORY}/${DOCUMENTATION_DESTINATION} --doc_opt=markdown,api.md
