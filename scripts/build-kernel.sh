ROOT_DIR=$(realpath $(dirname $0)/..)
ASSETS_DIR=$ROOT_DIR/assets
DOCKER_IMAGE_NAME="pwnkernel-build"
docker run  --rm \
            -e KERNEL_VERSION=$KERNEL_VERSION \
            --mount type=bind,source=$ASSETS_DIR,target=/build \
            $DOCKER_IMAGE_NAME \
            ./build-kernel.sh
