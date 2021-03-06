FROM ubuntu:wily
MAINTAINER Justin Rupp <jrupp@globalgiving.org>
 
COPY ./install.sh /tmp/install.sh
RUN /tmp/install.sh

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
	&& ln -sf /dev/stderr /var/log/nginx/error.log

COPY GeoIP.conf /etc/
RUN mkdir /usr/share/GeoIP && geoipupdate

EXPOSE 80 443

CMD ["nginx", "-g", "daemon off;"]
