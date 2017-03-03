#!/bin/bash
# Script to extract hi res pic from unsplash.com
# and save with a random name.
ARGC=$#
if [ "$ARGC" -ne 2 ]; then
        echo "Usage: $0 <unsplashurl>"
        echo "Usage: $0 'https://unsplash.com/?photo=zR-xfZ3Av44'"

        exit 1
fi
URL=$1
curl -sL $URL -o raw.dump
#http://images.unsplash.com/photo-1420768255295-e871cbf6eb81?ixlib=rb-0.3.5&amp;q=80&amp;fm=jpg&amp;crop=entropy&amp;cs=tinysrgb&amp;w=1080&amp;fit=max&amp;s=940d54dad354ef34e0b31eed1982c2ef
IMGURL=`grep 'og:image" content' raw.dump |awk -F 'og:image" content="' {'print $2'} | sed 's/".*//g' `
OUTFILE=`uuid`.jpg
curl -sL $IMGURL -o $OUTFILE
echo $OUTFILE
