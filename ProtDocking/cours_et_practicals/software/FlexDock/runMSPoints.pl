#!/usr/bin/perl -w

use strict;
use FindBin;

if ($#ARGV != 2 && $#ARGV != 1 && $#ARGV != 0) {
  print "Usage: runMSPoints.pl <pdb file name> [density (default-10.0)] [probe radius (default-1.8)]\n";
  exit;
}

my $pdb = $ARGV[0];
my $density = 10.0;
my $radius = 1.8;

if($#ARGV > 0) {
  $density = $ARGV[1];
  if($#ARGV > 1) {
    $radius = $ARGV[2];
  }
}

my $home = "$FindBin::Bin";

unlink "BEFORE", "CONTACT", "REENTRANT";

system("$home/msdots $pdb $home/vdw.lib out $density $radius");

open MS, ">$pdb.ms";
my $number=0;
foreach my $file ('CONTACT','REENTRANT') {
  open FILE, $file;
  while (<FILE>) {
    my $atom1 = substr($_,0,5);
    my $atom2 = substr($_,5,5);
    my $atom3 = substr($_,10,5);
    my $num = substr($_,15,2);
    my $px = substr($_,17,9);
    my $py = substr($_,26,9);
    my $pz = substr($_,35,9);
    my $sarea = substr($_,44,7);
    my $nx = substr($_,51,7);
    my $ny = substr($_,58,7);
    my $nz = substr($_,65,7);
    my $curv = substr($_,72,2);
    printf MS "%5d%5d%5d", $atom1, $atom2, $atom3;
    printf MS "%8.3f%8.3f%8.3f", $px, $py, $pz;
    printf MS "%8.3f", $sarea;
    printf MS "%7.3f%7.3f%7.3f", $nx, $ny, $nz;
    printf MS "%7.3f\n", 0.5;
    $number++;
  }
  close FILE;
}
close MS;

print "Surface Points number: $number\n";
unlink "BEFORE", "CONTACT", "REENTRANT";


