FROM golang:1.12.7-alpine3.10
RUN     apk update && \
        apk add git bash protobuf-dev protobuf && \
        go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-grpc-gateway && \
        go get -u github.com/grpc-ecosystem/grpc-gateway/protoc-gen-swagger && \
        go get -u github.com/golang/protobuf/protoc-gen-go && \
        go get -u github.com/pseudomuto/protoc-gen-doc/cmd/protoc-gen-doc
ADD scripts /scripts
