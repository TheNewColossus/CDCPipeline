#/bin/bash
curl -X POST -H "Content-Type: application/json" --data @connectors/debezium-pgsql.json http://localhost:8083/connectors
curl -X POST -H "Content-Type: application/json" --data @connectors/confluent-elasticsearch.json http://localhost:8083/connectors