#!/bin/bash
iter_limit=8
INPUT=weights/weights5D-30.csv

for i in "$@"; do
  case $i in
    -i=*|--input=*)
      input_seq="${i#*=}"
      shift # past argument=value
      ;;
    -o=*|--output=*)
      out_dir="${i#*=}"
      shift # past argument=value
      ;;
    -w=*|--weight=*)
      INPUT="${i#*=}"
      shift # past argument=value
      ;;
    -t=*|--iter=*)
      iter_limit="${i#*=}"
      shift # past argument=value
      ;;
    *)
      # unknown option
      ;;
  esac
done

if [ -z "$input_seq" ]
then
      echo "Input sequences not provided. Exiting."
      exit
fi

if [ -z "$out_dir" ]
then
      echo "Output directory not provided. Exiting."
      exit
fi
echo "Input sequences  = ${input_seq}"
echo "Output dir       = ${out_dir}"
echo "Weight file      = ${INPUT}"


cd "$(dirname "$0")"

mkdir -pv $out_dir

i=0
OLDIFS=$IFS
IFS=','
[ ! -f $INPUT ] && { echo "$INPUT file not found"; exit 99; }
#for each weight
while read w1 w2 w3 w4 w5
do
    echo "Running PMAO for $i-th weight vector=$w1, $w2, $w3, $w4, $w5"
    #generate alignment and tree using many-objective application-aware PASTA
    $pasta_python run_pasta.py -i $input_seq -d protein -o $out_dir/$dataset -j $i --simg=$w1 --simng=$w2 --osp=$w3 --gap=$w4 --ml=$w5 --iter-limit=$iter_limit --no-return-final-tree-and-alignment --move-to-blind-on-worse-score
    i=$[i+1]
    #exit
done < $INPUT
IFS=$OLDIFS
