#!/usr/local/perl/bin/perl
use warnings;
use strict 'vars';
use Getopt::Long;
use Pod::Usage;
use Cwd;


###############################################################################
# PARSE COMMAND LINE OPTIONS
###############################################################################


my ($i_help, $in_file, $out_file);   # in- and output files


GetOptions('help'               =>  \$i_help,
           'i|input=s'          =>  \$in_file,
           'o|output=s'         =>  \$out_file);
      
           

=head1 OPTIONS

        -help   This message.
        -i      Input file should be in fasta format with one line sequence (NOT multiple lines).
        -o      <FILE_NAME> Name of the output file. The file would be tab seperated
                1 col: protein id
                2 col: pY position
                3 col: 7 amino acids length sequence.
                If this is not given, the output is written to STDOUT.


=cut


check input
pod2usage(-exitstatus => 1, -verbose => 1) if $i_help;

&usage unless $in_file && $out_file;
die "ERROR: File $in_file does not exist.\n" if (!(-e $in_file));

open (OUT, ">$out_file");
open(FH, "$in_file");
my @file=<FH>;
my $i =0; my $j=1; my ($line, $seq, $position,$id);
my $prot_id =0;
foreach(@file) {
        $line= $_;
        chomp($line);
        if($line=~ /^>(\S+)/) {
        	$id=$1;
                $prot_id = $prot_id+1; 
              	next;
        }
      
	my $pep_len=length($line);
	my $st=$pep_len-5;
	my $pep=substr($line, $st, 5);
	
	print OUT "$id\t$pep\n";
}


