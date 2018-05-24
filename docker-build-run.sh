#/bin/sh

docker build -t cod . && docker run --rm -it -p 80:80 cod 
