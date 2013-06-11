GenBank for Phylogenetics scripts

These perl scripts were all written by Charlotte C. Germain-Aubrey and Julia M. Allen. 

In order to go from a list of species to a phylogenetic tree, there are several steps to undertake. 
We first mine GenBank for existing sequences for a list of species, then use Blast to create clusters, filter them to keep one sequence per taxon. 
The scripts should be used in this order: 

1. SearchTax.pl
	This script will take a csv file with species name, and convert them to the corresponding NCBI TaxID
	
2. GetSeqID.pl
	This script will search GenBank for all sequences associated with the TaxID (a main name, or synonym), except for whole genomes and microsatellites
	
3. GetFasta.pl
	This will convert the Sequence IDs into a fasta file with the actual sequences

4. BlastnCommandLine.txt
	This is the command line to blast the nucleotide data against itself using blastclust
	
5. makeclusters.pl
	Here we use the blastclust output and convert it into fasta files

6. KeepLongest.pl
	The clusters are filtered and the longest sequence for each taxon is kept within each cluster
	

