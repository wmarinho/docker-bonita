#!/bin/bash

if [ -f "${BONITA_HOME}/.bonita_pgconfig" ]; then
  exit 0; 
fi

PGHOST="$RDS_HOSTNAME"
PGUSER="$RDS_USERNAME"
PGPASSWORD="$RDS_PASSWORD"
PGDATABASE="$RDS_DB_NAME"
PGPORT="$RDS_PORT"


if [ "$PGHOST" ]; then
	if [ ! "$PGPORT" ]; then
	        PGPORT=5432
	fi
	if [ ! "$PGDATABASE" ]; then
	        PGDATABASE=postgres
	fi
	if [ ! "$PGUSER" ]; then
	        PGUSER=pgadmin
	fi
	if [ ! "$PGPASSWORD" ]; then
	        PGPASSWORD=pgadmin.

	fi
	export PGPASSWORD="$PGPASSWORD"
	echo "Checking PostgreSQL connection ..."

	nc -zv $PGHOST $PGPORT

	if [ "$?" -ne "0" ]; then
		echo "PostgreSQL connection failed."
		exit 0
	fi
    CHK_BONITA_DB=`echo "$(psql -U $PGUSER  -h $PGHOST -d $PGDATABASE -l | grep bonita | wc -l)"`
    
    if [ "$CHK_BONITA_DB" -eq "0" ]; then
      psql -U $PGUSER  -h $PGHOST -d $PGDATABASE --command "CREATE USER bonita WITH SUPERUSER PASSWORD 'bpm';"
      psql -U $PGUSER  -h $PGHOST -d $PGDATABASE --command "CREATE DATABASE bonita OWNER bonita;"
    fi
     cp -r ${BONITA_HOME}/config ${BONITA_HOME}/config_tmp
      sed -i "s/serverName=localhost/serverName=${PGHOST}/g" ${BONITA_HOME}/config_tmp/postgresql/conf/bitronix-resources.properties
      sed -i "s/localhost:5432/${PGHOST}:${PGPORT}/g" ${BONITA_HOME}/config_tmp/postgresql/conf/Catalina/localhost/bonita.xml
      cp -r ${BONITA_HOME}/config_tmp/postgresql/* ${BONITA_HOME}/
      wget -nv https://jdbc.postgresql.org/download/postgresql-${PGSQL_BUILD}.jdbc4.jar -O ${BONITA_HOME}/lib/postgresql-${PGSQL_BUILD}.jdbc3.jar
      rm -rf ${BONITA_HOME}/config_tmp
     touch ${BONITA_HOME}/.bonita_pgconfig
fi
