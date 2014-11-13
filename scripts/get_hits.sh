ERV_HMM_DIR="/farmshare/user_data/aadamson/cs273a_project/hmm/models/erv"

# Default arguments
erv_hmms="$ERV_HMM_DIR/*.hmm"
genome_fa="/farmshare/user_data/aadamson/cs273a_project/hg19.fa"
out_dir=""

while getopts ":g:e:o:" opt; do
  case $opt in
    e)
      erv_hmms="$OPTARG"
      ;;
    g)
      genome_fa="$OPTARG"
      ;;
    o)
      out_dir="$OPTARG"
      ;;
    \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

if [ ! -z "$out_dir"] && [ ! -d "$out_dir" ]; then
  mkdir "$out_dir"
fi

for f in $erv_hmms; do
  hits=$(nhmmer --cut_ga "$f" "$genome_fa")
  
  if [ ! -z "$out_dir"]; then
    file_name="${f##*/}"
    out_file="$out_dir/$file_name.hits"

    if [ ! -f "$out_file"]; then 
      echo "$hits" > "$out_file"
    fi
  else
    echo "$hits"
  fi
done
