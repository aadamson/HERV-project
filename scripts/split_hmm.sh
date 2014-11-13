HMM_FILE=$(readlink -f "$1")
OUT_DIR=$(readlink -f "$2")
PREFIX="$3"

if [ ! -d "$OUT_DIR" ]; then
  mkdir "$OUT_DIR"
fi

initial_dir=$(pwd)
cd "$OUT_DIR"

csplit --digits=4 -f "$PREFIX" --quiet "$HMM_FILE" "/\/\//" "{*}"

hmm_files="$OUT_DIR/$PREFIX*"

for f in $hmm_files; do
  sed -i '/\/\//d' "$f"
done
