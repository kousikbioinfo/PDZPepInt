#!/bin/bash

TEMPDIR=binding-results-$RANDOM;
mkdir $TEMPDIR;
FASTA=$1;
#MODEL=$2;
perl fastapl -p1 $FASTA > $TEMPDIR/input_seq_file.txt; ## Reformat each sequence into one line

perl make-peptides.pl -i $TEMPDIR/input_seq_file.txt -o $TEMPDIR/output_seq_file.txt; ## Take last 5 amino acids for each protein.

perl make-dat-file.pl -i $TEMPDIR/output_seq_file.txt -o $TEMPDIR/Test-file.dat;

echo -e "Seq-ID:\tSequence:" > $TEMPDIR/header1.txt;


for i in models/*.model; do basename ${i%.*}|tr '\n' '\t' >> $TEMPDIR/header2.txt ; 
svm_light/svm_classify $TEMPDIR/Test-file.dat $i ${i%.*}.out > $TEMPDIR/classify-STDOUT.txt; done
paste $TEMPDIR/header1.txt $TEMPDIR/header2.txt > $TEMPDIR/header.txt;
paste $TEMPDIR/output_seq_file.txt models/*.out > $TEMPDIR/values.txt;
cat $TEMPDIR/header.txt $TEMPDIR/values.txt > $TEMPDIR.txt;
#awk '{OFS="\t";if ($4>0) print $0}' $TEMPDIR/results.txt > $TEMPDIR.txt;
rm models/*.out;

echo 'results in '$TEMPDIR'.txt';

rm -r $TEMPDIR;
