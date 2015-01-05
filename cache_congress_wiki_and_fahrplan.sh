#!/bin/bash

#   Name: cache_congress_wiki_and_fahrplan.sh
# Author: trailblazr
#   Date: 29.12.2014
# Client: https://itunes.apple.com/de/app/31c3/id949584773?mt=8
#
# SCRIPT TO BE ADDED TO CRONTAB ENTRY ON A UNIX BOX
# USUALLY POLLS EVERY 10 MINUTES AND
# JUST DOWNLOADS JSON AND XML FROM WIKI AND FRAB
# FOR 31C3 in 2014, YOU MIGHT ADJUST IT TO POLL
# FUTURE DATA IN THE SAME WAY...


basedir=`dirname $0`
output=$basedir/data

# CREATE DIRS
mkdir -p $output

# CANCEL SCRIPT ON ERROR
# set -e

# FUNCTION TO DOWNLOAD CONTENT AND FIX RELATIVE URLS (IN WIKI JSON) TO ABSOLUTE ONES
# BYPASSES SSL CHECKS TO COPE WITH SELFSIGNED CERTS WHICH ARE USED.
# TODO: ADD CHECK FOR HTTP-STATUS-CODE AND ERRORS ON FETCHING WRONG/NULL CONTENT
function download {
  url=$1
  out=$2
  tmp=/tmp/$$.tmp

  echo $url
  curl --silent --insecure --fail "$url" | sed 's/\"\/\/events.ccc.de/\"https:\/\/events.ccc.de/' > $tmp
  if [ -s $tmp ]
  then
	 echo 'WE GOT DATA FOR... '
	 echo $out
	 echo 'WRITING TO FINAL DESTINATION...'
 	 mv $tmp $out
  fi
}

#
# DOWNLOAD SEQUENTIALLY FROM: Semantic Media Wiki & frab System
#

# SCHEDULE / EVENTS
download "https://events.ccc.de/congress/2014/Fahrplan/schedule.xml" $output/schedule.xml


# DOWNLOAD USERS (SEVERAL BATCHES)
download "http://events.ccc.de/congress/2014/wiki/index.php?title=Special%3AAsk&q=%5B%5BCategory%3AUser%5D%5D&po=%3FCreation+date%0D%0A%3FModification+date%0D%0A%3FHas+phone+number%0D%0A%3FWorking+on%0D%0A%3FPart+of%0D%0A%3FHas+website%0D%0A%3FHas+mail+contact%0D%0A%3FLives+in+city%0D%0A%3FLives+in+continent%0D%0A%3FLives+in+country%0D%0A%3FSpeaks+language%0D%0A&eq=yes&p%5Bformat%5D=json&sort_num=&order_num=ASC&p%5Blimit%5D=500&p%5Boffset%5D=0&p%5Blink%5D=none&p%5Bsort%5D=&p%5Border%5D%5Basc%5D=1&p%5Bheaders%5D=show&p%5Bmainlabel%5D=&p%5Bintro%5D=&p%5Boutro%5D=&p%5Bsearchlabel%5D=%E2%80%A6+further+results&p%5Bdefault%5D=&eq=yes" $output/users_0.json

download "http://events.ccc.de/congress/2014/wiki/index.php?title=Special%3AAsk&q=%5B%5BCategory%3AUser%5D%5D&po=%3FCreation+date%0D%0A%3FModification+date%0D%0A%3FHas+phone+number%0D%0A%3FWorking+on%0D%0A%3FPart+of%0D%0A%3FHas+website%0D%0A%3FHas+mail+contact%0D%0A%3FLives+in+city%0D%0A%3FLives+in+continent%0D%0A%3FLives+in+country%0D%0A%3FSpeaks+language%0D%0A&eq=yes&p%5Bformat%5D=json&sort_num=&order_num=ASC&p%5Blimit%5D=500&p%5Boffset%5D=500&p%5Blink%5D=none&p%5Bsort%5D=&p%5Border%5D%5Basc%5D=1&p%5Bheaders%5D=show&p%5Bmainlabel%5D=&p%5Bintro%5D=&p%5Boutro%5D=&p%5Bsearchlabel%5D=%E2%80%A6+further+results&p%5Bdefault%5D=&eq=yes" $output/users_500.json

