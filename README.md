# My personal .dotfiles

Most commits will be automated from my home machine by using ``make``.
``Makefile`` and ``updatefiles.sh`` are not in this repo, because those are useless on other machines than my own.

**Makefile:**
```make
.IGNORE: updategh

dryrun:
	./updatefiles.sh

updategh:
	./updatefiles.sh
	git add .
	git commit -m "automated commit"
	git push

```


**updatefiles.sh:**
```bash
#!/usr/bin/env bash

for file in .*; do
	if [ -f "$file" ]; then
		if [ -f "../$file" ]; then
			if ! cmp -s "$file" "../$file"; then
				cp -f -v "../$file" "$file"
				echo "File \"$file\" successfully overwritten!"
			else
				echo "File \"../$file\" is unchanged, no need to overwrite \"$file\"."
			fi
		else
			echo "File \"$file\" couldnt be found in parent directory!"
		fi
	fi
done
```
