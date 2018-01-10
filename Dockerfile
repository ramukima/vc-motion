FROM debian

RUN apt-get update \
        && apt-get install -y --force-yes --no-install-recommends \
                motion sudo procps curl jq \
        && apt-get autoclean \
        && apt-get autoremove \
        && rm -rf /var/lib/apt/lists/*

ADD startup.sh /

VOLUME ["/config", "/home/nobody/motioneye"]
VOLUME ["/scripts", "/home/nobody/motioneye/scripts"]

WORKDIR /home/nobody/motioneye

RUN usermod -g users nobody

EXPOSE 8081

RUN chmod +x /startup.sh
ENTRYPOINT ["/startup.sh"]
