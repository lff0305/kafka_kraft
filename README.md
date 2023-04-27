# kafka_kraft
a simple docker-compose example for kafka with kraft.

This script will
- download and build images for java runtime (17.0.7)
- download and install the latest kafka (3.4.0)
- setup a cluster with 3 controllers, 5 brokers

# Usage:

Run script
```
export IMAGE=test_kafka
cd build_image && ./build.sh $IMAGE && cd ..
docker compose up -d
```
