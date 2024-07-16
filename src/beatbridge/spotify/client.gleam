import beatbridge/spotify/access_token.{type AccessToken}

pub opaque type Client {
  Client(access_token: AccessToken, client_id: String, client_secret: String)
}

pub const new = Client
