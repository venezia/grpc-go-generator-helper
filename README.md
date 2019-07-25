# gRPC for golang helper docker image

- [General Information](#general-information)
  * [What does this do?](#what-does-this-do-)
    + [Relevant Context](#relevant-context)
  * [Where does the output go?](#where-does-the-output-go-)
- [How to use it](#how-to-use-it)
  * [Scripts](#scripts)
  * [Environmental Variables](#environmental-variables)
  * [Important Notes](#important-notes)
  * [Examples](#examples)
    + [Creating API Stub Code](#creating-api-stub-code)
    + [Creating gRPC Gateway Stub Code](#creating-grpc-gateway-stub-code)
    + [Creating `swagger.json` File](#creating--swaggerjson--file)
    + [Creating API Documentation](#creating-api-documentation)
- [Contributions / Support](#contributions---support)

## General Information

### What does this do?

For a given grpc api built in go, this will generate:
* client and server code
* grpc-gateway code
* swagger.json artifact
* markdown documentation

#### Relevant Context
* [grpc](https://grpc.io)
* [grpc-go](https://github.com/grpc/grpc-go)
* [grpc-gateway](http://github.com/grpc-ecosystem/grpc-gateway)
* [swagger](https://swagger.io/)
* [protocol buffers](https://developers.google.com/protocol-buffers)


### Where does the output go?

It is designed to deliver the artifacts inside of go project, following the guidelines of [a popular standard layout for go projects](https://github.com/golang-standards/project-layout)
with some minor differences / interpretations

* generated go code will default to `pkg/generated/api`
* `swagger.json` will default to `assets/generated/swagger`
* markdown documentation will default to `docs/api-generated`

This was done to help make clear to anyone involved that these files are the result of a generator and should not be 
edited directly

## How to use it

You are intended to run this as a docker container.  [Examples will be provided below](#Examples)

There are four scripts provided in the docker container

### Scripts

| Script | Purpose |
| --- | --- |
| `/scripts/api-docs.sh` | Generates Markdown documentation for a gRPC API |
| `/scripts/api-stubs.sh` | Generates gRPC Server and Client code |
| `/scripts/rest-gateway.sh` | Generates gRPC Gateway code for API |
| `/scripts/swagger-docs.sh` | Generates `swagger.json` file for use with [grpc-gateway](http://github.com/grpc-ecosystem/grpc-gateway) |


### Environmental Variables

| Variable | Default Value | Significance | What uses it |
| --- | --- | --- | --- |
| `PROJECT_DIRECTORY` | `/input` | Where the project code is located | All helpers |
| `PROTOBUF_LIBRARY_LOCATION` | `/usr/include` | Where protobuf libraries are installed | All helpers |
| `INPUT_API_DIRECTORY` | `/input/api` | Folder containing protobuf file | All helpers |
| `INPUT_API_FILE` | `api.proto` | Protobuf file describing API, within `INPUT_API_DIRECTORY` | All helpers |
| `DESTINATION_LIBRARY` | `pkg/generated/api` | Output folder for generated go code | `api-stubs.sh`, `rest-gateway.sh` |
| `DOCUMENTATION_DESTINATION` | `docs/api-generated` | Output folder for markdown documentation | `api-docs.sh` |
| `SWAGGER_DESTINATION` | `assets/generated/swagger` | Output folder for swagger.json file | `swagger-docs.sh` |

### Important Notes

* Folders will be created if they do not already exist

### Examples

#### Creating API Stub Code
```bash
docker run --rm=true -it -v /projects/my-cool-project:/input quay.io/venezia/grpc-go-generator-helper:latest /scripts/api-stubs.sh
Defaulting to /input as the PROJECT_DIRECTORY
Defaulting to /usr/include as the PROTOBUF_LIBRARY_LOCATION
Defaulting to /input/api as the INPUT_API_DIRECTORY
Defaulting to api.proto as the INPUT_API_FILE
Full API Filepath is /input/api/api.proto
Defaulting to pkg/generated/api as the DESTINATION_LIBRARY
Ensuring Destination Directory ( /input/pkg/generated/api ) Exists...

generating api stubs...
protoc /input/api/api.proto -I /usr/include/ -I /input/api/  --go_out=plugins=grpc:/input/pkg/generated/api/ -I/go/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis -I/go/src/github.com/grpc-ecosystem/grpc-gateway -I/go/src
```

#### Creating gRPC Gateway Stub Code
```bash
docker run --rm=true -it -v /projects/my-cool-project:/input quay.io/venezia/grpc-go-generator-helper:latest /scripts/rest-gateway.sh
Defaulting to /input as the PROJECT_DIRECTORY
Defaulting to /usr/include as the PROTOBUF_LIBRARY_LOCATION
Defaulting to /input/api as the INPUT_API_DIRECTORY
Defaulting to api.proto as the INPUT_API_FILE
Full API Filepath is /input/api/api.proto
Defaulting to pkg/generated/api as the DESTINATION_LIBRARY
Ensuring Destination Directory ( /input/pkg/generated/api ) Exists...

generating REST gateway stubs...
protoc /input/api/api.proto -I /usr/include/ -I /input/api/ -I /go/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis -I /go/src/github.com/grpc-ecosystem/grpc-gateway --grpc-gateway_out=logtostderr=true:/input/pkg/generated/api
```

#### Creating `swagger.json` File
```bash
docker run --rm=true -it -v /projects/my-cool-project:/input quay.io/venezia/grpc-go-generator-helper:latest /scripts/swagger-docs.sh
Defaulting to /input as the PROJECT_DIRECTORY
Defaulting to /usr/include as the PROTOBUF_LIBRARY_LOCATION
Defaulting to /input/api as the INPUT_API_DIRECTORY
Defaulting to api.proto as the INPUT_API_FILE
Full API Filepath is /input/api/api.proto
Defaulting to assets/generated/swagger as the SWAGGER_DESTINATION
Ensuring Swagger Asset Directory ( /input/assets/generated/swagger ) Exists...

generating swagger docs...
protoc /input/api/api.proto -I /usr/include/ -I /input/api/ -I /go/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis -I /go/src/github.com/grpc-ecosystem/grpc-gateway --swagger_out=logtostderr=true:/input/assets/generated/swagger
```

#### Creating API Documentation
```bash
docker run --rm=true -it -v /projects/my-cool-project:/input quay.io/venezia/grpc-go-generator-helper:latest /scripts/api-docs.sh
Defaulting to /input as the PROJECT_DIRECTORY
Defaulting to /usr/include as the PROTOBUF_LIBRARY_LOCATION
Defaulting to /input/api as the INPUT_API_DIRECTORY
Defaulting to api.proto as the INPUT_API_FILE
Full API Filepath is /input/api/api.proto
Defaulting to docs/api-generated as the DOCUMENTATION_DESTINATION
Ensuring Documentation Destination Directory ( /input/docs/api-generated ) Exists...

generating api docs...
protoc /input/api/api.proto -I /usr/include/ -I /input/api/ -I /go/src/github.com/grpc-ecosystem/grpc-gateway/third_party/googleapis -I /go/src/github.com/grpc-ecosystem/grpc-gateway /input/api/api.proto --doc_out /input/docs/api-generated --doc_opt=markdown,api.md
```

## Contributions / Support

* Please open issues if there are any problems or updates needed.
* Enhancements are always welcome

Thanks for reading the README! 
