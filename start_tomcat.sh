#!/bin/sh

TOMCAT_USERNAME=tomcat
TOMCAT_CHOWN=tomcat

if [ ! -z "${TOMCAT_UID}" ]; then
  TOMCAT_USERNAME=tomcatuser
  if [ ! -z "${TOMCAT_GID}" ]; then
    addgroup tomcatgroup -g "${TOMCAT_GID}"
    adduser tomcatuser -u "${TOMCAT_UID}" -G tomcatgroup -s /bin/sh -h /usr/local/tomcat -D
    TOMCAT_CHOWN="tomcatuser.tomcatgroup"
  else
    adduser tomcatuser -u "${TOMCAT_UID}" -h /usr/local/tomcat -D
  fi
fi

chown ${TOMCAT_CHOWN} /usr/local/tomcat/logs /usr/local/tomcat/conf /usr/local/tomcat/work /usr/local/tomcat/temp -R

su ${TOMCAT_USERNAME} -c "/usr/local/tomcat/bin/catalina.sh run"
