#/bin/bash

PNG_LIST="$(git ls-files | grep -i -E '.png$')";

before_size=0;
after_size=0;

for file in $PNG_LIST; do
    [ ! -f "$file" ] && continue
    echo "----------------------------"
    echo "[target] $file"

    before_file_size=$((`wc -c < $file`))
    before_size=$((before_size+before_file_size))
    echo "[before_size] $before_size"

    zopfli -c "$file" > tmp_file.png && mv tmp_file.png "$file"

    after_file_size=`wc -c < $file`
    after_size=$((after_size+after_file_size))
    echo "[after_size] $after_size"
done

echo $before_size
echo $after_size
