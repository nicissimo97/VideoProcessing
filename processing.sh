#!/bin/bash
# Video_Processing_Italiansubs
# Version: 1.1
#
# Nicolas D'amuri - nicissimo97

file_path="$1"
path_manual_mode="/media/sdah1/nicissimo97/private/rtorrent/data"
full_path="/media/sdah1/nicissimo97/private/rtorrent/RESYNCH/"

# Functions #

removePath () {
  echo "$file_path" | sed 's/...............................................//'
}
encode () {
	eval ffmpeg -y -i "$2" -s 96x54 -crf 30 -c:a mp3 -b:a 64k -ac 2 "${2}.RESYNCH.mkv"
}
removeBlanks(){
    echo "${s//[[:blank:]]/}"
}

file_name=$(removePath "$file_path")

# Logging #

for (( i = 0; i < 100; i++ )); do
  echo -ne "*">>$full_path/log.txt
done
echo "">>$full_path/log.txt
echo "$file_name">>$full_path/log.txt

# Main #

if [[ $file_path ]]; then
if [[ $file_name == *mkv ]] || [[ $file_name == *mp4 ]] || [[ $file_name == *avi ]]; then
	encode "$file_path" "$file_path"
	echo "[ 1 OK! ]">>$full_path/log.txt
else
  	cd $file_path
    sfv_file=`ls -1 *.sfv 2>/dev/null | wc -l`
      if [[ $sfv_file != 0 ]]; then
      	for i in *.rar;
      	do
      		rar x $i;
      		video_name=$(ls *.mkv | head -1)
      		encode "$file_path/$video_name" "$file_path/$video_name"
      		echo "[ 2 OK! ]">>$full_path/log.txt
      	done;
      else
      	for y in *.mkv;
      	do
      		encode "$file_path/$y" "$file_path/$y"
      		video_name=$(ls *.mkv | head -1)
      		echo "$file_path/$y">>$full_path/log.txt
      		echo "[ 3 OK! ]">>$full_path/log.txt
      	done;
      fi
fi
else
	echo "[ ERROR ] Manual Mode"
	echo "[ ERROR ]">>$full_path/log.txt
	cd "$path_manual_mode"
	eval "ls"
	echo "Select video file and press ENTER:  "
	read file
	encode "$path_manual_mode/$file" "$path_manual_mode/$file"
fi
# Clear variable content #
full_path=""
file_path=""
file_name=""
