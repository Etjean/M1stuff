#!/usr/bin/perl -w

use strict;
use FindBin;

if ($#ARGV != 2 and $#ARGV !=3) {
  print "transOutput.pl <output file name> <first result> [last result] [only ligand flag]\n";
  exit;
}

my @flexMolecule;
my $rigidMolecule = "";

my $resFileName = $ARGV[0];
my $first = $ARGV[1];
my $last = $first;

if ($#ARGV > 1) {
  $last = $ARGV[2];
}

open(DATA, $resFileName);

my $home="$FindBin::Bin";

my $line;
while($line = <DATA>) {
  chomp $line;
  my @tmp=split(' ',$line);
  if($#tmp>0) {
    # find the filenames
    if($tmp[0] =~ /flexMolecule$/) {
      @flexMolecule = @tmp[2..$#tmp];
      print "Flexible Molecule: @flexMolecule \n";
    }
    if($tmp[0] =~ /rigidMolecule$/) {
      $rigidMolecule = $tmp[2];
      print "Rigid Molecule: $rigidMolecule\n";
    }

    # find result
    if($tmp[0] eq "Res" and $tmp[1] <= $last and $tmp[1] >= $first and $#flexMolecule > 0) {
      print "$line\n";
      my $currResFile = "$resFileName.$tmp[1].pdb";
      unlink $currResFile;
      if ($#ARGV < 3) { #add rigid molecule too
 	`cat $rigidMolecule > $currResFile`;
      }
      for (my $i = 0; $i <= $#flexMolecule; ++$i) {
	my $transLine = <DATA>;
	chomp $transLine;
	my @trans = split('\|',$transLine);
	print "$home/pdb_trans $trans[-1] < $flexMolecule[$i] >> $currResFile\n";
	`$home/pdb_trans $trans[-1] < $flexMolecule[$i] >> $currResFile`;
      }
    }
  }
}
