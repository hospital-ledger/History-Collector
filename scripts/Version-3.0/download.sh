#!/bin/bash
docker pull hyperledger/fabric-tools:latest
docker pull hyperledger/fabric-peer:latest
docker pull hyperledger/fabric-orderer:latest
docker pull hyperledger/fabric-ccenv:latest
docker pull hyperledger/fabric-baseos:latest
docker pull hyperledger/fabric-javaenv:latest
docker pull hyperledger/fabric-nodeenv:latest
docker pull hyperledger/fabric-ca:latest
docker pull hyperledger/fabric-zookeeper:latest
docker pull hyperledger/fabric-kafka:latest
docker pull hyperledger/fabric-couchdb:latest

docker pull hyperledger/fabric-tools:2.0
docker pull hyperledger/fabric-peer:2.0
docker pull hyperledger/fabric-orderer:2.0
docker pull hyperledger/fabric-ccenv:2.0
docker pull hyperledger/fabric-baseos:2.0
docker pull hyperledger/fabric-javaenv:2.0
docker pull hyperledger/fabric-nodeenv:2.0
docker pull hyperledger/fabric-ca:1.4
docker pull hyperledger/fabric-zookeeper:0.4
docker pull hyperledger/fabric-kafka:0.4
docker pull hyperledger/fabric-couchdb:0.4

docker pull hyperledger/fabric-tools:2.0.0
docker pull hyperledger/fabric-peer:2.0.0
docker pull hyperledger/fabric-orderer:2.0.0
docker pull hyperledger/fabric-ccenv:2.0.0
docker pull hyperledger/fabric-baseos:2.0.0
docker pull hyperledger/fabric-javaenv:2.0.0
docker pull hyperledger/fabric-nodeenv:2.0.0
docker pull hyperledger/fabric-ca:1.4.4
docker pull hyperledger/fabric-zookeeper:0.4.18
docker pull hyperledger/fabric-kafka:0.4.18
docker pull hyperledger/fabric-couchdb:0.4.18

docker pull nginx:latest
docker pull alpine:3.10
docker pull golang:1.13.4-alpine
docker pull golang:1.13.4-alpine3.10

# These images may be wrong for different computers. 
docker pull hyperledger/fabric-tools:amd64-2.0.0-snapshot-02cde2c
docker pull hyperledger/fabric-peer:amd64-2.0.0-snapshot-02cde2c
docker pull hyperledger/fabric-orderer:amd64-2.0.0-snapshot-02cde2c
docker pull hyperledger/fabric-ccenv:amd64-2.0.0-snapshot-02cde2c
docker pull hyperledger/fabric-baseos:amd64-2.0.0-snapshot-02cde2c

docker images                                        
sleep 1
echo -e "Please check the Docker Images List and compare with the List on Github.com, thank you."
# The script last edited by Tom at 11:10 A.M. on 2020.02.08 Sat. - Version 2.0 -
# The script last edited by Tom at 07:57 P.M. on 2020.02.08 Sat. - Version 3.0 -
