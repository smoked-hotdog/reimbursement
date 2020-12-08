#! /bin/sh

while [[ ! -z $1 ]]; do
    case $1 in
        -H|--host)
        MYSQL_HOST="$2"
        ;;
        -P|--port)
        MYSQL_PORT="$2"
        ;;
        -d|--database)
        MYSQL_DATABASE_NAME="$2"
        ;;
        -u|--user)
        MYSQL_USER="$2"
        ;;
        -p|--password)
        MYSQL_PASSWORD="$2"
        ;;
        -n|--docker-network)
        MYSQL_DOCKER_NETWORK="$2"
        ;;
        -R|--rollback)
        ROLLBACK_TAG="$2"
        ;;
        -S|--sql)
        PRINT_SQL="print-sql"
        ;;
        *)
    esac
    shift
done

if [[ -z ${MYSQL_HOST} ]]; then
    MYSQL_HOST="localhost"
fi

if [[ -z ${MYSQL_PORT} ]]; then
    MYSQL_PORT="3306"
fi

if [[ -z ${MYSQL_USER} ]]; then
    MYSQL_USER="root"
fi

if [[ -z ${MYSQL_PASSWORD} ]]; then
    MYSQL_PASSWORD="123456"
fi

if [[ -z ${MYSQL_DOCKER_NETWORK} ]]; then
    MYSQL_DOCKER_NETWORK="host"
fi

if [[ -z ${ROLLBACK_TAG} ]]; then
    if [[ -z ${PRINT_SQL} ]]; then
        COMMAND="update"
    else
        COMMAND="updateSQL"
    fi
else
    if [[ -z ${PRINT_SQL} ]]; then
        COMMAND="rollback ${ROLLBACK_TAG}"
    else
        COMMAND="rollbackSQL ${ROLLBACK_TAG}"
    fi
fi

if [[ -z ${MYSQL_DATABASE_NAME} ]]; then
    echo "Please specify Database Name"
    echo "\nUsage: ./liquibase/run-liquibase.sh --database <database name> [Other Options]"
    echo "\t--database, -d\t\tDatabase name"
    echo "Other Options:"
    echo "\t--host, -H\t\tDatabase host (default: localhost)"
    echo "\t--port, -P\t\tDatabase port (default: 3306)"
    echo "\t--user, -u\t\tDatabase user (default: root)"
    echo "\t--password, -p\t\tDatabase password (default: 123456)"
    echo "\t--docker-network, -n\tDocker network name (default: host)"
    echo "\t--rollback, -R\t\tRollback a changeset using a tag"
    echo "\t--sql, -S\t\tPrint SQL Only"
else
    echo "MySQL Host:     ${MYSQL_HOST}"
    echo "MySQL Port:     ${MYSQL_PORT}"
    echo "MySQL Database: ${MYSQL_DATABASE_NAME}"
    echo "MySQL User:     ${MYSQL_USER}"
    echo "MySQL Password: ${MYSQL_PASSWORD}"
    echo "Rollback Tag:   ${ROLLBACK_TAG}"

    docker run --rm -v $(pwd)/liquibase:/liquibase/ \
    --network ${MYSQL_DOCKER_NETWORK} \
    -e "LIQUIBASE_URL=jdbc:mysql://${MYSQL_HOST}:${MYSQL_PORT}/${MYSQL_DATABASE_NAME}?createDatabaseIfNotExist=true&characterEncoding=UTF-8" \
    -e "LIQUIBASE_USERNAME=${MYSQL_USER}" \
    -e "LIQUIBASE_PASSWORD=${MYSQL_PASSWORD}" \
    -e "LIQUIBASE_CHANGELOG=./changelog.xml" \
    webdevops/liquibase:mysql ${COMMAND}
fi
