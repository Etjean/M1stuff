#!/usr/bin/perl


$nbligand = 240 ;
$actif = 10 ;
$pas = 1 ;


for $i (1...$nbligand )
{
	if ($i < 10)
	{
	open (INI,"./ligand_00$i/out.pdbqt");
	@ini=<INI>;
	close (ini);
	$ene[$i] = substr($ini[1],23,7);
	}
	else
		{
		if ($i < 100)
		{
		open (INI,"./ligand_0$i/out.pdbqt");
		@ini=<INI>;
		close (ini);
		$ene[$i] = substr($ini[1],23,7);
		}
		else 
			{
			if ($i < 1000)
			{
			open (INI,"./ligand_$i/out.pdbqt");
			@ini=<INI>;
			close (ini);
			$ene[$i] = substr($ini[1],23,7);
			}
			}
		}
}


for $j (1...$nbligand)
{
	if (($j <= $actif ) )
	{
	$final[$j] = $ene[$j]."  1\n";
	}
	else
	{
	$final[$j] = $ene[$j]."\n";
	}
}


@class = sort @final ;
#print (@class);


open (OU2,">enrichissement.dat");

$range = $nbligand*$pas/100 ;
$n = 100/$pas ;

for $n(1..100/$pas)
{
for $m(($nbligand-($range*$n)) ... $nbligand)
{
$bon = $bon + substr($class[$m],8,12);
$perc_bon = $bon/$actif*100;
}
printf(OU2 "$n   $perc_bon\n");
$bon =0;
}

