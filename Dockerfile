FROM library/tomcat:8-jre7-alpine

ADD start_tomcat.sh /start_tomcat.sh

RUN \
  apk --no-cache --update add bash python curl && \
  curl -s https://gist.githubusercontent.com/micw/d7c0e34aee751e81c5aa952b29b8631b/raw/f04a1a36d4c02afc4df4d56d5554bea0ebf08508/update_config.py > /usr/local/bin/update_config.py && \
  chmod 0755 /usr/local/bin/update_config.py && \
  sed -i -r 's/^#?networkaddress.cache.ttl=.*/networkaddress.cache.ttl=1/'  /usr/lib/jvm/java-1.7-openjdk/jre/lib/security/java.security && \
  sed -i -r 's/^#?networkaddress.cache.negative.ttl=.*/networkaddress.cache.negative.ttl=1/'  /usr/lib/jvm/java-1.7-openjdk/jre/lib/security/java.security && \
  rm -rf /usr/local/tomcat/webapps/* && \
  adduser tomcat -h /usr/local/tomcat -D && \
  chmod a+rX /usr/local/tomcat -R && \
  chown tomcat /usr/local/tomcat/logs /usr/local/tomcat/conf /usr/local/tomcat/work -R && \
  chmod 0755 /start_tomcat.sh

CMD "/start_tomcat.sh"
