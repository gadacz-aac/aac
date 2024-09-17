#!/bin/bash

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
		
		gh release upload "$number" "build/app/outputs/flutter-apk/app-release.apk"

		break
	else
		echo "Suit yourself, bye!"
		break
	fi
done
