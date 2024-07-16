[@@@warning "-38"]

open Riot

type Message.t += Hello_world

let () =
  Riot.run (fun () ->
      match receive_any () with
      | Hello_world -> print_endline "Hello, World! :D"
      | _ -> print_endline "Oh no, an unhandled message! D:")
;;
