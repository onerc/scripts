sublist=$(mkvmerge -J "$1" | jq '.tracks[] | select(.codec=="SubRip/SRT" and .properties.language=="eng" and (.properties.track_name==null or (.properties.track_name | ascii_downcase | contains("comment") | not)))')
for i in $(echo $sublist | jq .id); do
        forcedsubs=$(mkvmerge -J "$1" | jq --argjson loopi $i '.tracks[] | select(.id==$loopi) | select(.properties.forced_track != null) | select(.properties.forced_track==true)')
        sdhsubs=$(mkvmerge -J "$1" | jq --argjson loopi $i '.tracks[] | select(.id==$loopi) | select(.properties.track_name != null) | select(.properties.track_name | ascii_downcase | contains("sdh"))')
        if [[ ! -z $forcedsubs ]]; then
                filename="$1-EXTRACTED-FORCED-SUBS-id-$i.srt"
        elif [[ ! -z $sdhsubs ]]; then
                filename="$1-EXTRACTED-SDH-SUBS-id-$i.srt"
        else
                filename="$1-EXTRACTED-HOPEFULLY-REGULAR-SUBS-id-$i.srt"
        fi
        mkvextract tracks "$1" $i:"$filename"
done
