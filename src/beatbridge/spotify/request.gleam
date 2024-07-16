import gleam/http.{Https}
import gleam/http/request.{type Request}

pub opaque type SpotifyRequest {
  ApiRequest(Request(String))
  AuthRequest(Request(String))
}

const api_host = "api.spotify.com/v1"

const auth_host = "accounts.spotify.com"

pub fn new_api_request() -> SpotifyRequest {
  request.new()
  |> request.set_scheme(Https)
  |> request.set_host(api_host)
  |> api_request_from_request
}

pub fn new_auth_request() -> SpotifyRequest {
  request.new()
  |> request.set_scheme(Https)
  |> request.set_host(auth_host)
  |> auth_request_from_request
}

fn api_request_from_request(request: Request(String)) -> SpotifyRequest {
  ApiRequest(request)
}

fn auth_request_from_request(request: Request(String)) -> SpotifyRequest {
  AuthRequest(request)
}

pub fn is_auth_request(request: SpotifyRequest) -> Bool {
  case request {
    ApiRequest(_) -> False
    AuthRequest(_) -> True
  }
}

pub fn is_api_request(request: SpotifyRequest) -> Bool {
  case request {
    ApiRequest(_) -> True
    AuthRequest(_) -> False
  }
}
