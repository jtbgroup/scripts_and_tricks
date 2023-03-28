# JSON RPC examples for Kodi

These are examples of json rpc queries to interact with Kodi media player. There are examples for the http request and for calling the service **call_method** from Home Assistant integration.

Home assistant event listener: **kodi_call_method_result**

## Get albums

### http call

``` url
http://192.168.1.12:8080/jsonrpc?request={"jsonrpc": "2.0", "method": "JSONRPC.Introspect", "params": {"filter": {"id": "AudioLibrary.GetAlbums", "type": "method"}}, "id": 1}
```

### HA service call

``` yaml
entity_id: media_player.kodi
method: JSONRPC.Introspect
item: {"filter":{"id":"AudioLibrary.GetAlbums", "type": "method"}}
```

or

``` yaml
entity_id: media_player.kodi
method: JSONRPC.Introspect
filter:
  id: "AudioLibrary.GetAlbums"
  type: "method"
```

## Application get properties

### http call

```
http://192.168.1.12:8080/jsonrpc?request={"jsonrpc": "2.0", "method": "Application.GetProperties", "params": {"properties": ["volume"]}, "id": 1}
```

### HA service call

``` yaml
entity_id: media_player.kodi
method: Application.GetProperties
item: {"properties":["volume"]}
```

or

``` yaml
entity_id: media_player.kodi
method: Application.GetProperties
properties:
  - volume
```

## Get Playlist items

### http call

```
http://192.168.1.12:8080/jsonrpc?request={"jsonrpc":"2.0","method":"Playlist.GetItems","id":"1609497939295","params":{"playlistid":0,"properties":["title","thumbnail","file","artist","genre","year","rating","album","track","duration","playcount","dateadded","episode","artistid","albumid","tvshowid"],"limits":{"start":0}}}
```

{"playlistid":0,"properties":["title","thumbnail","file","artist","genre","year","rating","album","track","duration","playcount","dateadded","episode","artistid","albumid","tvshowid"],"limits":{"start":0}}

### HA service call

``` yaml
entity_id: media_player.kodi
method: Playlist.GetItems
item: {"playlistid":0,"properties":["title","thumbnail","file","artist","genre","year","rating","album","track","duration","playcount","dateadded","episode","artistid","albumid","tvshowid"],"limits":{"start":0}}
```

or

``` yaml
entity_id: media_player.kodi
method: Playlist.GetItems
playlistid: 0
properties:
  - title
limits:
  start: 0
```

## Open a playlist in random mode

### http call

```
http://192.168.1.12:8080/jsonrpc?request={"jsonrpc":"2.0","method":"Player.Open","id":"1609497939295","params":{"partymode": "special://profile/playlists/music/Playlist Quiet.xsp"}}
```

{"partymode": "special://profile/playlists/music/Playlist Quiet.xsp"}

### HA service call

``` yaml
entity_id: media_player.kodi
method: Player.Open
item: {"partymode": "special://profile/playlists/music/Playlist Quiet.xsp"}
```

not ok

``` yaml
entity_id: media_player.kodi
method: Player.Open
item:
   - partymode: "special://profile/playlists/music/Playlist Quiet.xsp"
```

## Next item in the playlist

### http call

```
http://192.168.1.12:8080/jsonrpc?request={"jsonrpc":"2.0","method":"Player.GoTo","id":"1609497939295","params":{"playerid": 0, "to": "next"}}
```

### HA service call

``` yaml
entity_id: media_player.raspberrypi
method: Player.GoTo
item: {"playerid": 0, "to": "next"}
```

or

``` yaml
entity_id: media_player.raspberrypi
method: Player.GoTo
playerid: 0
to: "next"
```

or

``` yaml
entity_id: media_player.raspberrypi
method: Player.GoTo
playerid: 0
to: 2 // position is 0 based
```

## Remove item in the playlist

### http call

```
http://192.168.1.12:8080/jsonrpc?request={"jsonrpc":"2.0","method":"Player.Remove","id":"1609497939295","params":{"playerid": 0, "positionid": 3}}
```

### HA service call

``` yaml
entity_id: media_player.raspberrypi
method: Player.GoTo
playerid: 0
to: 2 // position is 0 based
```

## Get Players

### http call

```
http://192.168.1.12:8080/jsonrpc?request={"jsonrpc":"2.0","method":"Player.GetPlayers","id":"1609497939295"} 
```

### HA service call

not ok?????

``` yaml
entity_id: media_player.raspberrypi
method: Player.GetPlayers
```

## Get Active Players
### http call

```
http://192.168.1.12:8080/jsonrpc?request={"jsonrpc":"2.0","method":"Player.GetActivePlayers"} 
```

## Player pause

### http call

```
http://192.168.1.12:8080/jsonrpc?request={"jsonrpc":"2.0","method":"Player.PlayPause", "params":{playerid":"1"}} 
```

