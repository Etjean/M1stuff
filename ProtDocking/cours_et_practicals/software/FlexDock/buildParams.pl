#!/usr/bin/perl -w

use strict;
use FindBin;

if ($#ARGV != 2 and $#ARGV != 3 and $#ARGV != 4 and $#ARGV != 5) {
  print "buildParams.pl <rigidMolPDB> <flexMolPDB> <HingeProt outFile> [rmsd default=4.0] [molTypes]\n";# [flexRefMolPDB]\n";
  print "The types are: EI:enzyme/inhibitor, drug:protein/drug, default\n" ;
  exit;
}

my $rigidMolecule = $ARGV[0];
my $flexMolecule = $ARGV[1];
my $hingeProtFile = $ARGV[2];
my $rmsd = 4.0;
if($#ARGV > 2) {
  $rmsd = $ARGV[3];
  if($rmsd <= 0.0 or $rmsd >= 10.0) {
    print "Invalid RMSD value, using default value!\n";
    $rmsd = 4.0;
  }
}

my $molType= "Default";
if($#ARGV > 3) {
  $molType = $ARGV[4];
  if($molType ne "EI" and $molType ne "AA" and $molType ne "drug") {
    print "Invalid molecules type, using default!\n";
    $molType= "Default";
  }
}

my $flexRefMol = "";
if($#ARGV > 4) { $flexRefMol = $ARGV[5]; }

my $home="$FindBin::Bin";
open OUT, ">flex-params.txt";

print OUT "########################################################################\n";
print OUT "#    FlexDock Parameter File for $rigidMolecule $flexMolecule";
print OUT "\n########################################################################\n";

print OUT "\n# Rigid Molecule PDB, Surface and binding sites (optional) file names\n";

print OUT "rigidMolecule $rigidMolecule\n";
print OUT "rigidMoleculeMs $rigidMolecule.ms\n";
print OUT "#put \"-\" if no site info is available\n";
print OUT "#rigidMoleculeSites site1.txt site2.txt\n";
#if(! -e "$rigidMolecule.ms") {
  print "$home/runMSPoints.pl $rigidMolecule\n";
  `$home/runMSPoints.pl $rigidMolecule >& /dev/null`;
#}

print OUT "\n# Flex Molecule PDB, Surface and binding sites (optional) file names\n";
# flexible molecule
my $molsString = "flexMolecule ";
my $msString = "flexMoleculeMs ";
my $directionsString = "movementDirections ";
my $hingeResiduesString = "hingeResidues ";
my $flexRefMolsString = "flexRefMolecule ";
my %hingeHash = ();

# findChainId
my $chainId = '-';
my @protChains=chainSelector($flexMolecule);
if($#protChains > 0) {
  print "#of chains in flexible molecule > 1\n";
  exit;
}
if($#protChains >=0) {
  $chainId = $protChains[0];
}

my $refChainId = '-';
if(length $flexRefMol > 0) {
  `cp $home/multiProtParams.txt params.txt`;
  open STAT, ">flex-data.txt";
  unlink "2_sol.res";
  unlink "log_multiprot.txt";
  `~ppdock/webserver/MultiProt/multiprot.Linux $flexRefMol $flexMolecule`;
  print "multiprot.Linux $flexRefMol $flexMolecule\n";
  my $statRes = computeStat($rigidMolecule, $flexMolecule, $flexRefMol);
  print STAT "$statRes";
  @protChains=chainSelector($flexRefMol);
  if($#protChains > 0) {
    print "#of chains in flexible ref. molecule > 1\n";
    exit;
  }
  if($#protChains >=0) {
    $refChainId = $protChains[0];
  }
}

#split to rigid parts according to HingeProt (mode 1)
open(DATA, $hingeProtFile) or die "Cannot open $hingeProtFile, $!";
while(<DATA>) {
  chomp;
  if( /-->/ ) {
    if( /2:/ ) { last; } # skip mode 2 and 12 output
  }
  if(/Hinge/) {
    my @hingeLine=split(' ', $_);
    for(my $i=2; $i <= $#hingeLine; $i++) {
      if(not ($chainId eq "-")) {
	my $residue = $hingeLine[$i];
	chop $residue;
	$hingeResiduesString .= "$residue ";
	$hingeHash{$residue}=$residue;
      } else {
	$hingeResiduesString .= "$hingeLine[$i] ";
	$hingeHash{$hingeLine[$i]}=$hingeLine[$i];
      }
    }
#    print "HASH:";
#    print values %hingeHash;
#    print "ENDHASH\n";
  }
  if(/Part/) {
    my @partLine=split(' ', $_);
    my $partNumber = $partLine[1];
    my @resLine = split(':', $partLine[2]);
    my $residues;
    if($#resLine > 0) {
      $residues = $resLine[1];
    } else {
      $residues = $resLine[0];
    }
    my @partResidues=split(',', $residues);
    unlink "part$partNumber.pdb";
    unlink "part$partNumber\_ref.pdb";
    for(my $i=0; $i <= $#partResidues; $i++) {
      my @currSeq = split('-', $partResidues[$i]);
      my $first = $currSeq[0];
      my $second = $currSeq[1];

      # remove first and last hinge residues
#      if (exists $hingeHash{$first} || exists $hingeHash{$first-1}) { $first++; }
#      if (exists $hingeHash{$second} || exists $hingeHash{$second+1}) { $second--; }

      print "get_frag_chain.Linux $flexMolecule $chainId $first $second >> part$partNumber.pdb\n";
      `$home/get_frag_chain.Linux $flexMolecule $chainId $first $second >> part$partNumber.pdb`;
      if(length $flexRefMol > 0) {
	print "get_frag_chain.Linux $flexRefMol $refChainId $first $second >> part$partNumber\_ref.pdb\n";
	`$home/get_frag_chain.Linux $flexRefMol $refChainId $first $second >> part$partNumber\_ref.pdb`;
       }
    }

    # align reference (bound) to input (unbound)
    if(length $flexRefMol > 0) {
      unlink "2_sol.res";
      unlink "log_multiprot.txt";
      `~ppdock/webserver/MultiProt/multiprot.Linux part$partNumber\_ref.pdb part$partNumber.pdb`;
      print "multiprot.Linux part$partNumber\_ref.pdb part$partNumber.pdb\n";
      my $statRes = computeStat($rigidMolecule, "part$partNumber.pdb", "part$partNumber\_ref.pdb");
      print STAT "$statRes";
      my $transLine = `grep Trans 2_sol.res | head -1`;
      my ($name, $trans) = split(':', $transLine);
      chomp $trans;
      print "$trans\n";
      `$home/pdb_trans $trans < part$partNumber.pdb > part$partNumber\_ref.pdb`;
      $flexRefMolsString .= "part$partNumber\_ref.pdb ";
    }
    $molsString .= "part$partNumber.pdb ";
    $msString .= "part$partNumber.pdb.ms ";
#    if(! -e "part$partNumber.pdb.ms") {
      print "$home/runMSPoints.pl part$partNumber.pdb\n";
      `$home/runMSPoints.pl part$partNumber.pdb >& /dev/null`;
#    }
    $directionsString .= "$partLine[4] ";
    $directionsString .= "$partLine[5] ";
    $directionsString .= "$partLine[6] ";
  }
}
close DATA;

print OUT "$molsString\n";
print OUT "$msString\n";
print OUT "$directionsString\n";
print OUT "$hingeResiduesString\n\n";

print OUT "#hingeThresholds <distance_thr> <direction_angle_thr - DEGREES> <centroid_distance_thr>\n";
print OUT "# centroid_distance_thr - distance that each part centroid is allowed to move\n";
my $hingeNum = keys( %hingeHash );
my $movementExtentThr = 40.0;
my $distanceThr = 16.0;
if($hingeNum == 2) { $movementExtentThr = 25.0; $distanceThr = 13.0; }
if($hingeNum == 3) { $movementExtentThr = 15.0; $distanceThr = 9.0; }
if($hingeNum == 4) { $movementExtentThr = 10.0; $distanceThr = 9.0; }
print OUT "hingeThresholds $distanceThr 45 $movementExtentThr\n\n";

print OUT "#flexMoleculeSites site1.txt site2.txt\n";
print OUT "$flexRefMolsString\n\n";

print OUT "max-res-num-for-enrichment 0\n";

print OUT "protLib $home/chem.lib\n";
print OUT "log-file flex_dock.log\n";
print OUT "log-level 2\n";

#segmentation params
print OUT "\n#    Surface Segmentation Parameters:\n";
print OUT "#       receptorSeg <low_patch_thr> <high_patch_thr> <prune_thr>\n";
print OUT "#                   <knob> <flat> <hole>\n";
print OUT "#                   <hot spot filter type>\n";
print OUT "#    <low_patch_thr>,<high_patch_thr> - min and max patch diameter\n";
print OUT "#    <prune_thr> - minimal distance between points inside the patch\n";
print OUT "#    <knob> <flat> <hole> - types of patches to dock (1-use, 0-do not use) (may need tuning)\n";
print OUT "#    <hot spot filter type> :None - 0, Antibody - 1, Antigen - 2\n";
print OUT "#                             Protease - 3, Inhibitor - 4, Drug - 5\n";
if($molType =~ /drug/) {
  print OUT "ligandSeg 10.0 20.0 0.5 0 1 1 5\n";
  print OUT "receptorSeg 5.0 15.0 0.1 1 1 1 5\n";
} else {
  if($molType eq "EI") {
    print OUT "receptorSeg 10.0 20.0 1.5 0 0 1 3\n";
    print OUT "ligandSeg 10.0 20.0 1.5 1 0 0 4\n";
  } else {
    if($molType eq "AA") {
      print OUT "receptorSeg 10.0 20.0 1.5 1 0 1 2\n";
      print OUT "ligandSeg 10.0 20.0 1.5 1 0 1 1\n";
    } else {
      my $rigidMolSize = countAtoms($rigidMolecule);
      if($rigidMolSize < 1000) {
	print OUT "receptorSeg 10.0 20.0 1.0 1 0 1 0\n";
      } else {
	print OUT "receptorSeg 10.0 20.0 1.5 1 0 1 0\n";
      }
      print OUT "ligandSeg 10.0 20.0 1.5 1 0 1 0\n";
    }
  }
}

#scoring params
print OUT "\n#    Scoring Parameters:\n";
print OUT "#        scoreParams <small_interfaces_ratio> <max_penetration> <ns_thr>\n";
print OUT "#                    <rec_as_thr> <lig_as_thr> <patch_res_num> <w1 w2 w3 w4 w5>\n";
print OUT "#    <small_interfaces_ratio> - the ratio of the low scoring transforms to be removed\n";
print OUT "#    <max_penetration> - maximal allowed penetration between molecules surfaces\n";
print OUT "#    <ns_thr> - normal score threshold\n";
print OUT "#    <rec_as_thr> <lig_as_thr> - the minimal ratio of the active site area in the solutions\n";
print OUT "#    <patch_res_num> - number of results to consider in each patch\n";
print OUT "#    <w1 w2 w3 w4 w5> - scoring weights for ranges:\n";
print OUT "#                [-5.0,-3.6],[-3.6,-2.2],[-2.2,-1.0],[-1.0,1.0],[1.0-up]\n";

SWITCH: {
  if ($molType eq "AA")
    { print OUT "scoreParams 0.3 -4.0 0.5 0.0 0.3 1500 -8 -4 0 1 0\n"; last SWITCH; }
  if ($molType eq "EI")
    { print OUT "scoreParams 0.4 -5.0 0.5 0.0 0.0 1500 -8 -4 0 1 0\n"; last SWITCH; }
  if ($molType eq "Default")
    { print OUT "scoreParams 0.3 -5.0 0.5 0.0 0.0 1500 -8 -4 0 1 0\n"; last SWITCH; }
  if ($molType =~ /drug/)
    { print OUT "scoreParams 0.3 -4.0 0.4 0.0 0.0 200 -4 -2 0 1 0\n"; last SWITCH; }
}

#desolvation params
print OUT "\n#    Desolvation Scoring Parameters:\n";
print OUT "#        desolvationParams <energy_thr> <cut_off_ratio>\n";
print OUT "#    <energy_thr> - remove all results with desolvation energy higher than threshold\n";
print OUT "#    <cut_off_ratio> - the ratio of low energy results to be kept\n";
print OUT "#    First filtering with energy_thr is applied and the remaining results\n";
print OUT "#    can be further filtered with cut_off_ratio.\n";
print OUT "desolvationParams 500.0 1.0\n";

print OUT "\n########################################################################\n";
print OUT "#   Advanced Parameters";
print OUT "\n########################################################################\n\n";

#clustering params
print OUT "#    Clustering Parameters:\n";
print OUT "#    clusterParams < rotationVoxelSize > < discardClustersSmaller > < rmsd > < final clustering rmsd >\n";
if( $molType =~ /drug/) {
  if( $rmsd == -1.0) {
    print OUT "clusterParams 0.05 3 1.0 1.5\n";
  } else {
    print OUT "clusterParams 0.05 3 1.0 $rmsd\n";
  }
} else {
  if($molType eq "AA") {
    if( $rmsd == -1.0) {
      print OUT "clusterParams 0.1 3 2.0 4.0\n";
    } else {
      print OUT "clusterParams 0.1 3 2.0 $rmsd\n";
    }
  } else {
    if( $rmsd == -1.0) {
      print OUT "clusterParams 0.1 4 2.0 4.0\n";
    } else {
      print OUT "clusterParams 0.1 4 2.0 $rmsd\n";
    }
  }
}
print OUT "dcClusterParams 0.1 2 2.0 2.0\n";

#base params
print OUT "\n#    Base Parameters:\n";
print OUT "#    baseParams <min_base_dist> <max_base_dist> <# of patches for base: 1 or 2>\n";
if ( $molType =~ /drug/ ) {
  print OUT "baseParams 2.0 13.0 2\n";
} else {
  print OUT "baseParams 4.0 13.0 2\n";
}

#matching params
print OUT "\n#    Matching Parameters:\n";
print OUT "#  matchingParams <geo_dist_thr> <dist_thr> <angle_thr> <torsion_thr> \n";
print OUT "#     <angle_sum_thr>\n";
if($molType =~ /drug/ ) {
  print OUT "matchingParams 2.0 1.0 0.4 0.5 0.9\n";
} else {
  if($molType eq "AA" ) {
    print OUT "matchingParams 1.5 1.5 0.4 0.5 0.9\n";
  } else {
    print OUT "matchingParams 1.5 1.5 0.4 0.5 0.9\n";
  }
}

print OUT "# 1 - PoseClustering (default), 2 - Geometring Hashing\n";
print OUT "matchAlgorithm 1\n";

#grid params
print OUT "\n#    Grid Parameters:\n";
print OUT "#      receptorGrid <gridStep> <maxDistInDistFunction> <vol_func_radius>\n";
print OUT "#      NOTE: the vol_func_radius of small molecules and peptides should be 3A!\n";
print OUT "ligandGrid 0.5 6.0 6.0\n";
if ( $molType =~ /drug/ ) {
  print OUT "receptorGrid 0.35 6.0 3.0\n";
} else {
  print OUT "receptorGrid 0.5 6.0 6.0\n";
}

#energy params
print OUT "\n# Energy Parameters:\n";
print OUT "vdWTermType 1\n";
print OUT "attrVdWEnergyTermWeight 1.01\n";
print OUT "repVdWEnergyTermWeight 0.5\n";
print OUT "HBEnergyTermWeight 1.0\n";
print OUT "ACE_EnergyTermWeight 1.0\n";
print OUT "piStackEnergyTermWeight 0.0\n";
print OUT "confProbEnergyTermWeight 0.1\n";
print OUT "COM_distanceTermWeight 1.07\n";
print OUT "energyDistCutoff 6.0\n";
print OUT "elecEnergyTermWeight 0.1\n";
print OUT "radiiScaling 0.8\n";

close (OUT);

unlink "2_sol.res";

sub chainSelector {
  my %chains= ();
  open FILE, $_[0];
  while (my $line=<FILE>) {
    if($line =~ /^ATOM/) {
      if( ! (substr($line,21,1) =~ ' ')) {
        $chains{substr($line,21,1)}=substr($line,21,1)." ";
      }
    }
  }
  close FILE;
  return values %chains;
}

sub computeStat {
  my $rigidMolecule = $_[0];
  my $flexMolecule = $_[1];
  my $flexRefMol = $_[2];
  # compute coverage %
  my $size = countCaAtoms($flexMolecule);
  my $covLine = `grep Mult 2_sol.res | head -1`;
  my ($aname, $alignmentSize) = split ('\:', $covLine);
  my $coverage = $alignmentSize/$size;
  # find RMSD
  my $rmsdLine = `grep RMSD 2_sol.res | head -1`;
  my ($rname, $rmsd) = split(':', $rmsdLine);
  chomp $rmsd;
  # compute interface
  my $interfaceLine = `interface -c $flexRefMol $rigidMolecule 6.0 | grep pairs`;
  my @tmp=split(' ', $interfaceLine);
  my $interfaceSize = $tmp[5];
  return "$flexRefMol, $flexMolecule, $coverage, $rmsd, $interfaceSize\n";
}

sub countAtoms {
  my $filename = shift;
  open FILE, "<$filename" or die "Can't open file: $filename";
  my @atomLines =  grep /(^ATOM|^HETATM)/, <FILE>;
  my $atomsNumber = grep ! /HOH/, @atomLines;
  close FILE;
  return $atomsNumber;
}

sub countCaAtoms {
  my $filename = shift;
  open FILE, "<$filename" or die "Can't open file: $filename";
  my @atomLines =  grep /(^ATOM|^HETATM)/, <FILE>;
  my $atomsNumber = 0;
  foreach (@atomLines) {
    if( substr($_,13,3) eq "CA ") {
      $atomsNumber++;
    }
  }
  close FILE;
  return $atomsNumber;
}
