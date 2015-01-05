c3-cron-cache-data
==================

Shellscript to export and cache several entities from the C3 congress wiki and to download and cache the Fahrplan from the frab system.

## Client

Screen of the [31c3 wiki app](https://itunes.apple.com/de/app/31c3/id949584773?mt=8) which used the cached data extensively.

![image](https://github.com/trailblazr/c3-cron-cache-data/blob/master/31c3_client.png?raw=true)

## Features

* requests JSON data from semantic mediawiki using the **Special Page Ask API**
* stores and fixes the downloaded JSON **making relative URLs absolute**
* downloads and stores the Fahrplan XML **fetching the latest XML from the frab system**

## Installation

1. download script to a dedicated directory
2. create/edit a crontab entry using crontab -e which does get called every 10 minutes or so
3. call the script in this entry (be sure executable flags/permissions are set on the scriptfile)
4. have the data cached in dedicated data folder (check if permissions are correct to be accessed from outside)

## Todo

* Take care of securing the script with correct permissions to not beeing misused through your webserver while the data files should be available through the webserver
* **Bonus challenge:** secure all this stuff using TLS
* Check if downloads are failing and react accordingly to NOT overwrite cached data with null/trash stuff

## License

All code is published under CC0.

## Attribution

The code was put together by **trailblazr** to serve the 31c3 wiki app client with needed data.