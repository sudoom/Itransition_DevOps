FROM ubuntu:trusty
RUN apt-get update && apt-get upgrade -y
RUN apt-get install apache2 ntp default-jdk -y
WORKDIR /var/www/site
CMD /usr/sbin/apache2ctl -D FOREGROUND
EXPOSE 80