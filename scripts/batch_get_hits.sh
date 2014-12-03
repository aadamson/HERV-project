trap "exit" INT

job_count () {
  count_plus_one=$(qstat | wc -l)
  count=$(($count_plus_one - 1))

  echo "$count"
}

hmms=( "./hmm/models/erv/*.hmm" )
genomes=( "./genomes/*.fa" )
max_jobs=$(qconf -sconf | grep max_u_jobs | sed 's/[^0-9]//g')

log_dir="."
while getopts ":l:h:g:" opt; do
  case $opt in
    h)
      if [ -e "$OPTARG" ] && [ "${OPTARG##*.}" != "hmm" ]; then
        $(readarray -t hmms < "$OPTARG")
      else
        hmms=($OPTARG)
      fi
      ;;
    g)
      if [ -e "$OPTARG" ] && [ "${OPTARG##*.}" != "fa" ]; then
        $(readarray -t genomes < "$OPTARG")
      else
        genomes=( "$OPTARG" )
      fi
      ;;
    l)
      log_dir=${OPTARG}
      mkdir -p "$log_dir"
      ;;
    \?)
      echo "Invalid option: $opt" >&2
      exit 1
      ;;
  esac
done
echo "${hmms[@]}"

for h in "${hmms[@]}"; do
  hname=$(basename "$h")
  
  for g in "${genomes[@]}"; do
    gname=$(basename "$g")
    job_name=${hname%%.*}"_"${gname%%.*}
    
    num_jobs=$(job_count)
    while [ "$num_jobs" -ge "$max_jobs" ]; do
      num_jobs=$(job_count)
      sleep 60
    done
    
    qsub -l mem_free=40G -N "$job_name" -e "$log_dir" -o "$log_dir" -cwd ./scripts/get_hits.sh -g "$g" -h "$h" -o "./data4"
  done
done
