FROM nginx:mainline-alpine

COPY nginx.conf /etc/nginx/nginx.conf

RUN touch /var/run/nginx.pid && \
  chgrp -R 0 /var/run/nginx.pid && \
  chgrp -R 0 /var/cache/nginx && \
  chmod g=u /var/run/nginx.pid && \
  chmod -R g=u /var/cache/nginx

RUN mkdir -p /opt/repository/

COPY models/AFU /opt/repository/AFU
COPY models/AGEM /opt/repository/AGEM
COPY models/AGI /opt/repository/AGI
COPY models/ALW /opt/repository/ALW
COPY models/AMB /opt/repository/AMB
COPY models/ARP /opt/repository/ARP 
COPY models/AVT /opt/repository/AVT 
COPY models/AWJF /opt/repository/AWJF
COPY models/Gemeinden /opt/repository/Gemeinden
COPY models/SGV /opt/repository/SGV
COPY models/ADA /opt/repository/ADA
COPY models/KSTA /opt/repository/KSTA
COPY models/AWA /opt/repository/AWA
COPY models/AGS /opt/repository/AGS
COPY models/HBA /opt/repository/HBA

COPY ilisite.xml /opt/repository/
COPY ilimodels.xml /opt/repository/
COPY ilidata.xml /opt/repository/

COPY version.txt /opt/repository/

COPY ilismeta /opt/repository/ilismeta

COPY xsl/ilimodels.xsl /opt/repository
COPY xsl/ilimodels.css /opt/repository
COPY xsl/fonts.css /opt/repository
COPY xsl/Logo.png /opt/repository
COPY xsl/searchicon.png /opt/repository

USER 11200
