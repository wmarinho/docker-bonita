FROM wmarinho/pentaho-kettle


MAINTAINER Wellington Marinho wpmarinho@globo.com

ENV BONITA_VERSION 6.3.3
ENV BONITA_HOME /opt/bos

RUN apt-get update \
	&& apt-get install wget unzip git supervisor  -y 

RUN wget -nv http://download.forge.objectweb.org/bonita/BonitaBPMCommunity-${BONITA_VERSION}-Tomcat-6.0.37.zip -O /tmp/BonitaBPMCommunity-${BONITA_VERSION}-Tomcat-6.0.37.zip

RUN unzip -q /tmp/BonitaBPMCommunity-${BONITA_VERSION}-Tomcat-6.0.37.zip -d /opt && mv /opt/Bonita* ${BONITA_HOME} 

RUN apt-get install postgresql-client-9.3 npm -y && npm install less -g
RUN ln -s /usr/bin/nodejs /usr/bin/node
ADD config ${BONITA_HOME}/config/
ADD scripts/setenv.sh ${BONITA_HOME}/bin/
ADD scripts ${BONITA_HOME}/bin/
ADD config/supervisord.conf /etc/supervisor/conf.d/

RUN sed -i -e 's/\(exec ".*"\) start/\1 run/' ${BONITA_HOME}/bin/startup.sh 

RUN wget -q http://mirrors.jenkins-ci.org/war/latest/jenkins.war -O /opt/jenkins.war
RUN chmod 644 /opt/jenkins.war
ENV JENKINS_HOME /jenkins

EXPOSE 8080 8181 9090


CMD ["/usr/bin/supervisord"]
