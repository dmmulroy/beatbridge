import gleam/dynamic
import gleam/json.{type DecodeError as JsonDecodeError, type Json}
import gleam/result

pub type Scope {
  // Images
  UgcImageUpload

  // Spotify Connect
  UserReadPlaybackState
  UserModifyPlaybackState
  UserReadCurrentlyPlaying

  // Playback
  AppRemoteControl
  Streaming

  // Playlists
  PlaylistReadPrivate
  PlaylistReadCollaborative
  PlaylistModifyPrivate
  PlaylistModifyPublic

  // Follow
  UserFollowModify
  UserFollowRead

  // Listening History
  UserReadPlaybackPosition
  UserTopRead
  UserReadRecentlyPlayed

  // Library
  UserLibraryModify
  UserLibraryRead

  // Users
  UserReadEmail
  UserReadPrivate

  // Open Access
  UserSoaLink
  UserSoaUnlink
  SoaManageEntitlements
  SoaManagePartner
  SoaCreatePartner
}

pub type ScopeError {
  InvalidScope(String)
  DecodeError(JsonDecodeError)
}

pub const scopes: List(Scope) = [
  UgcImageUpload, UserReadPlaybackState, UserModifyPlaybackState,
  UserReadCurrentlyPlaying, AppRemoteControl, Streaming, PlaylistReadPrivate,
  PlaylistReadCollaborative, PlaylistModifyPrivate, PlaylistModifyPublic,
  UserFollowModify, UserFollowRead, UserReadPlaybackPosition, UserTopRead,
  UserReadRecentlyPlayed, UserLibraryModify, UserLibraryRead, UserReadEmail,
  UserReadPrivate, UserSoaLink, UserSoaUnlink, SoaManageEntitlements,
  SoaManagePartner, SoaCreatePartner,
]

pub fn from_string(str: String) -> Result(Scope, ScopeError) {
  case str {
    "ugc-image-upload" -> Ok(UgcImageUpload)
    "user-read-playback-state" -> Ok(UserReadPlaybackState)
    "user-modify-playback-state" -> Ok(UserModifyPlaybackState)
    "user-read-currently-playing" -> Ok(UserReadCurrentlyPlaying)
    "app-remote-control" -> Ok(AppRemoteControl)
    "streaming" -> Ok(Streaming)
    "playlist-read-private" -> Ok(PlaylistReadPrivate)
    "playlist-read-collaborative" -> Ok(PlaylistReadCollaborative)
    "playlist-modify-private" -> Ok(PlaylistModifyPrivate)
    "playlist-modify-public" -> Ok(PlaylistModifyPublic)
    "user-follow-modify" -> Ok(UserFollowModify)
    "user-follow-read" -> Ok(UserFollowRead)
    "user-read-playback-position" -> Ok(UserReadPlaybackPosition)
    "user-top-read" -> Ok(UserTopRead)
    "user-read-recently-played" -> Ok(UserReadRecentlyPlayed)
    "user-library-modify" -> Ok(UserLibraryModify)
    "user-library-read" -> Ok(UserLibraryRead)
    "user-read-email" -> Ok(UserReadEmail)
    "user-read-private" -> Ok(UserReadPrivate)
    "user-soa-link" -> Ok(UserSoaLink)
    "user-soa-unlink" -> Ok(UserSoaUnlink)
    "soa-manage-entitlements" -> Ok(SoaManageEntitlements)
    "soa-manage-partner" -> Ok(SoaManagePartner)
    "soa-create-partner" -> Ok(SoaCreatePartner)
    _ -> Error(InvalidScope(str))
  }
}

pub fn to_string(scope: Scope) -> String {
  case scope {
    UgcImageUpload -> "ugc-image-upload"
    UserReadPlaybackState -> "user-read-playback-state"
    UserModifyPlaybackState -> "user-modify-playback-state"
    UserReadCurrentlyPlaying -> "user-read-currently-playing"
    AppRemoteControl -> "app-remote-control"
    Streaming -> "streaming"
    PlaylistReadPrivate -> "playlist-read-private"
    PlaylistReadCollaborative -> "playlist-read-collaborative"
    PlaylistModifyPrivate -> "playlist-modify-private"
    PlaylistModifyPublic -> "playlist-modify-public"
    UserFollowModify -> "user-follow-modify"
    UserFollowRead -> "user-follow-read"
    UserReadPlaybackPosition -> "user-read-playback-position"
    UserTopRead -> "user-top-read"
    UserReadRecentlyPlayed -> "user-read-recently-played"
    UserLibraryModify -> "user-library-modify"
    UserLibraryRead -> "user-library-read"
    UserReadEmail -> "user-read-email"
    UserReadPrivate -> "user-read-private"
    UserSoaLink -> "user-soa-link"
    UserSoaUnlink -> "user-soa-unlink"
    SoaManageEntitlements -> "soa-manage-entitlements"
    SoaManagePartner -> "soa-manage-partner"
    SoaCreatePartner -> "soa-create-partner"
  }
}

pub fn decoder() -> dynamic.Decoder(Scope) {
  fn(data: dynamic.Dynamic) {
    use string <- result.try(dynamic.string(data))

    string
    |> from_string
    |> result.replace_error([
      dynamic.DecodeError(
        expected: "Scope",
        found: "String(" <> string <> ")",
        path: [],
      ),
    ])
  }
}

pub fn to_json(scope: Scope) -> Json {
  scope
  |> to_string
  |> json.string
}

pub fn from_json(json_string: String) -> Result(Scope, ScopeError) {
  json_string
  |> json.decode(dynamic.string)
  |> result.map_error(DecodeError)
  |> result.try(from_string)
}
