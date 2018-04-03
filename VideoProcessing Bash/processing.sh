#!/bin/bash
# Video_Processing_Italiansubs
# Version: 1.4
#
# Nicolas D'amuri - nicissimo97
#
# Changelog

subfix = "RESYNCH.mkv"
filePath="$1"
pathManualMode="/media/sdah1/nicissimo97/private/rtorrent/data"
fullPath="/media/sdah1/nicissimo97/private/rtorrent/RESYNCH/"
removePath () {
  echo "$filePath" | sed 's/...............................................//'
}

fileName=$(removePath "$filePath")

# Logging #
for (( i = 0; i < 100; i++ )); do
  echo -ne "*">>$fullPath/log.txt
done
echo "">>$fullPath/log.txt
echo "$fileName">>$fullPath/log.txt

# Functions #
encode () {
	eval ffmpeg -y -i "$2" -s 96x54 -crf 30 -c:a mp3 -b:a 64k -ac 2 "${2}$subfix">>$fullPath/log.txt
}

# Main #
if [[ $filePath ]]; then
if [[ $fileName == *mkv ]] || [[ $fileName == *mp4 ]] || [[ $fileName == *avi ]]; then
	encode "$filePath" "$filePath"
	echo "[ 1 OK! ]">>$fullPath/log.txt
else
	cd $filePath
	for i in *.rar;
	do
		rar x $i;
		videoName=$(ls *.mkv | head -1)
		encode "$filePath/$videoName" "$filePath/$videoName"
		echo "[ 2 OK! ]">>$fullPath/log.txt
	done;

	for y in *.mkv;
	do
		encode "$filePath/$y" "$filePath/$y"
		videoName=$(ls *.mkv | head -1)
		echo "$filePath/$y">>$fullPath/log.txt
		echo "[ 3 OK! ]">>$fullPath/log.txt
	done;
fi
else
	echo "[ ERROR ] Empty variable - Manual Mode"
	echo "[ ERROR ]">>$fullPath/log.txt
	cd "$pathManualMode"
	eval "ls"
	echo "Select video file and press ENTER:  "
	read file
	encode "$pathManualMode/$file" "$pathManualMode/$file"
fi
# Clear variable content #
fullPath=""
filePath=""
fileName=""
