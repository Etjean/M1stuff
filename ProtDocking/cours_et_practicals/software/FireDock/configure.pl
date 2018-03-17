#!/usr/bin/perl -w




open CONF_FILE, "configuration.txt" or die "can't read from configuration.txt $!";
@lines = <CONF_FILE>;
$oldPath = $lines[0];
chop($oldPath);
#print "$oldPath";
close (CONF_FILE);


use Cwd;
my $curr_dir = getcwd;
$curr_dir = $curr_dir."\/";

open CONF_FILE, ">configuration.txt" or die "can't write to configuration.txt $!";
print CONF_FILE $curr_dir;
close (CONF_FILE);

#print "$oldPath\n";

#$oldPath =~ s/\//\\\//g;
#$curr_dir =~ s/\//\\\//g;

#print "$oldPath\n";

print "sed -e 's/$oldPath/$curr_dir/g' bin/*.pl lib/fragments/Fragments.db";

`sed -e 's/$oldPath/$curr_dir/g' bin/*.pl lib/fragments/Fragments.db`;



    
use strict;
use FindBin;

my $home = "$FindBin::Bin";

if ($#ARGV<0) {
  print "Usage: buildMS.pl <pdb1> <pdb2> ...\n";
  exit;
}

for(my $i=0; $i<=$#ARGV; $i++) {
  my $file = $ARGV[$i];
  if(-e $file) {
    `$home/runMSPoints.pl $file`;
  } else {
    print "File not found $file\n";
  }
}
