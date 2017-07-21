#!/usr/local/perl/bin/perl
use warnings;
use strict 'vars';
use Getopt::Long;
use Pod::Usage;
use Cwd;


###############################################################################
# PARSE COMMAND LINE OPTIONS
###############################################################################

=head1 NAME
gspan_format.pl

=head2 DESCRIPTION
This script will make a dat file for SVM-light OR LibSVM. The output
file order is NOT correspodance to the FLAG options. 

N.B. There is a file called by this script which contains 
Domains name/description in 1st column
SEQUENCE in the 2nd column and
TARGET in the 3rd column

e.g: perl svm_vector.pl -i input.tsv -o output.dat

AUTHOR: Kousik Kundu

=head1 OPTIONS

        -help   This message.
	-i      Input file should be in tab seperated format with 1st, 2nd and 3rd column 
		with domain name and interacting peptide and target, respectively.
	-o	<FILE_NAME> e.g. GRB2.dat. Name of the output file. 
	
=cut

#### COMMAND LINE OPTIONS

my ($i_help, $in_file, $out_file);

GetOptions('help'               =>  \$i_help,
	   'i|input=s'          =>  \$in_file,
           'o|output=s'         =>  \$out_file);



check input
pod2usage(-exitstatus => 1, -verbose => 1) if $i_help;

&usage unless $in_file && $out_file;
die "ERROR: File $in_file does not exist.\n" if (!(-e $in_file));
#die "ERROR: File $out_file does already exist.\n" if (-e $out_file);

open (OUT, ">$out_file");

open (FH, "$in_file");
my @file = <FH>;
my %Amino;
my $HEAD; 
%Amino	=	(A=> '0',
		C=> '0',
		D=> '0',
		E=> '0',
		F=> '0',
		G=> '0',
		H=> '0',
		I=> '0',
		K=> '0',
		L=> '0',
		M=> '0',
		N=> '0',
		P=> '0',
		Q=> '0',
		R=> '0',
		S=> '0',
		T=> '0',
		V=> '0',	
		W=> '0',	
		Y=> '0');

$HEAD =0;	
foreach(@file) {

	my $line=$_;
	chomp($line); 
	my @info= split(/\t/,$line);
	my $dom = $info[0];
	my $seq = $info[1];
	my $target="-1";
	my $SeqLen= length($seq);

	
	my $Feature=1;
	my($i,$key,$m1);
	print OUT "$target ";
	for($i=0; $i<$SeqLen; $i++) {
	$m1 = substr($seq, $i, 1);
	foreach $key (sort keys %Amino) { 
		if ($key eq $m1) {
			$Amino{$key} =  1; 
		}
		else {
			$Amino{$key} =  0; 
		}
	}
	foreach $key (sort keys %Amino) {
		if($Amino{$key} eq 1) {
		print OUT "$Feature:$Amino{$key} "; 
		}
		$Feature++;
	}

}


print OUT "\n";

}


