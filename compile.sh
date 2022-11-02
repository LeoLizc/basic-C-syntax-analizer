yac_name="test.y"
lex_name="test.l"
dir="."
output_file="a.out"
while getopts o:y:l:d: flag
do
    case "${flag}" in
        o) output_file=${OPTARG};;
        y) yac_name=${OPTARG};;
        l) lex_name=${OPTARG};;
        d) dir=${OPTARG};;
    esac
done

# Echo the inputs
echo "yac_name: $yac_name"
echo "lex_name: $lex_name"
echo "dir: $dir"
echo "output_file: $output_file"

yac_path="${dir}/${yac_name}"
yac_h_path="${dir}/y.tab.h"
lex_path="${dir}/${lex_name}"
output_path="${dir}/${output_file}"

lex_c_path="${dir}/lex.yy.c"
yac_c_path="${dir}/y.tab.c"

yacc -d $yac_path
lex $lex_path $yac_h_path
cc -o $output_path $lex_c_path $yac_c_path
# cc lex.yy.c y.tab.c -o test