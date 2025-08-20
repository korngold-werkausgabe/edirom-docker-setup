########################################
# CURL edirom-online from ewk-wa repo #
########################################
FROM curlimages/curl:latest AS curl-edirom

WORKDIR /downloads

RUN echo "Downloading Edirom-Online-Frontend_EWK"
RUN curl -L -o eof-ewk-build.tar.gz "https://github.com/korngold-werkausgabe/Edirom-Online-Frontend_EWK-WA/releases/download/latest/eof-ewk-build.tar.gz"
RUN mkdir eof-ewk-build
RUN tar -xzf eof-ewk-build.tar.gz -C eof-ewk-build

FROM nginx:latest

COPY --from=curl-edirom /downloads/eof-ewk-build /usr/share/nginx/html