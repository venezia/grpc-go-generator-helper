#!/bin/bash

set -o errexit
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
