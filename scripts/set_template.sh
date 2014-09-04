#!/bin/bash

CUSTOM_TEMPLATE="${BONITA_HOME}/config/custom-template"

if [ "${URL_CUSTOM_TEMPLATE}" ]; then

	wget -nv ${URL_CUSTOM_TEMPLATE} -O /tmp/bonita-portal-theme.zip
        unzip -q /tmp/bonita-portal-theme.zip -d ${CUSTOM_TEMPLATE}/theme/portal 
fi

CUSTOM_TEMPLATE="${BONITA_HOME}/config/custom-template"

if [ "${APPLY_TEMPLATE}" ]; then

	if [ "${MAIN_COLOR}" ]; then
        	sed -i "s/@mainAccentColor: #b20706;/@mainAccentColor: #${MAIN_COLOR};/g" ${CUSTOM_TEMPLATE}/theme/portal/skin/skin.config.less
	fi


	if [ "${SECOND_COLOR}" ]; then
                sed -i "s/@secondAccentColor: #313433;/@secondAccentColor: #${SECOND_COLOR};/g" ${CUSTOM_TEMPLATE}/theme/portal/skin/skin.config.less
        fi
        
	lessc ${CUSTOM_TEMPLATE}/theme/portal/main.less ${CUSTOM_TEMPLATE}/theme/portal/bonita.css
        cp -r ${CUSTOM_TEMPLATE}/theme ${BONITA_HOME}/bonita/client/platform/tenant-template/work/
        unzip -q ${BONITA_HOME}/webapps/bonita.war -d ${BONITA_HOME}/webapps/bonita
        cp -r ${CUSTOM_TEMPLATE}/webapps/* ${BONITA_HOME}/webapps/bonita/
        rm -rf ${CUSTOM_TEMPLATE}
fi

