ARG IMAGE=intersystemsdc/irishealth-community:2022.2.0.368.0-zpm
ARG IMAGE=intersystemsdc/irishealth-community
ARG IMAGE=intersystemsdc/iris-community
FROM $IMAGE

USER root

# create directory to copy files into image
WORKDIR /opt/irisapp
RUN chown -R irisowner:irisowner /opt/irisapp

USER irisowner

# copy files to image
WORKDIR /opt/irisapp
COPY --chown=irisowner:irisowner iris.script iris.script
COPY --chown=irisowner:irisowner src src
COPY --chown=irisowner:irisowner module.xml module.xml

WORKDIR /tmp

# run iris.script
RUN iris start IRIS \
    && iris session IRIS < /opt/irisapp/iris.script \
    && iris stop IRIS quietly