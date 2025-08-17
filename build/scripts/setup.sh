#!/bin/bash
set -e

ROOT_DIR=$(realpath $(dirname ${BASH_SOURCE[0]})/..)
DOCKERFILE=$ROOT_DIR/build.Dockerfile
DOCKER_IMAGE_NAME="pwnkernel-build"
docker build -t $DOCKER_IMAGE_NAME \
            -f $DOCKERFILE \
            $ROOT_DIR
