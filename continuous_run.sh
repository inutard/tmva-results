#!/bin/sh

TMVA_DIR=$PWD/../tmva-studies/lean_tmva/
RESULT_DIR=$PWD
bdt_trial=0
mlp_trial=0

cd $TMVA_DIR
while true; do
	bdt_file=$RESULT_DIR/bdt-results/bdt-significance"$bdt_trial".txt
	mlp_file=$RESULT_DIR/mlp-results/mlp-significance"$mlp_trial".txt
	root -l -q "TMVAClassification.C(2)" > $bdt_file && root -l -q "TMVAClassification.C(1)" > $mlp_file
	sleep 1

	tail -n+3 $bdt_file > tmp.txt && mv tmp.txt $bdt_file
	sleep 1
	tail -n+3 $mlp_file > ttmp.txt && mv ttmp.txt $mlp_file

	mlp_trial=`expr $mlp_trial + 1`
	bdt_trial=`expr $bdt_trial + 1`
done
