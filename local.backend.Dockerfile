########################################
# CURL edirom-online from ewk-wa repo #
########################################
FROM curlimages/curl:latest AS curl-edirom

WORKDIR /downloads

RUN echo "Downloading Edirom-Online-Backend_EWK"
RUN curl -L -o  eob-ewk-latest.xar  "https://github.com/korngold-werkausgabe/Edirom-Online-Backend_EWK-WA/releases/download/latest/eob-ewk-latest.xar"

########################
# Build edirom content #
########################
FROM openjdk:25-jdk-slim-bullseye AS build-content

#ARG EDIROM_CONTENT_PATH
#ENV EDIROM_CONTENT_PATH=${EDIROM_CONTENT_PATH:-../Edirom/content}

RUN apt-get update \
    && apt-get install -y --no-install-recommends ant git

RUN git clone -b develop --single-branch --recursive https://github.com/Edirom/Edirom-Edition-Packaging.git

WORKDIR /Edirom-Edition-Packaging
#COPY ${EDIROM_CONTENT_PATH} .
COPY content .

RUN ant -Duri.edition=/Edirom-Edition-Packaging xar

#####################################
# Run exist-db and add xar-packages #
#####################################
FROM stadlerpeter/existdb:6.3.0

COPY --chown=wegajetty --from=curl-edirom /downloads/*.xar ${EXIST_HOME}/autodeploy/
COPY --chown=wegajetty --from=build-content /Edirom-Edition-Packaging/dist/*.xar ${EXIST_HOME}/autodeploy/
