PDZPepInt
===


PDZPepInt is a prediction tool for PDZ-peptide interactions, based on SVM. 
Current version contains a total 226 human, mouse, fly and worm PDZ domain models. 

PDZPepInt 1.0
August, 2013 
Authors: Kousik Kundu and Rolf Backofen

Platform:
------------

Unix and Linux


Installation:
------------

A current version of PDZPepInt you can get from:

http://www.bioinf.uni-freiburg.de/Software/PDZPepInt
 
or please write an email to Kousik Kundu <kk8@sanger.ac.uk>

To install the tool, please extract the src archive somewhere. Then change
into that directory and type

  bash COMPILE.sh

the script compiles the SVM-light and  
creates the master script, namely PDZPepInt.sh. 




Dependency:
-------------

In order to compile PDZPepInt correctly, you need "PERL" already installed.



Usage:
--------------

PDZPepInt <protein/peptide fasta file>

e.g. PDZPepInt peptides.fasta


Output File:
--------------
e.g. binding-results-17425.txt
1st column: Protein ID
2nd column: Peptide sequences
3rd-46th (43) columns: prediction scores by each PDZ family

See PDZ-cluster.txt for clustering informations. 


Files:
-----------------
sample.fasta: sample file for run the tool






