FROM maven:3.5.0-jdk-8

ENV stanbol_version 1.0.0

# Install some additional packages.
RUN export DEBIAN_FRONTEND=noninteractive && \
  apt-get update && \
  apt-get -y install supervisor && \
  apt-get clean && \
  rm -rf /var/lib/apt/lists/*

# Defaults from https://stanbol.apache.org/docs/trunk/tutorial.html
ENV JAVA_OPTS="-Xmx1g -XX:MaxPermSize=256m"

# Download Stanbol.
RUN mkdir -p /opt && \
  wget -nv --output-document=/opt/stanbol-launcher.tar.gz http://ftp.cixug.es/apache/stanbol/apache-stanbol-1.0.0-source-release.tar.gz && cd /opt/ && \
  tar -xzvf stanbol-launcher.tar.gz && \
  cd /opt/apache-stanbol-$stanbol_version/ && \
  mvn clean install && \
  cp /opt/apache-stanbol-$stanbol_version/launchers/full/target/org.apache.stanbol.launchers.full-$stanbol_version.jar /opt/full-stanbol-launcher.jar && \
  rm -rf /opt/apache-stanbol-$stanbol_version/ && \
  rm -rf /opt/stanbol-launcher.tar.gz

# mvn clean install => 13:37 min
# mvn clean compile jar:jar => 05:11 min [No funciona como debe]


# Create directory for log files.
RUN mkdir -p /var/log/supervisord

# Add supervisord.conf.
ADD supervisord.conf /etc/supervisor/conf.d/supervisord.conf

EXPOSE 8080

VOLUME ["/var/log/supervisord"]

CMD ["/usr/bin/supervisord"]
