#####################################
# Run exist-db and add xar-packages #
#####################################
FROM stadlerpeter/existdb:6.3.0
ENV EXIST_ENV=production
ENV EXIST_DEFAULT_APP_PATH=xmldb:exist:///db/apps/Edirom-Online

COPY --chown=wegajetty *.xar ${EXIST_HOME}/autodeploy/

