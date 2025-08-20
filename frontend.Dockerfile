##############################
# Run nginx and add frontend #
##############################
FROM nginx:latest

COPY eof-ewk-latest /usr/share/nginx/html/

