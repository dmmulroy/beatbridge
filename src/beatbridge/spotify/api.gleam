import beatbridge/error.{type SpotifyError, HttpRequestError}
import beatbridge/spotify/request.{type SpotifyRequest}
import beatbridge/spotify/response.{type SpotifyResponse}
import gleam/httpc
import gleam/result

pub fn send(
  request: SpotifyRequest,
) -> Result(SpotifyResponse(String), SpotifyError) {
  request
  |> request.to_http_request
  |> httpc.send
  |> result.map(response.from_http_response)
  |> result.map_error(HttpRequestError)
}
