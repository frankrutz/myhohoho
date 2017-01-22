#!/usr/bin/perl
  use strict;
  use warnings;
  use CGI;
  my $CGIo = new CGI;
  print $CGIo->header();
  #print "howdi<br>\n";
  my $base_dir="/usr/local/apache2/htdocs/myhohoho_images/";
  my $user_dir_seed=int(rand(99999999999));
  my $user_dir="$base_dir"."$user_dir_seed"."/";
  mkdir ($user_dir, 0755);
  #print "$base_dir<br>\n";
  #print "$user_dir_seed<br>\n";
  #print "$user_dir<br>\n";
  my @lightweight_fh = $CGIo->upload('multiple_files');
  my $count_image=1;
  foreach my $fh (@lightweight_fh) {
    # undef may be returned if it's not a valid file handle
    if (defined $fh) {
      # Upgrade the handle to one compatible with IO::Handle:
      my $io_handle = $fh->handle;
      open (OUTFILE,'>>',$user_dir . $fh);
      while (my $bytesread = $io_handle->read(my $buffer,1024)) {
        print OUTFILE $buffer
      }
    }
  }
my $cmd="/usr/local/apache2/cgi-bin/do.pl $user_dir_seed > /dev/null 2>&1\n";
#print "$cmd<br>\n";
system($cmd);
#print "ready<br>\n";
print <<END_HTML;
<head>
<style>
body {
    background-image: url("/myhohoho_bg_tiles.jpg");
    background-repeat: repeat;
}
table{
margin: 0 auto;
position: absolute;
top: 50%;
left: 50%;
transform: translateX(-50%) translateY(-50%);
background-color: #87CEFA;
}
</style>
</head>
<body>
<p/><p/>
<table>
<tr><td><img src="/bg_table.jpg"/></td></tr>
<tr><td><center>upload 1-6 images, get one hohoho-cube</center></td></tr>
<tr><td>
<center>
<form  action="/cgi-bin/test_multiple.pl" method="post" enctype="multipart/form-data">
<input type="file" name="multiple_files" multiple="true"/>
<input type="submit" name="Submit" value="make it" />
</form>
</center>
</td></tr>
<tr><td><img width="370" src="/myhohoho_images/$user_dir_seed/resultkub.jpg" alt="Photo" /></td></tr>
<tr><td><center><a href="/myhohoho_images/$user_dir_seed/myhohoho.pdf">download A4-pdf for printing</a></center></td></tr>
</table>
</body>
</html>
END_HTML
