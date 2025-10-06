########################################
# CURL edirom-online from ewk-wa repo #
########################################
FROM curlimages/curl:latest AS curl-edirom

WORKDIR /downloads

RUN echo "Downloading Edirom-Online-Backend_EWK"
RUN curl -L -o  eob-ewk-latest.xar  "https://github.com/korngold-werkausgabe/Edirom-Online-Backend_EWK-WA/releases/download/latest/eob-ewk-latest.xar"

#####################################
# Run exist-db and add xar-packages #
#####################################
FROM stadlerpeter/existdb:6.3.0

COPY --chown=wegajetty --from=curl-edirom /downloads/*.xar ${EXIST_HOME}/autodeploy/
COPY --chown=wegajetty build-xar/*.xar ${EXIST_HOME}/autodeploy/
