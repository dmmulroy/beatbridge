import gleam/dynamic.{type Dynamic}
import gleam/json.{type DecodeError}

pub type SpotifyError {
  HttpRequestError(Dynamic)
  HttpResponseDecodeError(DecodeError)
  HttpResponseError(status: Int, message: String)
}
