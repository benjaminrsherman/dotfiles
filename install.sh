#!/bin/sh

for fname in $(ls -p | grep -v /); do
	if [ $fname != "install.sh" ]; then
		cp $fname "$HOME/.$fname"
	fi
done

for dirname in $(ls -p | grep /); do
	rsync -a $dirname "$HOME/.$dirname"
done
