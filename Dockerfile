FROM nginx:stable

COPY nginx.conf /etc/nginx/nginx.conf

RUN touch /var/run/nginx.pid && \
  chown -R www-data:www-data /var/run/nginx.pid && \
  chown -R www-data:www-data /var/cache/nginx

RUN mkdir -p /opt/repository/

COPY models/AFU /opt/repository/AFU
COPY models/AGI /opt/repository/AGI
COPY models/ALW /opt/repository/ALW
COPY models/AMB /opt/repository/AMB
COPY models/ARP /opt/repository/ARP 
COPY models/AWJF /opt/repository/AWJF
COPY models/Gemeinden /opt/repository/Gemeinden

COPY ilisite.xml /opt/repository/
COPY ilimodels.xml /opt/repository/

COPY version.txt /opt/repository/

USER www-data
