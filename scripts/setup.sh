ROOT_DIR=$(realpath $(dirname $0)/..)
DOCKERFILE=$ROOT_DIR/build.Dockerfile
DOCKER_IMAGE_NAME="pwnkernel-build"
docker build -t $DOCKER_IMAGE_NAME \
            -f $DOCKERFILE \
            $ROOT_DIR
