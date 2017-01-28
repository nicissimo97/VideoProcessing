#!/bin/bash
# Video_Processing_Italiansubs
# Version: 1.1
#
# Nicolas D'amuri - nicissimo97
#
# Changelog
# 1.0 First release
# 1.1 Added unrar event and encoding cicle for multiple file
# 1.2 Improved logging

file_path="$1" 
full_path="/media/sdah1/nicissimo97/private/rtorrent/RESYNCH/" 
removePath () {
  echo "$file_path" | sed 's/...............................................//'
}

file_name=$(removePath "$file_path")

# Logging #
for (( i = 0; i < 100; i++ )); do
  echo -ne "*">>$full_path/log.txt
done
echo "">>$full_path/log.txt
echo "$file_name">>$full_path/log.txt

# Functions #
encode () {
	eval ffmpeg -y -i "$2" -s 96x54 -crf 30 -c:a mp3 -b:a 64k -ac 2 "${2}.RESYNCH.mkv">>$full_path/log.txt
}

# Main #
if [[ $file_path ]]; then
if [[ $file_name == *mkv ]] || [[ $file_name == *mp4 ]]; then
	encode "$file_path" "$file_path"
	echo "[ 1 OK! ]">>$full_path/log.txt
else
	cd $file_path
	for i in *.rar;
	do
		rar x $i;
		video_name=$(ls *.mkv | head -1)
		encode "$file_path/$video_name" "$file_path/$video_name"
		echo "[ 2 OK! ]">>$full_path/log.txt
	done;

	for y in *.mkv;
	do
		encode "$file_path/$y" "$file_path/$y"
		video_name=$(ls *.mkv | head -1)
		echo "$file_path/$y">>$full_path/log.txt
		echo "[ 3 OK! ]">>$full_path/log.txt
	done;
fi
else
	echo "[ ERROR ] Empty variable - Manual Mode"
	echo "[ ERROR ]">>$full_path/log.txt
fi
# Clear variable content #
full_path=""
file_path=""
file_name=""
