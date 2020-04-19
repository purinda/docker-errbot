FROM python:3.6-alpine

MAINTAINER Purinda Gunasekara <purinda@gmail.com>

ENV PATH /app/venv/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

# Set default locale for the environment
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

# Install packages and perform cleanup
RUN apk add --no-cache \
    linux-headers \
    libc-dev \
    libffi-dev \
    libssh-dev \
    bash \
    gcc

RUN pip3 install --upgrade pip
RUN pip3 install virtualenv

RUN mkdir /app

RUN virtualenv --python `which python3` /app/venv
RUN source /app/venv/bin/activate;
RUN pip3 install errbot
RUN pip3 install errbot[slack]

COPY config.py /app/config.py
COPY run.sh /app/venv/bin/run.sh

RUN mkdir /srv/data /srv/plugins /srv/errbackends

EXPOSE 3141 3142
VOLUME ["/srv"]

RUN /app/venv/bin/errbot --init

ENTRYPOINT ["/app/venv/bin/run.sh"]
CMD ["bash"]
