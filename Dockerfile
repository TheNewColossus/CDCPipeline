FROM confluentinc/cp-server-connect:7.3.2 AS kafka_server
RUN confluent-hub install --no-prompt debezium/debezium-connector-postgresql:2.5.4

FROM spark:3.5.4 AS spark
USER root
COPY depd /opt/spark/jars
COPY app.py /opt/spark/work-dir
RUN apt-get update && apt-get upgrade -y && \
    apt-get install -y openjdk-8-jdk jupyter && \
    rm -rf /var/lib/apt/lists/*
RUN pip install pyspark pandas numpy
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH="${JAVA_HOME}/bin:${PATH}"
