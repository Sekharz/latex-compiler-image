FROM debian:stable-slim

# non interactive frontend for locales
ENV DEBIAN_FRONTEND=noninteractive

# installing texlive and utils
RUN apt-get update && \
    apt-get -y install --no-install-recommends \
                      pandoc \
                      texlive \
                      texlive-latex-extra \
                      texlive-extra-utils \
                      texlive-fonts-extra \
                      texlive-bibtex-extra \
                      biber \
                      latexmk \
                      build-essential\
                      git \
                      procps \
                      locales \
                      curl && \
    rm -rf /var/lib/apt/lists/* && \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    dpkg-reconfigure --frontend=noninteractive locales && \
    update-locale LANG=en_US.UTF-8 && \
    apt -y clean && \
    apt -y autoremove && \
    rm -rf /var/cache/apt

ENV LANGUAGE=en_US.UTF-8 LANG=en_US.UTF-8 LC_ALL=en_US.UTF-8

# installing cpanm & missing latexindent dependencies
RUN curl -L http://cpanmin.us | perl - --self-upgrade && \
    cpanm Log::Dispatch::File YAML::Tiny File::HomeDir