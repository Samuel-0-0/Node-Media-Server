FROM jrottenberg/ffmpeg:4.2-alpine AS ffmpeg

FROM node:10-alpine

LABEL maintainer="imhsaw@gmail.com"

# build variables
ARG GIT_BRANCH=master
ARG SRC_URL_PREFIX=https://github.com/illuspas/Node-Media-Server/archive
ARG SRC_URL="${SRC_URL_PREFIX}/${GIT_BRANCH}.zip"

# build
RUN cd      /tmp/                                                   && \
    wget    ${SRC_URL}  &&   unzip  *.zip                           && \
    rm      *.zip       &&   mv     Node-Media-Server* /usr/nms     && \
    cd      /usr/nms    &&   npm i


COPY --from=ffmpeg /usr/local /usr/local

EXPOSE 1935 8000 8443

WORKDIR /usr/nms

VOLUME /usr/nms

CMD ["node","app.js"]

