# kafka_kraft
a simple docker-compose example for kafka with kraft (Without Zookeeper)

# Requirement
`docker` and `compose` plugin (`docker compose` command)

This script will
- download and build a base image for java runtime (17.0.7)
- download and build the latest kafka (3.4.0) image on the java runtime image
- setup a cluster with 3 controllers, 5 brokers

# Usage:

Run script
```
export IMAGE=test_kafka
cd build_image && ./build.sh $IMAGE && cd ..
docker compose up -d
```

the `IMAGE` can be changed to other names if you like

# Customize
If you need, update the `REPLICA` in `.env` file to 2 or 3 if more replica is needed than default replica (1)

# Thanks
Most of the kafka docker scripts are from https://github.com/wurstmeister/kafka-docker
