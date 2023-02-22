FROM debian:bullseye

RUN apt-get update && apt-get install -y \ 
    make binutils build-essential diffutils gcc g++ patch bzip2 cpio unzip rsync file bc findutils \
    wget git libncurses-dev \
    python

COPY . /buildroot