### HA service call

``` yaml
entity_id: media_player.kodi
method: Player.PlayPause
playerid: 0
```

## Recently added videos

### HA service call

``` yaml
entity_id: media_player.kodi
method: VideoLibrary.GetRecentlyAddedMovies
properties: 
  - title
  - file
  - year
  - lastplayed
```

## Recently played songs

AudioLibrary.GetRecentlyPlayedSongs doesn't give the expected result. AudioLibrary.GetSongs can achieve the goal.

### HA service call

```
http://192.168.1.12:8080/jsonrpc?request={"jsonrpc":"2.0","method":"AudioLibrary.GetSongs","id":"1611465047410","params":{"properties":["title","artist","album"],"limits":{"start":0,"end":21},"sort":{"method":"lastplayed","order":"descending"}}}
```

## Search song

### http call

```
http://192.168.1.12:8080/jsonrpc?request={"jsonrpc":"2.0","method":"AudioLibrary.GetSongs","id":"1611465047410","params":{"properties":["title","file","thumbnail","artist","artistid","album","albumid","lastplayed","track","year","duration"],"limits":{"start":0,"end":21},"sort":{"method":"track","order":"ascending","ignorearticle":true},"filter":{"operator":"contains","field":"title","value":"karma"}}}
```

Searching songs based on user rating

```
  http://192.168.1.12:8080/jsonrpc?request={"jsonrpc":"2.0","method":"AudioLibrary.GetSongs","id":"1611465047410","params":{"properties":["title","artist","artistid","rating",%20"userrating"],"limits":{"start":0,"end":21},"sort":{"method":"track","order":"ascending","ignorearticle":true},"filter":{"operator":"greaterthan","field":"userrating","value":"0"}}}
```

### HA service call

``` yaml
entity_id: media_player.kodi
method: AudioLibrary.GetSongs
properties: 
  - title
  - file
  - thumbnail
  - artist
  - artistid
  - album
  - albumid
  - lastplayed
  - track
  - year
  - duration   
limits:
  start: 0
  end: 21 
sort:
  method: track
  order: ascending
  ignorearticle: true
filter:
  operator: contains
  field: title
  value: karma
```


## Search Music Videos

### http call

```
http://192.168.1.12:8080/jsonrpc?request={"jsonrpc":"2.0","method":"VideoLibrary.GetMusicVideos","id":"1611465047410","params":{"properties":["title","artist","genre"],"limits":{"start":0,"end":20},"sort":{"method":"title","order":"ascending","ignorearticle":true},"filter":{"or":[{"field":"title","operator":"contains","value":"earth"},{"field":"artist","operator":"contains","value":"Within"}]}}}
```

## Change some ID3 tags

Bad Credentials?

```
http://192.168.1.12:8080/jsonrpc?request={"jsonrpc":"2.0","method":"AudioLibrary.SetSongDetails","id":"123456","params":{"songid":3,"title":"Kryptonite (Remaster)"}}
```


## Other HASS calls

```yaml
service: kodi.call_method
target:
  entity_id: media_player.kodi_67562315fb56bdd0a0391e7bd0ff8b70
data:
  method: Player.Open
  item:
    directory: special://profile/playlists/music/Playlist Quiet.xsp


service: kodi.call_method
target:
  entity_id: media_player.kodi_67562315fb56bdd0a0391e7bd0ff8b70
data:
  method: Player.Open
  item:
    directory: special://profile/playlists/music/quiet metal.m3u
    
    
service: kodi.call_method
target:
  entity_id: media_player.kodi_67562315fb56bdd0a0391e7bd0ff8b70
data:
  method: Playlist.Clear
  playlistid: 0
 
 
service: kodi.call_method
target:
  entity_id: media_player.kodi_67562315fb56bdd0a0391e7bd0ff8b70
data:
  method: Playlist.Add
  playlistid: 0
  item:
     recursive: true
     directory: special://profile/playlists/music/Playlist Quiet.xsp
 
 
service: kodi.call_method
target:
  entity_id: media_player.kodi_67562315fb56bdd0a0391e7bd0ff8b70
data:
  method: Player.Open
  item:
     playlistid: 0
     position: 0
     



service: kodi.call_method
target:
  entity_id: media_player.kodi_67562315fb56bdd0a0391e7bd0ff8b70
data:
  method: Playlist.Add
  playlistid: 0
  item:
     recursive: true
     directory: special://profile/playlists/music/quiet metal.m3u
     
     
     
service: kodi.call_method
target:
  entity_id: media_player.kodi_67562315fb56bdd0a0391e7bd0ff8b70
data:
  method: Playlist.Insert
  playlistid: 0
  position: 3
  item:
     directory: special://profile/playlists/music/quiet metal.m3u
```
