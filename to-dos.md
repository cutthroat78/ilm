# ilm (my cli music player)
- remote songs can be saved on server and accessed using sshfs or downloaded to machine (and then add option to delete copy or keep it)
- online songs are streamed from youtube or elsewhere (add option to download and play locally and have option to delete local version of song)
- echo of song info and notify-send when before a song plays
- for personal: have to listen to be ~/.ilm/to-listen-to.csv
- have local songs download ~/.ilm/local
- make ilm use default vars if conf file doesn't exist
- ID,Link,Song,Album,Artist,Genre,Date Added,Listens,Full Listens
## Commands
- ilm add - add song to $csvfile
- ilm move - move local songs to remote folder
- ilm download - download song (from online or remote)
- ilm play {id,album,genre,artist} - play song with id/album, shuffle genre,artist
- ilm play local {id,album,genre,artist} - play local song
- ilm queue {id} - add song with id to queue
- ilm shuffle - shuffle whole list
- ilm search {song,album,artist,genre,all} - grep search term on file
- '-d' will use dmenu/sxmo_dmenu.sh
- '-l' display link(s)
- '-f' will change from default csv file
- '-tlt' will use to-listen-to.csv instead of music.csv