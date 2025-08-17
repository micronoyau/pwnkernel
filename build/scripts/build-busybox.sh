#!/bin/bash
set -e

ROOT_DIR=$(realpath $(dirname ${BASH_SOURCE[0]})/../..)
ASSETS_DIR=$ROOT_DIR/assets
DOCKER_IMAGE_NAME="pwnkernel-build"
docker run  --rm \
            -e BUSYBOX_VERSION=$BUSYBOX_VERSION \
            --mount type=bind,source=$ASSETS_DIR,target=/build \
            $DOCKER_IMAGE_NAME \
            ./build-busybox.sh
