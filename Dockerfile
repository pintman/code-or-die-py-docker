FROM ubuntu:16.04

RUN apt-get update && apt-get install -y python3-pip \
	postgresql postgresql-client postgresql-server-dev-all git

# install python 3.6 from a PPA
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa &&\
	apt-get update && \
	apt-get install -y python3.6 python3.6-dev

WORKDIR /
RUN git clone https://github.com/julian-zucker/code-or-die.git && \
	cd code-or-die && \
	git checkout 9fe363c616b4970362d557de1639fa767b82322c

WORKDIR /code-or-die

# Installing dependend packages
COPY requirements.txt .
RUN python3.6 -m pip install -r requirements.txt

# Patch utf8-encoded README
RUN apt-get install -y konwert && \
	konwert utf8-ascii README.md > README2.md && \
	mv README2.md README.md

# Adding some civilizations
RUN sed -e 's/("two", "two")/("two", "two"), ("three", "three"), ("four", "four")/' app.py > app2.py && \
	mv app2.py app.py


# assuming file secrets.txt with table name, hostname, portnumber, 
# postgresuser and password (on per line)
COPY secrets.txt .

COPY docker-entrypoint.sh /

CMD "/docker-entrypoint.sh"