download "http://events.ccc.de/congress/2014/wiki/index.php?title=Special%3AAsk&q=%5B%5BCategory%3AUser%5D%5D&po=%3FCreation+date%0D%0A%3FModification+date%0D%0A%3FHas+phone+number%0D%0A%3FWorking+on%0D%0A%3FPart+of%0D%0A%3FHas+website%0D%0A%3FHas+mail+contact%0D%0A%3FLives+in+city%0D%0A%3FLives+in+continent%0D%0A%3FLives+in+country%0D%0A%3FSpeaks+language%0D%0A&eq=yes&p%5Bformat%5D=json&sort_num=&order_num=ASC&p%5Blimit%5D=500&p%5Boffset%5D=1000&p%5Blink%5D=none&p%5Bsort%5D=&p%5Border%5D%5Basc%5D=1&p%5Bheaders%5D=show&p%5Bmainlabel%5D=&p%5Bintro%5D=&p%5Boutro%5D=&p%5Bsearchlabel%5D=%E2%80%A6+further+results&p%5Bdefault%5D=&eq=yes" $output/users_1000.json

download "http://events.ccc.de/congress/2014/wiki/index.php?title=Special%3AAsk&q=%5B%5BCategory%3AUser%5D%5D&po=%3FCreation+date%0D%0A%3FModification+date%0D%0A%3FHas+phone+number%0D%0A%3FWorking+on%0D%0A%3FPart+of%0D%0A%3FHas+website%0D%0A%3FHas+mail+contact%0D%0A%3FLives+in+city%0D%0A%3FLives+in+continent%0D%0A%3FLives+in+country%0D%0A%3FSpeaks+language%0D%0A&eq=yes&p%5Bformat%5D=json&sort_num=&order_num=ASC&p%5Blimit%5D=500&p%5Boffset%5D=1500&p%5Blink%5D=none&p%5Bsort%5D=&p%5Border%5D%5Basc%5D=1&p%5Bheaders%5D=show&p%5Bmainlabel%5D=&p%5Bintro%5D=&p%5Boutro%5D=&p%5Bsearchlabel%5D=%E2%80%A6+further+results&p%5Bdefault%5D=&eq=yes" $output/users_1500.json

# DOWNLOAD HACKERSPACES (SEVERAL BATCHES)
download "http://events.ccc.de/congress/2014/wiki/index.php?title=Special%3AAsk&q=%5B%5BHackerspace%3A%2B%5D%5D++&po=&eq=yes&p%5Bformat%5D=json&sort_num=&order_num=ASC&p%5Blimit%5D=500&p%5Boffset%5D=0&p%5Blink%5D=none&p%5Bsort%5D=&p%5Bheaders%5D=show&p%5Bmainlabel%5D=label&p%5Bintro%5D=&p%5Boutro%5D=&p%5Bsearchlabel%5D=%E2%80%A6+further+results&p%5Bdefault%5D=&eq=yes" $output/hackerspaces.json

download "http://hackerspaces.org/w/index.php?title=Special%3AAsk&q=%5B%5BCategory%3AHackerspace%5D%5D&po=%3FCity%0D%0A%3FState%0D%0A%3FCountry%0D%0A%3FWebsite%0D%0A%3FLocation%0D%0A&eq=yes&p%5Bformat%5D=json&sort_num=&order_num=ASC&p%5Blimit%5D=500&p%5Boffset%5D=0&p%5Blink%5D=all&p%5Bsort%5D=&p%5Border%5D%5Bascending%5D=1&p%5Bheaders%5D=show&p%5Bmainlabel%5D=&p%5Bintro%5D=&p%5Boutro%5D=&p%5Bsearchlabel%5D=%E2%80%A6+further+results&p%5Bdefault%5D=&eq=yes" $output/hackerspaces_org_0.json

