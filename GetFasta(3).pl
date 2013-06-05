use LWP::Simple;
my $utils = "http://www.ncbi.nlm.nih.gov/entrez/eutils";

my $db = "nucleotide";
my $report = "FASTA(text)";

open IN, $ARGV[0] or die "can't open input file\n";
open OUT1, ">AllSequences.fasta";

while (<IN>)
{
	my $query=$_;
	chomp($query);
	
	my $esearch = "$utils/efetch.fcgi?" .
              "db=$db&rettype=fasta&retmode=text&id=";
              
 	my $esearch_result = get($esearch . $query);

	print OUT1 $esearch_result ."\n";
}

close OUT1;