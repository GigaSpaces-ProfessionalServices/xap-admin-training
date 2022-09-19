#!/bin/bash

if [ `whoami` != "root" ];then
		echo "This script must be run as root."
		exit
fi

mkdir -p \
/dbagigashare/current/data-integration/di-manager/ \
/dbagigashare/current/data-integration/di-mdm/ \
/dbagigashare/current/data-integration/di-flink/ \
/dbagigashare/current/telegraf/jars \
/dbagigashare/current/grafana/dashboards/ \
/dbagigashare/current/telegraf/scripts/space \
/dbagigashare/current/telegraf/config/pivot \
/dbagigashare/current/telegraf/config/agent \
/dbagigashare/current/kapacitor/config \
/dbagigashare/current/kapacitor/templates \
/dbagigashare/current/kapacitor/alerts \
/dbagigashare/current/gs/upgrade \
/dbagigashare/current/gs/config/space \
/dbagigashare/current/gs/config/metrics \
/dbagigashare/current/gs/jars/space \
/dbagigashare/current/gs/config/license \
/dbagigashare/current/grafana/catalog/jars \
/dbagigashare/current/data-validator/files \
/dbagigashare/current/data-validator/jars \
/dbagigashare/current/gs/jars/ts \
/dbagigashare/current/mq-connector/adabas/jars \
/dbagigashare/current/mq-connector/adabas/config \
/dbagigashare/current/mssql/files \
/dbagigashare/current/mq-connector \
/dbagigashare/current/security/jars/cef \
/dbagigashare/current/gs/config/log/ \
/dbagigashare/current/gs/jars \
/dbagigashare/current/gs/config/ts \
/dbagigashare/current/odsx \
/dbagigashare/current/mssql/jars \
/dbagigashare/current/mssql/scripts \
/dbagigashare/current/db2/jars \
/dbagigashare/current/db2/scripts \
/dbagigashare/current/cr8 \
/dbagigashare/current/grafana \
/dbagigashare/current/influx \
/dbagigashare/current/gs \
/dbagigashare/current/jdk \
/dbagigashare/current/kafka \
/dbagigashare/current/nb \
/dbagigashare/current/nb/applicative/ssl \
/dbagigashare/current/nb/management/ssl \
/dbagigashare/current/sqlite /dbagigashare/current/security \
/dbagigashare/current/unzip \
/dbagigashare/current/zk \
/dbagigashare/current/telegraf
