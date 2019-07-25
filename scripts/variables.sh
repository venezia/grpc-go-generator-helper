#!/bin/bash

set -o errexit
#set -o nounset
set -o pipefail

THIS_DIRECTORY=$(dirname "${BASH_SOURCE}")

if [[ ${PROJECT_DIRECTORY} ]]; then
    echo "Using ${PROJECT_DIRECTORY} as the PROJECT_DIRECTORY"
else
    PROJECT_DIRECTORY=/input
    echo "Defaulting to ${PROJECT_DIRECTORY} as the PROJECT_DIRECTORY"
fi

if [[ ${PROTOBUF_LIBRARY_LOCATION} ]]; then
    echo "Using ${PROTOBUF_LIBRARY_LOCATION} as the PROTOBUF_LIBRARY_LOCATION"
else
    PROTOBUF_LIBRARY_LOCATION=/usr/include
    echo "Defaulting to ${PROTOBUF_LIBRARY_LOCATION} as the PROTOBUF_LIBRARY_LOCATION"
fi

if [[ ${INPUT_API_DIRECTORY} ]]; then
    echo "Using ${INPUT_API_DIRECTORY} as the INPUT_API_DIRECTORY"
else
    INPUT_API_DIRECTORY=${PROJECT_DIRECTORY}/api
    echo "Defaulting to ${INPUT_API_DIRECTORY} as the INPUT_API_DIRECTORY"
fi

if [[ ${INPUT_API_FILE} ]]; then
    echo "Using ${INPUT_API_FILE} as the INPUT_API_FILE"
else
    INPUT_API_FILE=api.proto
    echo "Defaulting to ${INPUT_API_FILE} as the INPUT_API_FILE"
fi

FULL_API_FILE_PATH=${INPUT_API_DIRECTORY}/${INPUT_API_FILE}
echo "Full API Filepath is ${FULL_API_FILE_PATH}"


#echo "Ensuring Destination Directory ( ${DESTINATION_LIBRARY} ) Exists..."
#mkdir -p ${PROJECT_DIRECTORY}/${DESTINATION_LIBRARY}
#echo "Ensuring Swagger Asset Direcotry ( ${SWAGGER_DESTINATION} ) Exists..."
#mkdir -p ${PROJECT_DIRECTORY}/${SWAGGER_DESTINATION}
#echo "Ensuring Destination Directory ( ${DESTINATION_LIBRARY} ) Exists..."
#mkdir -p ${PROJECT_DIRECTORY}/${DESTINATION_LIBRARY}
#echo "Ensuring Swagger Asset Direcotry ( ${SWAGGER_DESTINATION} ) Exists..."
#mkdir -p ${PROJECT_DIRECTORY}/${SWAGGER_DESTINATION}
#
#echo
#echo "generating api stubs..."
#echo "protoc ${PROJECT_DIRECTORY}/api/api.proto -I ${PROJECT_DIRECTORY}/api/  --go_out=plugins=grpc:${PROJECT_DIRECTORY}/${DESTINATION_LIBRARY}/ -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway -I$GOPATH/src"
#protoc ${PROJECT_DIRECTORY}/api/api.proto -I ${PROJECT_DIRECTORY}/api/  --go_out=plugins=grpc:${PROJECT_DIRECTORY}/${DESTINATION_LIBRARY}/ -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis -I$GOPATH/src/github.com/grpc-ecosystem/grpc-gateway -I$GOPATH/src
#
#echo
#echo "generating REST gateway stubs..."
#echo "protoc ${PROJECT_DIRECTORY}/api/api.proto -I ${PROTOBUF_LIBRARY_LOCATION} -I ${PROJECT_DIRECTORY}/api/ -I $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis -I $GOPATH/src/github.com//grpc-ecosystem/grpc-gateway --grpc-gateway_out=logtostderr=true:${PROJECT_DIRECTORY}/${DESTINATION_LIBRARY}"
#protoc ${PROJECT_DIRECTORY}/api/api.proto -I ${PROTOBUF_LIBRARY_LOCATION} -I ${PROJECT_DIRECTORY}/api/ -I $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis -I $GOPATH/src/github.com//grpc-ecosystem/grpc-gateway --grpc-gateway_out=logtostderr=true:${PROJECT_DIRECTORY}/${DESTINATION_LIBRARY}
#
#echo
#echo "generating swagger docs..."
#echo "protoc ${PROJECT_DIRECTORY}/api/api.proto -I ${PROTOBUF_LIBRARY_LOCATION} -I ${PROJECT_DIRECTORY}/api/ -I $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis -I $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway --swagger_out=logtostderr=true:${PROJECT_DIRECTORY}/${SWAGGER_DESTINATION}"
#protoc ${PROJECT_DIRECTORY}/api/api.proto -I ${PROTOBUF_LIBRARY_LOCATION} -I ${PROJECT_DIRECTORY}/api/ -I $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis -I $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway --swagger_out=logtostderr=true:${PROJECT_DIRECTORY}/${SWAGGER_DESTINATION}
#
#echo
#echo "generating api docs..."
#echo "protoc ${PROJECT_DIRECTORY}/api/api.proto -I ${PROJECT_DIRECTORY}/api/ -I $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis -I $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway ${PROJECT_DIRECTORY}/api/api.proto --doc_out ${PROJECT_DIRECTORY}/docs/api-generated --doc_opt=markdown,api.md"
#protoc ${PROJECT_DIRECTORY}/api/api.proto -I ${PROJECT_DIRECTORY}/api/ -I $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis -I $GOPATH/src/github.com/grpc-ecosystem/grpc-gateway ${PROJECT_DIRECTORY}/api/api.proto --doc_out ${PROJECT_DIRECTORY}/docs/api-generated --doc_opt=markdown,api.md
#
