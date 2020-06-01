#!/usr/bin/env bash
if [[ -z "${XAPHOMEDIR}" ]]; then
  export XAPHOMEDIR=/home/jay/work/gigaspace/gigaspaces-insightedge-enterprise-15.2.0
fi

java -cp "$XAPHOMEDIR/lib/required/*":"target/*" com.gs.admin.monitor.AdminAlert $*
