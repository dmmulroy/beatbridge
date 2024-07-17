import beatbridge/error.{
  type SpotifyError, HttpResponseDecodeError, HttpResponseError,
}
import gleam/dynamic.{type Decoder}
import gleam/http.{type Header}
import gleam/http/response.{type Response, Response}
import gleam/json
import gleam/result

pub opaque type SpotifyResponse(data) {
  SpotifyResponse(Response(data))
}

type SpotifyErrorResponse {
  SpotifyErrorResponse(status: Int, message: String)
}

fn error_decoder() -> Decoder(SpotifyErrorResponse) {
  dynamic.decode2(
    SpotifyErrorResponse,
    dynamic.field("status", dynamic.int),
    dynamic.field("message", dynamic.string),
  )
}

pub fn from_http_response(response: Response(String)) -> SpotifyResponse(String) {
  SpotifyResponse(response)
}

fn get_http_response(api_response: SpotifyResponse(data)) -> Response(data) {
  case api_response {
    SpotifyResponse(response) -> response
  }
}

pub fn get_body(api_response: SpotifyResponse(data)) -> data {
  get_http_response(api_response).body
}

pub fn get_headers(api_response: SpotifyResponse(data)) -> List(Header) {
  let http_response = get_http_response(api_response)
  http_response.headers
}

pub fn get_data(
  api_response: SpotifyResponse(String),
  data_decoder: Decoder(data),
) -> Result(data, SpotifyError) {
  let body = get_body(api_response)

  let error = json.decode(body, error_decoder())

  case error {
    Ok(SpotifyErrorResponse(status, message)) ->
      Error(HttpResponseError(status, message))
    _ ->
      body
      |> json.decode(dynamic.any([data_decoder, data_decoder]))
      |> result.map_error(HttpResponseDecodeError)
  }
}
