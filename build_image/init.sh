echo "init kafka storage if needed"
mkdir -p /kafka/data
cd $KAFKA_HOME
./bin/kafka-storage.sh info --config ./config/kraft/server.properties
r=$?
if [ $r -ne 0 ]; then 
    echo "Error check info. Init storage"
    ./bin/kafka-storage.sh format -t $STORAGE_ID -c ./config/kraft/server.properties
else
    echo "Check info ok."
fi
