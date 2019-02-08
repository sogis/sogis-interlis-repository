FROM nginx

COPY nginx.conf /etc/nginx/nginx.conf

RUN mkdir -p /opt/repository/

COPY models/ADA /opt/repository/ADA
COPY models/AFU /opt/repository/AFU
COPY models/AGI /opt/repository/AGI
COPY models/ALW /opt/repository/ALW
COPY models/AMB /opt/repository/AMB
COPY models/ARP /opt/repository/ARP 
COPY models/AVT /opt/repository/AVT
COPY models/AWA /opt/repository/AWA
COPY models/AWJF /opt/repository/AWJF
COPY models/Gemeinden /opt/repository/Gemeinden

COPY ilisite.xml /opt/repository/
COPY ilimodels.xml /opt/repository/

COPY version.txt /opt/repository/