#!/usr/bin/env bash
echo -e "\e[32mCreating mongo users...\e[0m"

mongo -u ${MONGO_INITDB_ROOT_USERNAME} \
      -p ${MONGO_INITDB_ROOT_PASSWORD} \
      --authenticationDatabase ${AUTH_DB} \
      --eval "
              defaultdb = db.getSiblingDB('${DB_NAME}');
              defaultdb.createUser({user: '${DB_USER}', pwd: '${DB_PASS}', roles: [{role: 'readWrite', db: '${DB_NAME}'}]});
              admindb = db.getSiblingDB('admin');
              admindb.createUser({user: '${MONITORING_USER}', pwd: '${MONITORING_PASS}', roles: [{role: 'clusterMonitor', db: 'admin'}]});
              "

echo -e "\e[32mCreated user '\e[4m${DB_USER}\e[24m' for database '\e[4m${DB_NAME}\e[24m'\e[0m"

echo -e "\e[32mCreating application user...\e[0m"
