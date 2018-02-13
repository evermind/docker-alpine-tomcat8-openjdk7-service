This is a base image for services running tomcat on jdk8 which consists of:

* image based on library/tomcat:8-jre8-alpine
* DNS ttl settings for java to have TTL of 1s for dns based service discovery
* python, curl, bash and shadow packages added
* The script /usr/local/bin/update_config.py to update config files with content from environment variables
  (see https://gist.github.com/micw/d7c0e34aee751e81c5aa952b29b8631b)
* Removed all default webapps
* Added "tomcat" user, fix permissions and modified the default command to run tomcat as "tomcat" user

The image is auto-built by docker hub (https://hub.docker.com/r/micwy/docker-alpine-tomcat8-openjdk8-service)
* if the github repository changes
* if the base image changes
