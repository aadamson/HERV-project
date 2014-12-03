if [ -d "./src" ]; then
  PATH=./src:$PATH
fi

ERV_HMM_DIR="/farmshare/user_data/aadamson/HERV-project/hmm/models/erv"

# Default arguments
hmms=$(echo "$ERV_HMM_DIR/*.hmm")
genome_fas="/farmshare/user_data/aadamson/HERV-project/hg19.fa"
out_dir=""

while getopts ":g:h:o:" opt; do
  case $opt in
    h)
      hmms="${OPTARG}"
      ;;
    g)
      genome_fas="${OPTARG}"
      ;;
    o)
      out_dir="$OPTARG"
      echo "$out_dir"
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

if [ ! -z "$out_dir" ] && [ ! -d "$out_dir" ]; then
  mkdir "$out_dir"
fi

for f in $hmms; do
  curr_dir=""
  base=$(basename "$f" ".hmm")

  if [ ! -z "$out_dir" ]; then
    curr_dir="$out_dir/$base"
    mkdir -p "$curr_dir"
  fi

  for g in $genome_fas; do
    hits=$(nhmmer --cut_ga "$f" "$g")
    genome_base=$(basename "$g" ".fa")

    if [ ! -z "$curr_dir" ]; then
      file_name=$base"_"$genome_base
      out_file="$curr_dir/$file_name.hits"

      if [ ! -f "$out_file" ]; then 
        echo "$hits" > "$out_file"
      fi
    else
      echo "$hits"
    fi
  done
done
