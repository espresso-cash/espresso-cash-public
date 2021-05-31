FROM debian:latest

RUN apt-get update
RUN apt-get install bzip2 curl -y

WORKDIR /root

RUN curl "https://release.solana.com/v1.6.10/install" > installer.sh
RUN sh installer.sh
RUN rm installer.sh
ENV PATH="/root/.local/share/solana/install/active_release/bin:${PATH}"

ENTRYPOINT ["solana-test-validator", "-r"]
