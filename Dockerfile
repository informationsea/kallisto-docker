FROM debian:10-slim AS download-kallisto
RUN apt-get update && apt-get install -y curl bzip2 && rm -rf /var/lib/apt/lists/*
RUN curl -OL https://github.com/pachterlab/kallisto/releases/download/v0.46.1/kallisto_linux-v0.46.1.tar.gz
RUN tar xzf kallisto_linux-v0.46.1.tar.gz

FROM debian:10-slim
ENV PATH=/kallisto:${PATH}
COPY --from=download-kallisto /kallisto /kallisto
ADD run.sh /
ENTRYPOINT [ "/bin/bash", "/run.sh" ]