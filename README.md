PDZPepInt
===

PDZPepInt is a cluster based prediction tool to predict binding peptides of PDZ domains in human, mouse, fly and worm. Total 43 built-in models that cover 226 PDZ domains across the species are available. Peptides are represented as 5 C-terminal sequences of binding proteins. Depending on the user requirement [Gene Ontology](http://www.ebi.ac.uk/QuickGO/) database can be used for getting reliable interactions. Additionally, it will also consider the C-terminal peptides that are intrinsically unstructured for getting high confidence interactions.

PDZPepInt 1.0
August, 2013 

Authors: Kousik Kundu and Rolf Backofen

Platform:
------------

Unix and Linux


Installation:
------------

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

Webserver:
-----------------
http://modpepint.informatik.uni-freiburg.de/PDZPepInt/Input.jsp

Contact:
-----------------
Kousik Kundu (kk8@sanger.ac.uk)


Citation:
-----------------
* Kousik Kundu, Martin Mann, Fabrizio Costa, and Rolf Backofen.
[MoDPepInt: An interactive webserver for prediction of modular domain-peptide interactions
Bioinformatics, 2014.](https://academic.oup.com/bioinformatics/article-lookup/doi/10.1093/bioinformatics/btu350)

* Kousik Kundu and Rolf Backofen
[Cluster based prediction of PDZ-peptide interactions BMC Genomics, 15 Suppl 1 pp. S5, 2014.](https://bmcgenomics.biomedcentral.com/articles/10.1186/1471-2164-15-S1-S5)





