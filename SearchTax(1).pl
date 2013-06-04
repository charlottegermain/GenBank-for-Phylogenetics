#!/usr/bin/perl

use LWP::Simple;
my $utils = "http://www.ncbi.nlm.nih.gov/entrez/eutils";

my $db = "Taxonomy";
my $report = "abstract";

open IN, $ARGV[0] or die "can't open input file\n";
open OUT1, ">trialTax.txt";

while (<IN>)
{
	my $query=$_;
	chomp($query);
	
	my $esearch = "$utils/esearch.fcgi?" .
              "db=$db&retmax=1&usehistory=y&term=";
              
 	my $esearch_result = get($esearch . $query);

	print OUT1 $esearch_result ."\n";
}

close OUT1;


open FH1, "<trialTax.txt";
open OUT2, ">GenBankID.txt";
open OUT3, ">NameIDlist.txt";
$flag=0;
%hashname=();


while (<FH1>)
{
    if(/\<Id\>(\d+)\<\/Id\>/)
    {
	$ID=$1;
	#print "$ID\t";
	$flag=1;
    }
    if(/<Term>(.*)<\/Term>/)
    {
	$Name=$1;
	#print "$Name\n";
	if ($flag==1)
	{
	    $hashname{$ID}=$Name;
	    print OUT2 "txid$ID\[Organism\]\n";
	    print OUT3 "$Name\t$ID\n";
	    $flag=0;
	}
    }
}