download "http://hackerspaces.org/w/index.php?title=Special%3AAsk&q=%5B%5BCategory%3AHackerspace%5D%5D&po=%3FCity%0D%0A%3FState%0D%0A%3FCountry%0D%0A%3FWebsite%0D%0A%3FLocation%0D%0A&eq=yes&p%5Bformat%5D=json&sort_num=&order_num=ASC&p%5Blimit%5D=500&p%5Boffset%5D=500&p%5Blink%5D=all&p%5Bsort%5D=&p%5Border%5D%5Bascending%5D=1&p%5Bheaders%5D=show&p%5Bmainlabel%5D=&p%5Bintro%5D=&p%5Boutro%5D=&p%5Bsearchlabel%5D=%E2%80%A6+further+results&p%5Bdefault%5D=&eq=yes" $output/hackerspaces_org_500.json

download "http://hackerspaces.org/w/index.php?title=Special%3AAsk&q=%5B%5BCategory%3AHackerspace%5D%5D&po=%3FCity%0D%0A%3FState%0D%0A%3FCountry%0D%0A%3FWebsite%0D%0A%3FLocation%0D%0A&eq=yes&p%5Bformat%5D=json&sort_num=&order_num=ASC&p%5Blimit%5D=500&p%5Boffset%5D=1000&p%5Blink%5D=all&p%5Bsort%5D=&p%5Border%5D%5Bascending%5D=1&p%5Bheaders%5D=show&p%5Bmainlabel%5D=&p%5Bintro%5D=&p%5Boutro%5D=&p%5Bsearchlabel%5D=%E2%80%A6+further+results&p%5Bdefault%5D=&eq=yes" $output/hackerspaces_org_1000.json

download "http://hackerspaces.org/w/index.php?title=Special%3AAsk&q=%5B%5BCategory%3AHackerspace%5D%5D&po=%3FCity%0D%0A%3FState%0D%0A%3FCountry%0D%0A%3FWebsite%0D%0A%3FLocation%0D%0A&eq=yes&p%5Bformat%5D=json&sort_num=&order_num=ASC&p%5Blimit%5D=500&p%5Boffset%5D=1500&p%5Blink%5D=all&p%5Bsort%5D=&p%5Border%5D%5Bascending%5D=1&p%5Bheaders%5D=show&p%5Bmainlabel%5D=&p%5Bintro%5D=&p%5Boutro%5D=&p%5Bsearchlabel%5D=%E2%80%A6+further+results&p%5Bdefault%5D=&eq=yes" $output/hackerspaces_org_1500.json

# DOWNLOAD LIGHTNINGS
download "http://events.ccc.de/congress/2014/wiki/index.php?title=Special%3AAsk&q=%5B%5BCategory%3ALightning%5D%5D&po=%3FCreation+date%0D%0A%3FHas+description%0D%0A%3FHas+desired+session%0D%0A%3FHas+desired+timeframe%0D%0A%3FHas+duration%0D%0A%3FHas+lightning+tag%0D%0A%3FHas+orga+contact%0D%0A%3FHas+website%0D%0A%3FHeld+in+language%0D%0A%3FIs+organized+by%0D%0A&eq=yes&p%5Bformat%5D=json&sort_num=&order_num=ASC&p%5Blimit%5D=500&p%5Boffset%5D=&p%5Blink%5D=all&p%5Bsort%5D=&p%5Bheaders%5D=show&p%5Bmainlabel%5D=&p%5Bintro%5D=&p%5Boutro%5D=&p%5Bsearchlabel%5D=%E2%80%A6+further+results&p%5Bdefault%5D=&eq=yes" $output/lightnings.json

# DOWNLOAD PROJECTS
download "http://events.ccc.de/congress/2014/wiki/index.php?title=Special%3AAsk&q=%5B%5BCategory%3AProjects%5D%5D&po=%3FHas+project+tag%0D%0A%3FHas+description%0D%0A%3FHas+website%0D%0A%3FLocated+at+assembly%0D%0A%3FCreation+date&eq=yes&p%5Bformat%5D=json&sort_num=&order_num=ASC&p%5Blimit%5D=500&p%5Boffset%5D=&p%5Blink%5D=none&p%5Bsort%5D=&p%5Border%5D%5Bascending%5D=1&p%5Bheaders%5D=show&p%5Bmainlabel%5D=&p%5Bintro%5D=&p%5Boutro%5D=&p%5Bsearchlabel%5D=%E2%80%A6+further+results&p%5Bdefault%5D=&eq=yes" $output/projects.json

