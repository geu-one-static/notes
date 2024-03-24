shopt -s globstar


for file in ./**/*.jpg; do
    filename="${file##*/}"
    filepath="${file%/*}"
    set mfile = "$filepath/$filename"
    echo "Deleting $mfile"
    rm "$mfile"
done
