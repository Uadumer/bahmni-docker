#!/bin/sh
set -e

create_user_and_database() {
  export PG_PASSWORD=${POSTGRES_PASSWORD}
  DB_NAME="$1"
  DB_USERNAME="$2"
  DB_PASSWORD="$3"
  psql -c "CREATE DATABASE ${DB_NAME};"
  psql -c "REVOKE ALL ON DATABASE ${DB_NAME} FROM PUBLIC;"
  psql -c "CREATE USER ${DB_USERNAME} WITH ENCRYPTED PASSWORD '${DB_PASSWORD}';"
  psql -c "GRANT ALL ON DATABASE ${DB_NAME} TO ${DB_USERNAME};"
}

create_user_and_database "${DCM4CHEE_DB_NAME}" "${DCM4CHEE_DB_USERNAME}" "${DCM4CHEE_DB_PASSWORD}"
create_user_and_database "${PACS_INTEGRATION_DB_NAME}" "${PACS_INTEGRATION_DB_USERNAME}" "${PACS_INTEGRATION_DB_PASSWORD}"