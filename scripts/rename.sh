MODELS_DIR="$1"
OUT_DIR="$2"
PREFIX="$3"

for f in $MODELS_DIR/$PREFIX*; do
  name=$(grep "NAME" "$f" | perl -lape 's/NAME\s+//sg')
  out_file="$OUT_DIR/$name.hmm"

  if [ ! -f "$out_file" ]; then
    mv "$f" "$out_file"
  fi
done
