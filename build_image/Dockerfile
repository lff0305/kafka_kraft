FROM ubuntu:focal-20230412 AS java

ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

ADD ./openjdk /opt/java/openjdk

RUN apt update && apt install -y wget curl unzip sudo locales

RUN echo "LC_ALL=en_US.UTF-8" >> /etc/environment \
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && echo "LANG=en_US.UTF-8" > /etc/locale.conf \
    && locale-gen en_US.UTF-8 \
    && groupadd -g 1000 kafka \
    && useradd -u 1000 -g kafka kafka \
    && mkdir /logs \
    && chgrp kafka /logs \
    && chown kafka logs \
    && wget https://github.com/tianon/gosu/releases/download/1.16/gosu-amd64 \
    && wget https://github.com/alibaba/arthas/releases/download/arthas-all-3.6.7/arthas-bin.zip \
    && chmod +x /gosu-amd64 \
    && mv /gosu-amd64 gosu \
    && mkdir arthas \
    && unzip arthas-bin.zip -d arthas \
    && rm -rf arthas-bin.zip

ENV JAVA_HOME=/opt/java/openjdk \
    PATH="/opt/java/openjdk/bin:$PATH"


FROM java

ARG kafka_version=3.4.0
ARG scala_version=2.13
ARG vcs_ref=unspecified
ARG build_date=unspecified

LABEL org.label-schema.name="kafka" \
      org.label-schema.description="Apache Kafka" \
      org.label-schema.build-date="${build_date}" \
      org.label-schema.vcs-url="https://github.com/wurstmeister/kafka-docker" \
      org.label-schema.vcs-ref="${vcs_ref}" \
      org.label-schema.version="${scala_version}_${kafka_version}" \
      org.label-schema.schema-version="1.0" \
      maintainer="wurstmeister"

ENV KAFKA_VERSION=$kafka_version \
    SCALA_VERSION=$scala_version \
    KAFKA_HOME=/opt/kafka \
    GLIBC_VERSION=$glibc_version

ENV PATH=${PATH}:${KAFKA_HOME}/bin

COPY download-kafka.sh start-kafka.sh broker-list.sh create-topics.sh versions.sh /tmp/

RUN apt update && apt install -y bash curl jq \
 && chmod a+x /tmp/*.sh \
 && mv /tmp/start-kafka.sh /tmp/broker-list.sh /tmp/create-topics.sh /tmp/versions.sh /usr/bin \
 && sync && /tmp/download-kafka.sh \
 && tar xfz /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz -C /opt \
 && rm /tmp/kafka_${SCALA_VERSION}-${KAFKA_VERSION}.tgz \
 && ln -s /opt/kafka_${SCALA_VERSION}-${KAFKA_VERSION} ${KAFKA_HOME} \
 && rm /tmp/* \
 && chgrp kafka -HR /opt/kafka \
 && chown kafka -HR /opt/kafka \
 && mkdir -p /kafka \
 && chgrp -HR kafka /kafka \
 && chown -HR kafka /kafka \
 && cp /gosu /usr/bin/

COPY overrides /opt/overrides

COPY init.sh /

RUN chmod +x /init.sh

VOLUME ["/kafka"]


# Use "exec" form so that it runs as PID 1 (useful for graceful shutdown)
CMD ["gosu", "1000:1000",  "start-kafka.sh"]
