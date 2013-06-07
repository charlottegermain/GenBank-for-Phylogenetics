#!usr/bin/perl


system "ls -l *.fasta >filenames";

open FH, "<filenames";

while (<FH>)
	{
		if (/(Cluster\.(\d+)\.fasta)/)
			{
				$title=$1;
				$num=$2;
				
#$numclust=1;
open OUT, ">Cluster.$num.unique.fasta";
open FH, "<Cluster.$num.fasta" ;
while (<FH>)
{
    if (/^>gi\|(\S+?)\|gb\|\S+?\|(\D+?\s\D+?)\s+/)
     {
	 $flag=0;
	 $GI=$1;
	 $name=$2;
	 $fullname=$_;
	 $total++;
     }
    elsif (/(\S+)/ && ! /^>/)
    {	
	$flag=1;
	$seq=$1;
	$length=length($seq);
	$hashlength{$GI}=$length;
	$hashIDseq{$GI}=$seq;
	$hashIDfullname{$GI}=$fullname;
    }
    if ($flag == 1 )
    {
	if (! exists $namehash{$name})
	{
	    $namehash{$name}=$length;

	    $nameGI{$name}=$GI;
	    push @uniquearray, $name;
	}
	elsif (exists $namehash{$name})
	{
	    if ($length > $namehash{$name})
	    {
		$namehash{$name}=$length;
		$nameGI{$name}=$GI;
	    }
	}
    }
    
}

#print "The total number of sequences are $total\n";

for $name(@uniquearray)
{
    #print "$name\n";
    print OUT "$hashIDfullname{$nameGI{$name}} $hashIDseq{$nameGI{$name}}\n";
    $numunique++;
}

#print "the number of unique names are $numunique\n";

