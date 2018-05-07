FROM library/tomcat:8-jre7-alpine

ADD start_tomcat.sh /start_tomcat.sh

RUN \
  apk --no-cache --update add bash python curl && \
  curl -s https://gist.githubusercontent.com/micw/d7c0e34aee751e81c5aa952b29b8631b/raw/8d67835c09ed2d32a61a05b5e4f0e2451fd2f0d4/update_config.py
    > /usr/local/bin/update_config.py && \
  chmod 0755 /usr/local/bin/update_config.py && \
  sed -i -r 's/^#?networkaddress.cache.ttl=.*/networkaddress.cache.ttl=1/'  /usr/lib/jvm/java-1.7-openjdk/jre/lib/security/java.security && \
  sed -i -r 's/^#?networkaddress.cache.negative.ttl=.*/networkaddress.cache.negative.ttl=1/'  /usr/lib/jvm/java-1.7-openjdk/jre/lib/security/java.security && \
  rm -rf /usr/local/tomcat/webapps/* && \
  adduser tomcat -h /usr/local/tomcat -D && \
  chmod a+rX /usr/local/tomcat -R && \
  chown tomcat /usr/local/tomcat/logs /usr/local/tomcat/conf /usr/local/tomcat/work /usr/local/tomcat/temp -R && \
  chmod 0755 /start_tomcat.sh

CMD "/start_tomcat.sh"
