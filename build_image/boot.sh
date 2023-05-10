#!/usr/bin/env bash

chown -R 1000:1000 /kafka
exec gosu 1000:1000 start-kafka.sh
