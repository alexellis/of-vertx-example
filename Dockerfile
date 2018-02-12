FROM openjdk:8-alpine AS builder
RUN apk --no-cache add curl \
    && echo "Pulling watchdog binary from Github." \
    && curl -sSLf https://github.com/openfaas-incubator/of-watchdog/releases/download/0.2.1/of-watchdog > /usr/bin/fwatchdog \
    && chmod +x /usr/bin/fwatchdog

RUN curl -sL https://bintray.com/artifact/download/vertx/downloads/vert.x-3.5.0.tar.gz >  vert.x-3.5.0.tar.gz \
 && tar -xvf vert.x-3.5.0.tar.gz

COPY . .

RUN javac -cp ".:./vertx/lib/vertx-core-3.5.0.jar" Server.java

ENV mode="http"
ENV upstream_url="http://127.0.0.1:8081"
ENV fprocess="./start.sh"
RUN chmod +x ./start.sh

CMD ["fwatchdog"]