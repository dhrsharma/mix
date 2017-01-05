#!/bin/bash

read -p 'Please enter your proxy endpoint: ' proxy

export http_proxy=$proxy
export https_proxy=$proxy
echo .
echo .
echo .
echo .

#java -version 2>&1 >/dev/null | grep -q "java version"

#if [ $? -ne 0 ]
#then
echo *******Please have java 1.7 or later installed to run cassandra after this installation************
#  exit 1
#fi

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
gsed -i -e '/^export PATH=/ s/$/:\~\/opt\/cassandra\/bin/' -e "$ a export CASSANDRA_HOME=$CASS" -e '$ a export PATH=$PATH:\~\/opt\/cassandra\/bin/' ~/.bash_profile && \
echo ------CASSANDRA $VERSION installed successfully.---------- 

unset http_proxy https_proxy

echo Now open another shell session and hit 'cassandra -f' to run cassandra in foreground.
