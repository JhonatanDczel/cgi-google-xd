FROM ubuntu:20.04

# Establecer zona horaria a UTC para evitar interacción manual
ENV DEBIAN_FRONTEND=noninteractive
RUN ln -fs /usr/share/zoneinfo/Etc/UTC /etc/localtime && \
    apt-get update && \
    apt-get install -y tzdata && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Instalar Apache, Perl y otros paquetes
RUN apt-get install -y \
    apache2 \
    libapache2-mod-perl2 \
    perl \
    curl \
    vim && \
    apt-get clean

# Instalar módulos de Perl necesarios
RUN apt-get update && \
    apt-get install -y libcgi-pm-perl && \
    cpan URI::Escape && \
    apt-get clean

# Activar módulos CGI y Perl en Apache
RUN a2enmod cgi
RUN a2enmod perl

# Copiar los archivos del proyecto al directorio adecuado
COPY ./html /var/www/html
COPY ./cgi-bin /usr/lib/cgi-bin

# Darle permisos para que ejecute
RUN chmod +x /usr/lib/cgi-bin/*.pl

# Arreglar el error de Windows
RUN sed -i 's/\r$//' /usr/lib/cgi-bin/*.pl

RUN echo "<Directory /usr/lib/cgi-bin>\n\
    AllowOverride None\n\
    Options +ExecCGI\n\
    AddHandler cgi-script .pl\n\
    Require all granted\n\
</Directory>" >> /etc/apache2/apache2.conf && apachectl restart

# Exponer el puerto 80 (puerto de Apache)
EXPOSE 80

# Iniciar Apache en el contenedor
CMD ["apachectl", "-D", "FOREGROUND"]
