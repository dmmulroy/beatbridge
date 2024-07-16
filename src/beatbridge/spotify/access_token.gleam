import beatbridge/spotify/scope.{type Scope}
import gleam/erlang

pub opaque type AccessToken {
  AccessToken(
    access_token: String,
    token_type: String,
    scopes: List(Scope),
    expires_at: Int,
    refresh_token: String,
  )
}

pub const new = AccessToken

pub fn value(access_token: AccessToken) -> String {
  access_token.access_token
}

pub fn refresh_token(access_token: AccessToken) -> String {
  access_token.refresh_token
}

pub fn scopes(access_token: AccessToken) -> List(Scope) {
  access_token.scopes
}

pub fn expires_at(access_token: AccessToken) -> Int {
  access_token.expires_at
}

pub fn is_expired(access_token: AccessToken) -> Bool {
  let now = erlang.system_time(erlang.Second)

  now > access_token.expires_at
}

pub fn set_expires_at(access_token: AccessToken, expires_at: Int) -> AccessToken {
  AccessToken(..access_token, expires_at: expires_at)
}

pub fn set_refresh_token(
  access_token: AccessToken,
  refresh_token: String,
) -> AccessToken {
  AccessToken(..access_token, refresh_token: refresh_token)
}
