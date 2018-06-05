FROM alpine:latest

RUN apk update \
&& apk upgrade \
&& apk add alpine-sdk \
&& apk add musl-dev \
&& apk add nasm
