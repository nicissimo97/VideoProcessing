#!/bin/bash

file_path="$1"

//Function

removePath () {
  echo "$file_path" | sed 's/...............................................//'
}
addResynch () {
	"${1}.RESYNCH.mkv"
}

//Main

file_name=$(removePath "$file_path")
file_name_resynch=$(addResynch "$file_name")

if [[ $file_path ]]; then
if [[ $file_name == *mkv ]] || [[ $file_name == *mp4 ]]; then
	rm "file_name_resynch"
else
	cd $file_path
  rm -rf "$file_path"
  
fi
