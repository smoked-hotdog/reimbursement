#! /bin/sh

while [[ ! -z $1 ]]; do
    case $1 in
        -d|--database)
        MYSQL_DATABASE_NAME="$2"
        ;;
        -cl|--changelog)
        CHANGELOG=$(echo "$2" | awk '{ print tolower($0); }')
        ;;
        -R|--rollback)
        ROLLBACK_FLAG="1"
        ;;
        *)
    esac
    shift
done

if [[ -z ${MYSQL_DATABASE_NAME} ]]; then
    MYSQL_DATABASE_NAME="rewardbox"
fi

if [[ -z ${CHANGELOG} ]]; then
    echo "Please specify JIRA ticket or rollback tag name"
    echo "\nUsage: ./liquibase/generate-sql.sh --changelog <JIRA ticket or rollback tag name> [Other Options]"
    echo "Other Options:"
    echo "\t--database, -d\t\tDatabase name"
    echo "\t--rollback, -R\t\tRollback flag"
else
    SQL_FILE=$(pwd)/liquibase/sql/update/${CHANGELOG}.sql
    TEMPORARY_SQL_FILE_1=${SQL_FILE}-1.bak
    TEMPORARY_SQL_FILE_2=${SQL_FILE}-2.bak
    echo "Generating SQL file [${SQL_FILE}]"
    if [[ -z ${ROLLBACK_FLAG} ]]; then
        $(pwd)/liquibase/run-liquibase.sh -d ${MYSQL_DATABASE_NAME} -R ${CHANGELOG} || echo "Please ignore this error."
        ($(pwd)/liquibase/run-liquibase.sh -d ${MYSQL_DATABASE_NAME} -S) > ${TEMPORARY_SQL_FILE_1}
    else
        SQL_FILE=$(pwd)/liquibase/sql/rollback/${CHANGELOG}-rollback.sql
        TEMPORARY_SQL_FILE_1=${SQL_FILE}.bak
        $(pwd)/liquibase/run-liquibase.sh -d ${MYSQL_DATABASE_NAME} || echo "Please ignore this error."
        ($(pwd)/liquibase/run-liquibase.sh -d ${MYSQL_DATABASE_NAME} -S -R ${CHANGELOG}) > ${TEMPORARY_SQL_FILE_1}
    fi
    sed '/^.*DATABASECHANGELOG.*$/d' ${TEMPORARY_SQL_FILE_1} > ${TEMPORARY_SQL_FILE_2}
    sed '/^.*Rolling.*$/d' ${TEMPORARY_SQL_FILE_2} > ${SQL_FILE}
    echo "$(tail -n +8 ${SQL_FILE})" > ${SQL_FILE}
    rm ${TEMPORARY_SQL_FILE_1}
    rm ${TEMPORARY_SQL_FILE_2}
fi
