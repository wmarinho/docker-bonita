#!/bin/sh


if [ ! "${DB_VENDOR}" ]; then
  DB_VENDOR="h2"
fi

if [ "${DB_VENDOR}" = "postgres" ]; then
  ${CATALINA_HOME}/bin/setup_potgresql.sh
  echo "Setting DB_VENDOR=${DB_VENDOR}"
fi

# Sets some variables
BONITA_HOME="-Dbonita.home=${CATALINA_HOME}/bonita"
DB_OPTS="-Dsysprop.bonita.db.vendor=${DB_VENDOR}"
BTM_OPTS="-Dbtm.root=${CATALINA_HOME} -Dbitronix.tm.configuration=${CATALINA_HOME}/conf/bitronix-config.properties"
#SECURITY_OPTS="-Djava.security.auth.login.config=${CATALINA_HOME}/bonita/client/platform/conf/jaas-standard.cfg"


CATALINA_OPTS="${CATALINA_OPTS} ${BONITA_HOME} ${DB_OPTS} ${BTM_OPTS} -Dfile.encoding=UTF-8 -Xshare:auto -Xms512m -Xmx1024m -XX:MaxPermSize=256m -XX:+HeapDumpOnOutOfMemoryError"
export CATALINA_OPTS

CATALINA_PID=${CATALINA_BASE}/catalina.pid
export CATALINA_PID

