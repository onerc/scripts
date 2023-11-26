sublist=$(mkvmerge -J "$1" | jq '.tracks[] | select(.codec=="SubRip/SRT" and .properties.language=="eng").id')
for i in $sublist; do
        forcedsubs=$(mkvmerge -J "$1" | jq --argjson loopi $i '.tracks[] | select(.id==$loopi) | select(.properties.forced_track != null) | select(.properties.forced_track==true)')
        sdhsubs=$(mkvmerge -J "$1" | jq --argjson loopi $i '.tracks[] | select(.id==$loopi) | select(.properties.track_name != null) | select(.properties.track_name | contains("SDH"))')
        if [[ ! -z $forcedsubs ]]; then
                filename="$1-EXTRACTED-FORCED-SUBS.srt"
        elif [[ ! -z $sdhsubs ]]; then
                filename="$1-EXTRACTED-SDH-SUBS.srt"
        else
                filename="$1-HOPEFULLY-REGULAR-SUBS.srt"
        fi
        mkvextract tracks "$1" $i:"$filename"
done
