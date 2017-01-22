#!/usr/bin/perl
use File::Copy;
$dirname="/usr/local/apache2/htdocs/myhohoho_images/$ARGV[0]";
chdir($dirname);
#`rm -f resultkub.jpg`;
#`rm -f kub*jpg`;
print "dirname: $dirname\n";
opendir(DIR, $dirname) or die "can't opendir $dirname: $!";
$count=0;
while (defined($file = readdir(DIR))) {
    if($file=~/jpg/ || $file=~/JPG/ || $file=~/jpeg/ || $file=~/JPEG/ || $file=~/png/ || $file=~/PNG/){
    #do something with "$dirname/$file
    $count++;
    if($count<=6){
        $target_name="kub$count.jpg";
         print "$count target_name:$target_name file:$file<br>\n";
        rename($file,$target_name);
    }
   else{
        print "unlinking $file<br>\n";
        unlink $file;
   } 
  print "###########################################\n";
   }
}
closedir(DIR);
if($count==0){
print "only .jpg images can be processed please retry<br>\n";
exit;
}
for($i=$count+1;$i<7;$i++){
   print "rename routine i:$i<br>\n";
   $target_name="kub$i.jpg";
   print "target_name:$target_name<br>\n";
   copy("kub1.jpg" , $target_name) or die "Copy failed: $!<br>\n";
}
$count=0;

opendir(DIR, $dirname) or die "can't opendir $dirname: $!";
while (defined($file = readdir(DIR))) {
    if($file=~/jpg/){
    #do something with "$dirname/$file
    $count++;
    $to_parse=`identify $file`;
    print "to_parse::$to_parse\n";
    @words = split /\s+/, $to_parse;
    #print "resolution:$words[0]\n";
    #print "resolution:$words[1]\n";
    #print "resolution:$words[2]\n";
    @res=  split /x/, $words[2];
    print "x-res:$res[0]\n";
    print "y-res:$res[1]\n";
    $xres=$res[0];
    $yres=$res[1];
    if($xres>=$yres){
       #landscape or square
       $offset= int(($xres-$yres)/2);
       print "format: landscape or square offset:$offset\n";
       #$img_name="kub$count.jpg";
       #print "img_name:$img_name<br>\n";
       #$cmd="convert $file -crop $yres"."x"."$yres+"."$offset"."+0 +repage %img_name";
       #print "cmd:$cmd\n";
       #`convert $img_name -resize 500x500  $img_name`;
       $cmd="convert $file -crop $yres"."x"."$yres+"."$offset"."+0 +repage kub$count.jpg";
       }
    else{
       $offset=int(($yres-$xres)/2);
       print "format: portrait offset:$offset\n";
       $cmd="convert $file -crop $xres"."x"."$xres+0+".$offset." +repage kub$count.jpg";
       print "cmd:$cmd\n";
    }
   $res=`$cmd`;
   print "res:$res\n";
   print "###########################################\n";
   }
}
closedir(DIR);


`convert kub1.jpg -resize 500x500  rekub1.jpg`;
`convert kub2.jpg -resize 500x500  rekub2.jpg`;
`convert kub3.jpg -resize 500x500  rekub3.jpg`;
`convert kub4.jpg -resize 500x500  rekub4.jpg`;
`convert kub5.jpg -resize 500x500  rekub5.jpg`;
`convert kub6.jpg -resize 500x500  rekub6.jpg`;
$cmd="convert -size 2180x1580 xc:#87CEFA -fill lightblue -stroke black ".
      "  -draw \"image over 40,540   0,0 'rekub1.jpg'\" ".
      "  -draw \"image over 540,540  0,0 'rekub2.jpg'\" ".
      "  -draw \"image over 1040,540 0,0 'rekub3.jpg'\" ".
      "  -draw \"image over 1540,540 0,0 'rekub4.jpg'\" ".
      "  -draw \"image over 540,40   0,0 'rekub5.jpg'\" ".
      "  -draw \"image over 540,1040 0,0 'rekub6.jpg'\" ".
      "  -draw \"line 0,40 2410,40\"  ".
      "  -draw \"line 0,540 2410,540\"  ".
      "  -draw \"line 0,1040 2410,1040\" ".
      "  -draw \"line 0,1540 2410,1540\" ".
      "  -draw \"line 41,0      41,1650\" ".
      "  -draw \"line 540,0    540,1650\" ".
      "  -draw \"line 1040,0  1040,1650\" ".
      "  -draw \"line 1540,0  1540,1650\" ".
      "  -draw \"line 2040,0  2040,1650\" ".
      "  -draw \"polyline 40,540  140,440 440,440  540,540\" ".
      "  -draw \"polyline 1040,540  1140,440 1440,440  1540,540\" ".
      "  -draw \"polyline 1540,540  1640,440 1940,440  2040,540\" ".
      "  -draw \"polyline 2040,540  2140,640 2140,940  2040,1040\" ".
      "  -draw \"polyline 40,1040  140,1140 440,1140  540,1040\" ".
      "  -draw \"polyline 1040,1040  1140,1140 1400,1140  1540,1040\" ".
      "  -draw \"polyline 1540,1040  1640,1140 1940,1140  2040,1040\"  resultkub.jpg";
$res=`$cmd`;
$cmd="convert -rotate 90 resultkub.jpg  new.jpg";
$res=`$cmd`;
$cmd="convert -page A4 new.jpg  myhohoho.pdf";
$res=`$cmd`;
unlink("new.jpg");




