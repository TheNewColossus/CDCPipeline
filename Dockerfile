FROM confluentinc/cp-server-connect:7.3.2

RUN confluent-hub install --no-prompt debezium/debezium-connector-postgresql:2.5.4