# DOWNLOAD ROOMS
download "http://events.ccc.de/congress/2014/wiki/index.php?title=Special%3AAsk&q=%5B%5BRoom%3A%2B%5D%5D+%5B%5BHas+size%3A%3A%210%5D%5D&po=%3FCreation+date%0D%0A%3FHas+number+of+seats%0D%0A%3FLocated+on+level%0D%0A%3FHas+size%0D%0A%3FHas+equipment%0D%0A%3FHas+notes%0D%0A&eq=yes&p%5Bformat%5D=json&sort_num=&order_num=ASC&p%5Blimit%5D=500&p%5Boffset%5D=&p%5Blink%5D=none&p%5Bsort%5D=&p%5Border%5D%5Bascending%5D=1&p%5Bheaders%5D=show&p%5Bmainlabel%5D=&p%5Bintro%5D=&p%5Boutro%5D=&p%5Bsearchlabel%5D=%E2%80%A6+further+results&p%5Bdefault%5D=&eq=yes" $output/rooms.json

# DOWNLOAD ASSEMBLIES
download "http://events.ccc.de/congress/2014/wiki/index.php?title=Special%3AAsk&q=%5B%5BCategory%3AAssembly%5D%5D&po=%3FHas+website%0D%0A%3FHas+contact%0D%0A%3FHas+description%0D%0A%3FSubassembly+of%0D%0A%3FRelated+to+assembly%0D%0A%3FHas+assembly+tag%0D%0A%3FProvides+session+location%0D%0A%3FHas+orga+contact%0D%0A%3FBrings%0D%0A%3FNeeds+seats%0D%0A%3FNeeds+extra+seats%0D%0A%3FPlans+sessions%0D%0A%3FHas+assembly+specification%0D%0A%3FHas+planning+notes%0D%0A%3FCreation+date&eq=yes&p%5Bformat%5D=json&sort_num=&order_num=ASC&p%5Blimit%5D=500&p%5Boffset%5D=&p%5Blink%5D=none&p%5Bsort%5D=&p%5Border%5D%5Bascending%5D=1&p%5Bheaders%5D=show&p%5Bmainlabel%5D=&p%5Bintro%5D=&p%5Boutro%5D=&p%5Bsearchlabel%5D=%E2%80%A6+further+results&p%5Bdefault%5D=&eq=yes" $output/assemblies.json

# DOWNLOAD SESSIONS
download "http://events.ccc.de/congress/2014/wiki/index.php?title=Special%3AAsk&q=%5B%5BCategory%3ASession%5D%5D&po=%3FHas+session+tag%0D%0A%3FIs+for+kids%0D%0A%3FHas+description%0D%0A%3FHas+website%0D%0A%3FHas+session+type%0D%0A%3FHas+session+keyword%0D%0A%3FProcessed+by+assembly%0D%0A%3FIs+organized+by%0D%0A%3FHeld+in+language%0D%0A%3FIs+related+to%0D%0A%3FCreation+date&eq=yes&p%5Bformat%5D=json&sort_num=&order_num=ASC&p%5Blimit%5D=500&p%5Boffset%5D=&p%5Blink%5D=none&p%5Bsort%5D=&p%5Border%5D%5Bascending%5D=1&p%5Bheaders%5D=show&p%5Bmainlabel%5D=&p%5Bintro%5D=&p%5Boutro%5D=&p%5Bsearchlabel%5D=%E2%80%A6+further+results&p%5Bdefault%5D=&eq=yes" $output/sessions.json


# STANDARD UNIX (DEPLOYMENT)
echo '{"date_last_cached":"'`date --iso-8601=seconds`'"}' > $output/status_updated.json

# OS X (LOCAL TESTING)
#echo '{"date_last_cached":"'`date -u +\"%Y-%m-%dT%H:%M:%SZ\"`'"}' > $output/status_updated.json
