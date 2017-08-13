#!/bin/bash


#########################################
# function for error handling
#########################################

function error_exit
{
    echo ${1:-"Unknown Error"} 1>&2
    exit 1
}

perl --help > /dev/null || error_exit "No Perl installation available. Please install first!";

mkdir -p $INSTALL_PREFIX/bin;

#########################################
echo " compile SVM light tools";
#########################################

cd svm_light;
make;
cd ..;


#########################################
echo " compilation and installation finished!";
#########################################

echo
echo " You can run now ./PDZpepint.sh sample.fasta";
echo
