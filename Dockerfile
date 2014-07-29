FROM wmarinho/ubuntu:oracle-jdk-7


MAINTAINER Wellington Marinho wpmarinho@globo.com

ENV BONITA_VERSION 6.3.2

RUN apt-get update \
	&& apt-get install wget unzip git -y 

RUN wget -nv http://download.forge.objectweb.org/bonita/BonitaBPMCommunity-6.3.2-Tomcat-6.0.37.zip -O /tmp/BonitaBPMCommunity-6.3.2-Tomcat-6.0.37.zip

RUN unzip -q /tmp/BonitaBPMCommunity-6.3.2-Tomcat-6.0.37.zip -d /opt && mv /opt/Bonita* /opt/bos

RUN sed -i -e 's/\(exec ".*"\) start/\1 run/' /opt/bos/bin/startup.sh 

EXPOSE 8080


CMD ["/opt/bos/bin/startup.sh"]
