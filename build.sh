shopt -s globstar


NOTES_FILE=notes.txt
VERSION_FILE=__version__

echo "https://github.com/geu-one-static/notes/blob/master/ ?raw=true" > $NOTES_FILE

count=0

for _ in ./**/*.pdf; do
    count=$(expr $count + 1)
done

total=$count
count=0

for file in ./**/*.pdf; do
    filename="${file##*/}"
    filepath="${file%/*}"
    echo "$filepath $((++count))/$total"
    convert "$file"[0] -background white -alpha remove -thumbnail x250 -gravity north -extent x140 -crop 90%x+0+0 "$file.jpg"
done

#for file in ./**/*.{pdf,jpg}; do
git reset .
git add .
git ls-files | while read -r file; do
  if [[ "$file" == *.pdf ]]; then
    echo "$file" >> "$NOTES_FILE"
  fi
done

echo $(date +%s) > __version__
