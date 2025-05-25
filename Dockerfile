FROM ubuntu:22.04

RUN apt-get update && \
    apt-get install -y \
    build-essential \
    libpcap-dev \
    openjdk-11-jdk \
    maven \
    git \
    tcpdump \
    autoconf \
    automake \
    libtool

# Build Oreka
RUN git clone https://github.com/voiceip/oreka.git && \
    cd oreka/orkaudio && \
    ./autogen.sh && \
    ./configure --with-java=/usr/lib/jvm/java-11-openjdk-amd64 && \
    make && \
    make install

EXPOSE 5060/udp 5060/tcp 8080/tcp
VOLUME ["/recordings"]

CMD ["orkaudio", "-c", "/etc/orkaudio/orkaudio.conf"]