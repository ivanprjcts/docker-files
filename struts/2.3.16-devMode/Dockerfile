FROM ivanprjcts/struts:2.3.16

RUN unzip -n $CATALINA_HOME/webapps/ROOT.war -d $CATALINA_HOME/webapps/ROOT && rm $CATALINA_HOME/webapps/ROOT.war
COPY struts.xml $CATALINA_HOME/webapps/ROOT/WEB-INF/classes/struts.xml
EXPOSE 8080
