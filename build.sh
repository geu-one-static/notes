shopt -s globstar


NOTES_FILE=notes.txt

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
    convert "$file"[0] -background white -alpha remove -thumbnail 300x500 -gravity north -extent 300x200 -crop 90%x+0+0 "$file.jpg"
done

#for file in ./**/*.{pdf,jpg}; do
git reset .
git add .
git ls-files | while read -r file; do
  echo "$file" >> "$NOTES_FILE"
done
