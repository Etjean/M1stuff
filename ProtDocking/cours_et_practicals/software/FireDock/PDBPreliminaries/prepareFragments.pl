#!/usr/bin/perl -w

if ($#ARGV != 0)
{
  print "prepareFragments.pl fragmentsFile\n" ;
  exit ;
}

use FindBin;
my $home="$FindBin::Bin";


open FRAG_FILE, $ARGV[0] or die "can't open $ARGV[0] $!";
my @lines=<FRAG_FILE>;
close FRAG_FILE;

open FRAG_FILE, ">$ARGV[0]";
foreach(@lines)
{

	@line = split("<value>", $_);

	if ($#line < 1) 
	{	
		print FRAG_FILE $_;
		next;
	}

	@line_post = split(":/", $line[1]);
	if ($#line_post < 1)
	{
		print FRAG_FILE $_;
		next;
	}
	@splitted_path = split("/", $line_post[0]);
	$new_path = $home."/fragments/".$splitted_path[$#splitted_path];
	$new_line = $line[0]."<value>".$new_path.":/".$line_post[1];
	print FRAG_FILE $new_line;


}

close (FRAG_FILE);
