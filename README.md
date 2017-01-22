# myhohoho

- Purpose:
upload minimum 1 to maximum 6 picutres, and get back a .pdf for building a "myhohoho" christmas cube to put on your christmas tree.

- Tools needed:
paper glue + scissor

- Time needed for one cube:
Approx. 3 minutes

- Tip
Good schoolclasses activity to give a present to the teacher: each pupil makes a personal cube.

- Programmed by
A container application constructed with primary school kids at Schule Fluntern in Zürich during November 2015.

- History
The web-app had more than 100'000 hits during December 2015, mainly from the US. It was run on Google Cloud Engine.
( remark: the .pdf - download format was not A4 in the US )

Main traffic was on 26th 27th December 2015.


# Warning do not use, under construction.

Docker application example :: crafting selfmade christmas cubes 

# Buildig the container

docker build -t myhohoho_apache_000011 .

To run the container with apache starting in daemon-mode:

docker run -p 80:80 -d myhohoho_apache_000011 apachectl -D FOREGROUND

Now, you will be able to access the app at

http://youipadress/


 
