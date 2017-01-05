#!/bin/bash

java -version 2>&1 >/dev/null | grep -q "java version"

if [ $? -ne 0 ]
then
  echo *******Please install java 1.7 or later************
  exit 1
fi

VERSION=$1

if [ -z $VERSION ]
then
  echo Please provide a valid cassandra version to install. like 2.2.8
  exit 1
fi

CASS=~/opt/cassandra


mkdir -p ~/opt/packages && cd $_ && \
curl -O "http://apache.mirrors.ionfish.org/cassandra/$VERSION/apache-cassandra-$VERSION-bin.tar.gz" && \
tar -xzvf apache-cassandra-$VERSION-bin.tar.gz && \
ln -s ~/opt/packages/apache-cassandra-$VERSION/ $CASS && \
mkdir -p $CASS/data/data && \
mkdir -p $CASS/data/commitlog && \
mkdir -p $CASS/data/saved_caches && \
mkdir -p $CASS/logs && \
brew install gnu-sed && \
alias sed=gsed && \
gsed -i -e '/^export PATH=/ s/$/:\~\/opt\/cassandra\/bin/' -e "$ a export CASSANDRA_HOME=$CASS" ~/.bash_profile && \
echo ------CASSANDRA $VERSION installed successfully.---------- 
