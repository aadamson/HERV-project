DIR="$1"
OUT_DIR="$2"
KEYWORD="$3"

if [ ! -d "$OUT_DIR" ]; then
    mkdir "$OUT_DIR"
fi

grep -Ril "$DIR" -e "$3" | while read -r f ; do
    ln -s "$f" "$OUT_DIR/"
done

