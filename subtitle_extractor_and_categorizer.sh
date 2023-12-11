sublist=$(mkvmerge -J "$1" | jq '.tracks[] | select(.codec=="SubRip/SRT" and .properties.language=="eng" and (.properties.track_name==null or (.properties.track_name | ascii_downcase | contains("comment") | not)))')
for i in $(echo $sublist | jq .id); do
        forcedsub=$(mkvmerge -J "$1" | jq --argjson loopi $i '.tracks[] | select(.id==$loopi) | select(.properties.forced_track != null) | select(.properties.forced_track==true)')
        sdhsub=$(mkvmerge -J "$1" | jq --argjson loopi $i '.tracks[] | select(.id==$loopi) | select(.properties.track_name != null) | select(.properties.track_name | ascii_downcase | contains("sdh"))')
        if [[ ! -z $forcedsub ]]; then
                filename="$1-EXTRACTED-FORCED-SUB-id-$i.srt"
        elif [[ ! -z $sdhsub ]]; then
                filename="$1-EXTRACTED-SDH-SUB-id-$i.srt"
        else
                filename="$1-EXTRACTED-HOPEFULLY-REGULAR-SUB-id-$i.srt" # if the subs arent tagged properly, those can also get named as regular subs
        fi
        mkvextract tracks "$1" $i:"$filename"
done
