FROM ubuntu:16.04

RUN apt-get update && apt-get install -y python3 python3-pip \
	postgresql postgresql-client postgresql-server-dev-all

# install python 3.6 from a PPA
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:deadsnakes/ppa &&\
	apt-get update && \
	apt-get install -y python3.6 python3.6-dev

RUN python3.6 -m pip install flask pygresql networkx apscheduler

RUN apt-get install -y git

WORKDIR /
RUN git clone https://github.com/julian-zucker/code-or-die.git

WORKDIR /code-or-die
#COPY . .

# assuming file secrets.txt with table name, hostname, portnumber, 
# postgresuser, password (on per line)
COPY secrets.txt .

COPY docker-entrypoint.sh /

CMD "/docker-entrypoint.sh"
