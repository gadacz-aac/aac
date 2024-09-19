#!/bin/bash

branch=$(git branch --show-current)

if [[ -z "$branch" != "main"]]; then
	echo "You're not on main branch. If you want to publish from non main branch, please add a flag that always that to happen"
	exit 1
fi

gh release list | head -1

read -p "Version number: v" number

number="v$number"

gh release create "$number"

read -p "Are you ready to build your app (Y/n)? " confirm

confirm=$(echo $confirm | awk '{print tolower($0)}')

while true; do
	if [[ -z "$confirm" || "$confirm" == "y" ]]; then
		echo "building"
		flutter build apk
		
		name=$(cat pubspec.yaml | head -1 | cut -f 2 -d " ")
		tmpFile="/tmp/$name-$number.apk"

		mv "build/app/outputs/flutter-apk/app-release.apk" "$tmpFile"

		gh release upload "$number" "$tmpFile"

		rm "$tmpFile"

		break
	else
		echo "Suit yourself, bye!"
		break
	fi
done
