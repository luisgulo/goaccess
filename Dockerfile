FROM debian:bullseye
# GoAccess (Estadisticas WEB) SoloConLinux
RUN apt-get -y update; apt-get -y upgrade
RUN apt-get -y install wget apt-transport-https gpg lsb-release
# Instalando goAccess desde fuentes Oficiales
RUN wget -O - https://deb.goaccess.io/gnugpg.key | gpg --dearmor | tee /usr/share/keyrings/goaccess.gpg >/dev/null
RUN echo "deb [signed-by=/usr/share/keyrings/goaccess.gpg] https://deb.goaccess.io/ $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/goaccess.list
RUN apt-get -y update
RUN apt-get -y install goaccess mmdb-bin
# Ajustar TimeZone
RUN ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime 
RUN dpkg-reconfigure -f noninteractive tzdata
# Ajustando Configuracion goAccess para procesar LOG
COPY src/goaccess.conf /etc/goaccess/goaccess.conf
