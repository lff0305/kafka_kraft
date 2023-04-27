# kafka_kraft
a simple docker-compose example for kafka with kraft (Without Zookeeper)

# Requirement
`docker` and `compose` plugin (`docker compose` command)

This script will
- download and build a base image for java runtime (17.0.7)
- download and build the latest kafka (3.4.0) image on the java runtime image
- setup a cluster with 3 controllers, 5 brokers

# Start cluster:

- change the `HOST` variable in `.env` file to your IP Address for which this IP can be reached by other clients (**Note 1**)
- Run script
```
export IMAGE=test_kafka
cd build_image && ./build.sh $IMAGE && cd ..
docker compose up -d
```

the `IMAGE` can be changed to other names if you like

# Clients/SDKs

Connect to the cluster (`bootstrap.servers`) as `IP:9092,IP:9093,IP:9094,IP:9095,IP:9096`. The `IP` is the IP Address used in  (**Note 1**)

# Customize

| Var   |      Value      |  Default | Notes|
|:----------|:-------------|:------:|:-----|
| HOST |  IP Address for current machine |  | Please change to your IP|
| REPLICA |    Kafka topic replica config   |  1 | 2 or 3 is better but should < PARTITIONS |
| PARTITIONS | Kafka topic partitions config|    3 | |

# Thanks
Most of the kafka docker scripts are from https://github.com/wurstmeister/kafka-docker
