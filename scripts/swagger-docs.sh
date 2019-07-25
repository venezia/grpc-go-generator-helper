#!/bin/bash

source $(dirname "${BASH_SOURCE}")/variables.sh

if [[ ${SWAGGER_DESTINATION} ]]; then
    echo "Using ${SWAGGER_DESTINATION} as the SWAGGER_DESTINATION"
else
    SWAGGER_DESTINATION=assets/generated/swagger
    echo "Defaulting to ${SWAGGER_DESTINATION} as the SWAGGER_DESTINATION"
fi

echo "Ensuring Swagger Asset Directory ( ${PROJECT_DIRECTORY}/${SWAGGER_DESTINATION} ) Exists..."
mkdir -p ${PROJECT_DIRECTORY}/${SWAGGER_DESTINATION}

echo
echo "generating swagger docs..."
echo "protoc ${FULL_API_FILE_PATH} -I ${PROTOBUF_LIBRARY_LOCATION}/ -I ${INPUT_API_DIRECTORY}/ -I $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis -I $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway --swagger_out=logtostderr=true:${PROJECT_DIRECTORY}/${SWAGGER_DESTINATION}"
protoc ${FULL_API_FILE_PATH} -I ${PROTOBUF_LIBRARY_LOCATION}/ -I ${INPUT_API_DIRECTORY}/ -I $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis -I $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway --swagger_out=logtostderr=true:${PROJECT_DIRECTORY}/${SWAGGER_DESTINATION}
