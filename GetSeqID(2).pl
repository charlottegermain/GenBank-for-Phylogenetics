#!/usr/bin/perl

use LWP::Simple;
my $utils = "http://www.ncbi.nlm.nih.gov/entrez/eutils";

my $db = "Nuccore";
my $report = "FASTA(text)";

open IN, $ARGV[0] or die "can't open input file\n";
open OUT1, ">SequenceTrial.txt";

while (<IN>)
{
	my $query=$_;
	chomp($query);
	
	my $esearch = "$utils/esearch.fcgi?" .
              "db=$db&retmax=10000000&rettype=fasta&usehistory=y&term=";
              
 	my $esearch_result = get($esearch . $query);

	print OUT1 $esearch_result ."\n";
}

close OUT1;

open FH1, "<SequenceTrial.txt";
open OUT2, ">GenBankSequenceIDlist.txt";
$flag=0;
%hashname=();


while (<FH1>)
{
    if(/\<Id\>(\d+)\<\/Id\>/)
    {
	$ID=$1;
	print OUT2 "$ID\n";
    }
    if(/<Count>(\d+)<\/Count>/)
    {
	$count=$1;
	$sum=$sum + $count;
	print "$count\n";
	}
	

}
	print "sum of sequences is $sum\n";