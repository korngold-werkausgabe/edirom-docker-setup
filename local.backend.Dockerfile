########################################
# CURL edirom-online from ewk-wa repo #
########################################
FROM curlimages/curl:latest AS curl-edirom

WORKDIR /downloads

RUN echo "Downloading Edirom-Online-Backend_EWK"
RUN curl -L -o Edirom-Online_${STATE}.xar "https://github.com/korngold-werkausgabe/Edirom-Online-Backend_EWK-WA/releases/download/latest/
eob-ewk-latest.xar"

########################
# Build edirom content #
########################
FROM openjdk:25-jdk-slim-bullseye AS build-content

RUN apt-get update \
    && apt-get install -y --no-install-recommends ant 

RUN git clone -b develop --single-branch --recursive https://github.com/Edirom/Edirom-Edition-Packaging.git

WORKDIR /Edirom-Edition-Packaging
COPY ../content .

#RUN find ./sources -type f -name "*.xml" -exec sed -i 's|https://dev.korngold-werkausgabe.de/Scaler/IIIF/||g' {} +

#RUN find ./sources -type f -name "*.xml" -exec sed -i 's|/info.json||g' {} +

RUN ant -Duri.edition=/Edirom-Edition-Packaging xar

#####################################
# Run exist-db and add xar-packages #
#####################################
FROM stadlerpeter/existdb:6.3.0

COPY --chown=wegajetty --from=curl-edirom /downloads/*.xar ${EXIST_HOME}/autodeploy/
COPY --chown=wegajetty --from=build-content /Edirom-Edition-Packaging/dist/*.xar ${EXIST_HOME}/autodeploy/
