#!/bin/bash

CUSTOM_TEMPLATE="${BONITA_HOME}/config/custom-template"

if [ -d "${CUSTOM_TEMPLATE}" ]; then
	cp -r ${CUSTOM_TEMPLATE}/theme ${BONITA_HOME}/bonita/client/platform/tenant-template/work/
	unzip -q ${BONITA_HOME}/webapps/bonita.war -d ${BONITA_HOME}/webapps/bonita
	cp -r ${CUSTOM_TEMPLATE}/webapps ${BONITA_HOME}/webapps/bonita/
	rm -rf ${CUSTOM_TEMPLATE}
fi

sh /opt/bos/bin/startup.sh
