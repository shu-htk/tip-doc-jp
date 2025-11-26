#1/bin/bash

css=border.css
tmp=tmp/tmp

mkdir -p tmp html/ex html/ref
#cat md/README.md | sed 's%doc/%html/%g' | sed 's%\.md%.html%g' > readme
#pandoc -f markdown -t html readme -s --embed-resources -c $css -o index.html 
#rm readme

#for f in md/*.md md/ex/*.md md/ref/*.md ; do
for f in $* ; do
    echo $f
    f2=$(basename ${f%.*})
    cat $f | sed 's%\.md%.html%g' > $f2
    dest=$(echo ${f%.*}.html | sed 's%md/%html/%g')
    pandoc -f markdown -t html $f2 -s --embed-resources -c $css -o $tmp
    cat $tmp | sed 's|<pre><code>|<pre><code>\n|g' \
	| sed 's|</code></pre>|\n </code></pre>|g' > $dest
    rm $f2
done
