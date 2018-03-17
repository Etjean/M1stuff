#!/usr/bin/perl -w

if ($#ARGV != 1 && $#ARGV != 2)
{
  print "preparePDBs.pl rec lig [H/All]\n" ;
  print "All[Default] - formats PDB files and adds all missing atoms.\n" ;
  print "H - adds missing hydrogens only. If you use this option you should uncomment pdbConventionFile line in buildFireDockParams.pl\n" ;
  exit ;
}

use FindBin;
my $home="$FindBin::Bin";
my $rec = $ARGV[0];
my $lig = $ARGV[1];

my $recC = $rec.".C.pdb";
my $ligC = $lig.".C.pdb";

my $recCH = $rec.".CH.pdb";
my $ligCH = $lig.".CH.pdb";

my $recCHB = $rec.".CHB.pdb";
my $ligCHB = $lig.".CHB.pdb";
 

`cut -c 1-54 $rec > $recC`;
`cut -c 1-54 $lig > $ligC`;


system ("$home/PDBPreliminaries/reduce.2.21.030604 -OH -HIS -NOADJust -NOROTMET -DB '$home/PDBPreliminaries/reduce_het_dict.txt' $recC > $recCH");
system ("$home/PDBPreliminaries/reduce.2.21.030604 -OH -HIS -NOADJust -NOROTMET -DB '$home/PDBPreliminaries/reduce_het_dict.txt' $ligC > $ligCH");

if ($ARGV[2] =~ /H/)
{
  `rm -f $recC $ligC`;

}
else
{
  system ("$home/PDBPreliminaries/prepareFragments.pl $home/PDBPreliminaries/fragments/Fragments.db");
  system ("$home/PDBPreliminaries/PDBPreliminaries $recCH $recCHB $home/PDBPreliminaries/fragments/Fragments.db");
  system ("$home/PDBPreliminaries/PDBPreliminaries $ligCH $ligCHB $home/PDBPreliminaries/fragments/Fragments.db");
  `rm -f $recC $ligC $recCH $ligCH`;
}

    
