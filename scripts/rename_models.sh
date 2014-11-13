# MODELS_DIR="$1"
# OUT_DIR="$2"
# PREFIX="xx"

# for f in "$MODELS_DIR/$PREFIX*"
# do
#         first_line=$(head -n 1 "$f" | cut -d " " -f1 | sed 's/\/_/')
#         mv "$f" "$OUT_DIR/$first_line.hmm"
# done
