import beatbridge/extended/dynamic_ext
import gleam/dynamic.{type Decoder}
import gleam/json.{type DecodeError}
import gleam/uri.{type Uri}

pub type Playlist {
  Playlist(id: String, name: String, tracks: Tracks)
}

fn playlist_decoder() -> Decoder(Playlist) {
  dynamic.decode3(
    Playlist,
    dynamic.field("id", dynamic.string),
    dynamic.field("name", dynamic.string),
    dynamic.field("tracks", tracks_decoder()),
  )
}

pub type Tracks {
  Tracks(href: Uri, items: List(Item))
}

fn tracks_decoder() -> Decoder(Tracks) {
  dynamic.decode2(
    Tracks,
    dynamic.field("href", dynamic_ext.uri),
    dynamic.field("items", dynamic.list(of: item_decoder())),
  )
}

pub type Item {
  Item(track: Track)
}

fn item_decoder() -> Decoder(Item) {
  dynamic.decode1(Item, dynamic.field("track", track_decoder()))
}

pub type TrackExternalIds {
  TrackExternalIds(isrc: String)
}

fn track_external_ids_decoder() -> Decoder(TrackExternalIds) {
  dynamic.decode1(TrackExternalIds, dynamic.field("isrc", dynamic.string))
}

pub type Track {
  Track(id: String, external_ids: TrackExternalIds, name: String, uri: String)
}

fn track_decoder() -> Decoder(Track) {
  dynamic.decode4(
    Track,
    dynamic.field("id", dynamic.string),
    dynamic.field("external_ids", track_external_ids_decoder()),
    dynamic.field("name", dynamic.string),
    dynamic.field("uri", dynamic.string),
  )
}

pub fn playlist_from_json(json_string: String) -> Result(Playlist, DecodeError) {
  json.decode(json_string, playlist_decoder())
}
