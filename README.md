# myhohoho

A container application constructed with primary school kids at Schule Fluntern in Zürich during November 2015.

The web-app had more than 100'000 hits during December 2015, mainly from the US.
( remark: the .pdf - download format was not A4 in the US )


# Warning do not use, under construction.

Docker application example :: crafting selfmade christmas cubes 

# Buildig the container

docker build -t myhohoho_apache_000011 .

To run the container with apache starting in daemon-mode:

docker run -p 80:80 -d myhohoho_apache_000011 apachectl -D FOREGROUND

Now, you will be able to access the app at

http://youipadress/


 
