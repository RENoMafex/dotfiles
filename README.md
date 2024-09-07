# My personal .dotfiles

Most commits will be automated from my home machine by using ``make``

Makefile:

´´´
pullfiles:
    ./updatefiles.sh
    git add .
    git commit -m "automated commit"
    git push

´´´

updatefiles.sh:

´´´bash
#!/usr/bin/env bash

for file in .*; do
    if [ -f "$file" ]; then
        if [ -f "../$file" ]; then
            cp -f "../$file" "$file"
            echo "$file wurde überschrieben!"
        else
            echo "Datei $file wurde im Übergeordneten verzeichnis nicht gefunden!"
        fi
    fi
done

´´´
