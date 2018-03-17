#!/usr/bin/perl

if ($#ARGV != 0) {
  print "ZDOCKOut2Trans.pl <ZDOCK 2.3 Output File>\n";
  exit;
}

use FindBin;
my $home = "$FindBin::Bin";


$spacing=1.2;
open (FDOCK, "<$ARGV[0]") || die "\nCannot open file $ARGV[0]!\n\n";
@line = <FDOCK>;
chomp(@line);
($n, $spacing)=split(" ", $line[0]);
($rand1, $rand2, $rand3)=split(" ", $line[1]);
($rec, $r1, $r2, $r3) = split (" ", $line[2]);
($lig, $l1, $l2, $l3) = split (" ", $line[3]);
close FDOCK;

# print "0 0 0 0 0 0 0\n";

for ($i = 4; $i < @line; $i++){
    ($angl_x, $angl_y, $angl_z, $tran_x, $tran_y, $tran_z, $score)
       = split ( " ", $line[$i] );
    $number = $i-3;

print "$number ";
system "$home/ZDOCKOut2Trans $lig.$number $lig $rand1 $rand2 $rand3 $r1 $r2 $r3 $l1 $l2 $l3 $angl_x $angl_y $angl_z $tran_x $tran_y $tran_z $n $spacing\n";
    
}
