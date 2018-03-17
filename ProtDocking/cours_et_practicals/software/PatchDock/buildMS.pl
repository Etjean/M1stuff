#!/usr/bin/perl -w

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


