#!/usr/bin/perl -w

if ($#ARGV != 0)
{
  print "runFireDock.pl <paramsFile>\n" ;  
  exit ;
}

use FindBin;
my $home="$FindBin::Bin";

my $paramsFile = $ARGV[0];

 use Cwd;
$workingDir = getcwd;

  `cp $home/lib/exclusions $workingDir/.`;
  
  print ("$home/FireDock $paramsFile\n");
  system ("$home/FireDock $paramsFile");
  
