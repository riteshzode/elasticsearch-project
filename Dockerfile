# Use Ubuntu as the base image
FROM ubuntu:20.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV ES_VERSION=8.16.0
ENV ES_HOME=/usr/share/elasticsearch

# Install required dependencies
RUN apt-get update && apt-get install -y wget gnupg openjdk-11-jdk && \
    groupadd -g 1000 elasticsearch && useradd -u 1000 -g elasticsearch -s /bin/bash -m elasticsearch && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$ES_VERSION-linux-x86_64.tar.gz && \
    wget https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-$ES_VERSION-linux-x86_64.tar.gz.sha512 && \
    sha512sum -c elasticsearch-$ES_VERSION-linux-x86_64.tar.gz.sha512 && \
    tar -xzf elasticsearch-$ES_VERSION-linux-x86_64.tar.gz && \
    mv elasticsearch-$ES_VERSION $ES_HOME && \
    chown -R elasticsearch:elasticsearch $ES_HOME && \
    rm elasticsearch-$ES_VERSION-linux-x86_64.tar.gz*

# Copy configuration files
COPY elasticsearch.yml /usr/share/elasticsearch/config/
COPY logging.yml /usr/share/elasticsearch/config/

# Create data directory and set permissions
RUN mkdir -p /usr/share/elasticsearch/data && \
    chown -R elasticsearch:elasticsearch /usr/share/elasticsearch/data

# Change to non-root user
USER elasticsearch

# Set the working directory
WORKDIR $ES_HOME

# Expose default Elasticsearch ports
EXPOSE 9200 9300

# Set environment variables
ENV PATH=$PATH:/usr/share/elasticsearch/bin

# Define the default command
CMD ["elasticsearch"]