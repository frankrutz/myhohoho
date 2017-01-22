FROM httpd
MAINTAINER frank.rutz@outlook.com

RUN apt-get update
RUN apt-get install -y vim 
RUN apt-get install -y imagemagick
RUN apt-get clean
RUN mkdir /usr/local/apache2/htdocs/myhohoho_images
RUN chmod a+rw /usr/local/apache2/htdocs/myhohoho_images

COPY ./html/index.html /usr/local/apache2/htdocs/index.html
COPY ./html/myhohoho_bg_tiles.jpg /usr/local/apache2/htdocs
COPY ./html/bg_table.jpg /usr/local/apache2/htdocs
COPY ./html/test.html  /usr/local/apache2/htdocs
COPY ./cgi-bin/do.pl   /usr/local/apache2/cgi-bin/do.pl
COPY ./conf/httpd.conf /usr/local/apache2/conf/httpd.conf
COPY ./cgi-bin/upload.pl /usr/local/apache2/cgi-bin/upload.pl
COPY ./cgi-bin/test_multiple.pl /usr/local/apache2/cgi-bin/test_multiple.pl


RUN  chmod a+rx /usr/local/apache2/cgi-bin/upload.pl
RUN  chmod a+rx /usr/local/apache2/cgi-bin/do.pl
RUN  chmod a+rx /usr/local/apache2/cgi-bin/test_multiple.pl
