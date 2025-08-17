FROM debian:11
ARG BUILD_USER="build"
ARG KERNEL_VERSION
ARG BUSYBOX_VERSION

RUN apt update -y && apt upgrade -y
RUN apt install -y build-essential wget sudo flex bison libelf-dev libssl-dev bc
RUN useradd -ms /bin/bash ${BUILD_USER}
RUN usermod -aG sudo ${BUILD_USER}
RUN echo "${BUILD_USER}:${BUILD_USER}" | chpasswd

USER ${BUILD_USER}
WORKDIR /home/${BUILD_USER}
COPY scripts/container/* /home/${BUILD_USER}
