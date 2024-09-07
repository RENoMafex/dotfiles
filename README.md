# My personal .dotfiles

Most commits will be automated from my home machine by using ``make``

Makefile:
```make
pullfiles:
    ./updatefiles.sh
    git add .
    git commit -m "automated commit"
    git push

```

updatefiles.sh:
```bash
#!/usr/bin/env bash

for file in .*; do
    if [ -f "$file" ]; then
        if [ -f "../$file" ]; then
            cp -f "../$file" "$file"
            echo "$file succsessful overwritten!"
        else
            echo "File $file couldnt be found in parent directory!"
        fi
    fi
done

```
