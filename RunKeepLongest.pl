#!/usr/bin/perl -w

system "ls -l *.fasta >filenames";

open FH, "<filenames";

while (<FH>)
	{
		if (/(Cluster\.\d+\.fasta)/)
			{
				$title=$1;
				print "$title\n";
				system "perl KeepLongest.pl $title"
			}
	}
	
	
	

