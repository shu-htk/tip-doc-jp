#1/bin/bash

css=border.css
#css=test.css

mkdir -p html/ex html/ref
cat md/README.md | sed 's%doc/%html/%g' | sed 's%\.md%.html%g' > readme
pandoc -f markdown -t html5 readme -s --self-contained -c $css -o index.html 
rm readme

for f in md/*.md md/ex/*.md md/ref/*.md ; do
    f2=$(basename ${f%.*})
    cat $f | sed 's%\.md%.html%g' > $f2
    dest=$(echo ${f%.*}.html | sed 's%doc/%html/%g')
    pandoc -f markdown -t html5 $f2 -s --self-contained -c $css -o $dest
    rm $f2
done
