FROM ubuntu:latest

USER root

RUN apt-get update
RUN apt-get install -y git curl unzip make libsqlite3-dev python3

ENV FLUTTER_HOME=/root/flutter
ENV FLUTTER_ROOT=$FLUTTER_HOME

ENV PATH ${PATH}:${FLUTTER_HOME}/bin:${FLUTTER_HOME}/bin/cache/dart-sdk/bin:/root/.pub-cache/bin

ARG flutter_version

ENV FLUTTER_VERSION=$flutter_version

RUN git clone --depth 1 --branch ${FLUTTER_VERSION} https://github.com/flutter/flutter.git ${FLUTTER_HOME}

RUN flutter precache \
    && flutter doctor \
    && chown -R root:root ${FLUTTER_HOME}

RUN dart pub global activate melos
RUN dart pub global activate remove_from_coverage
