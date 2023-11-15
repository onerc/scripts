# extracts mkv tracks with "SDH" name
for f in ./*.mkv; 
do 
echo "Processing $f file..."; 
subtitles=$(mkvmerge -J $f | jq '.tracks[] | select(.properties.track_name=="SDH") | .id') 
mkvextract tracks $f $subtitles:$f.srt;
done
