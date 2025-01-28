# My personal .dotfiles
### NOTE
>This repo is **ALWAYS** WIP, which means, you should use the code and files in this Repo with caution. Especially `install.sh` is prone to Overwrite some of your already populated dotfiles.

## How to use the `install.sh` script without downloading the whole repo yourself

To install _my_ personal Dotfiles simply run:
```bash
wget -q https://raw.githubusercontent.com/RENoMafex/dotfiles/refs/heads/master/install.sh -O /tmp/install.sh
chmod +x /tmp/install.sh
./tmp/install.sh
rm -f /tmp/install.sh
```
**NOTE:** This by default only works on Debian based based distributions because the `ìnstall.sh` script uses `apt`.



Most commits will be automated from my home machine by using ``make``.
`Makefile` and `updatefiles.sh` are not in this repo, because those are useless on other machines than my own.


**Makefile:**
```make
.IGNORE: updategh

dryrun:
	./updatefiles.sh

push:
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
