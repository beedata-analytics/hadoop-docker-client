FROM ubuntu:18.04

MAINTAINER "Beedata Analytics <info@beedataanalytics.com>"

RUN apt-get update \
	&& apt-get upgrade -y \
    && apt-get install -y \
	wget

WORKDIR /tmp

RUN wget https://archive.apache.org/dist/hadoop/common/hadoop-3.1.1/hadoop-3.1.1.tar.gz
RUN tar xvfz hadoop-3.1.1.tar.gz
RUN mv hadoop-3.1.1 /usr/local/hadoop
RUN rm hadoop-3.1.1.tar.gz

RUN wget https://ftp.cixug.es/apache/hive/hive-3.1.2/apache-hive-3.1.2-bin.tar.gz
RUN tar xvfz apache-hive-3.1.2-bin.tar.gz
RUN mv apache-hive-3.1.2-bin /usr/local/hive
RUN rm apache-hive-3.1.2-bin.tar.gz

ENV HADOOP_HOME=/usr/local/hadoop
ENV HIVE_HOME=/usr/local/hive

ENV HADOOP_INSTALL=$HADOOP_HOME
ENV HADOOP_MAPRED_HOME=$HADOOP_HOME
ENV HADOOP_COMMON_HOME=$HADOOP_HOME
ENV HADOOP_HDFS_HOME=$HADOOP_HOME
ENV YARN_HOME=$HADOOP_HOME
ENV HADOOP_OPTS="-Djava.library.path=$HADOOP_HOME/lib/native"
ENV HADOOP_COMMON_LIB_NATIVE_DIR=$HADOOP_HOME/lib/native

ENV PATH=$PATH:$HADOOP_HOME/sbin:$HADOOP_HOME/bin

RUN mkdir -p /usr/jdk64
WORKDIR /usr/jdk64
RUN wget http://public-repo-1.hortonworks.com/ARTIFACTS/jdk-8u112-linux-x64.tar.gz
RUN gunzip jdk-8u112-linux-x64.tar.gz
RUN tar -xf jdk-8u112-linux-x64.tar

RUN update-alternatives --install /usr/bin/java java /usr/jdk64/jdk1.8.0_112/bin/java 1
RUN ln -s -f /usr/jdk64/jdk1.8.0_112/bin/java /usr/bin/java

ENV JAVA_HOME=/usr/jdk64/jdk1.8.0_112

ENV HADOOP_CONF_DIR /usr/local/hadoop-cluster-conf
RUN mkdir -p $HADOOP_CONF_DIR
RUN chmod -R 775 $HADOOP_CONF_DIR

RUN apt-get -qq update && \
    apt-get -yqq install krb5-user libpam-krb5 && \
    apt-get -yqq clean

ENTRYPOINT ["/bin/bash"]