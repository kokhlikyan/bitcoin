FROM ubuntu:22.04

WORKDIR app

COPY . /app


RUN apt update && \
    apt install -y autoconf && \
    apt install -y kmod && \
    apt install -y pkg-config && \
    apt install -y libboost-all-dev && \
    apt install -y bsdmainutils && \
    apt install -y build-essential && \
    apt install -y libsqlite3-dev

RUN chmod +x entrypoint.sh

RUN ./autogen.sh
RUN ./configure CXXFLAGS="--param ggc-min-expand=1 --param ggc-min-heapsize=32768"
RUN make

EXPOSE 8332 8333 18332 18333 18443 18444 18445 18446 38333 38332

CMD ./entrypoint.sh