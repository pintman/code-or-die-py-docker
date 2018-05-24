# Docker build for code or die - python version

This docker build relies on the
[fork of code-or-die by Julian Zucker](https://github.com/julian-zucker/code-or-die.git).

## Installation

Run ``docker-compose up -d`` to build and run the container 
afterwards. Port 80 will be exposed on the docker host.

## Sample session

By default there a four teams named 'one', 'two', 'three' and 'four'. Get instructions
by requesting the root.

    $ curl localhost/

The default API-Key for each team is the same as the team name and must be sent in 
the header field 'api-key' for each request.

    $ curl -H 'api-key: one' localhost/systems
    [8]
    $ curl -H 'api-key: one' localhost/systems/8
    {"armies":{},"controller":"one","id":8,"names":[],"owner-information":{"tuning-parameters":[],"tuning_destinations":[]},"production":1,"routes":[{"destination":7,"distance":33},{"destination":9,"distance":20},{"destination":26,"distance":22},{"destination":98,"distance":10}]}

Player one controls one system with the number 8. Now let's change the default
api key.

    $ curl -H 'api-key: one' -X POST -d '{"new-api-key":"123456"}' localhost/set-api-key    
    true    
    $ curl -H 'api-key: one' localhost/systems    
    null    
    $ curl -H 'api-key: 123456' localhost/systems
    [8]
