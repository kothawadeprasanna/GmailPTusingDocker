FROM justb4/jmeter

MAINTAINER satummal

COPY jmeter-plugins-tst-2.5.jar /opt/apache-jmeter-5.3/lib/ext
COPY GmailAPI.jmx /opt/apache-jmeter-5.3
COPY userId.csv /opt/apache-jmeter-5.3