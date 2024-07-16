(*[@@@warning "-38-32"]*)
(**)
(*open Riot*)
(**)
(*type Message.t += Hello of string | Foo of string*)
(**)
(*let rec loop () =*)
(*  Format.printf "looping\n";*)
(*  (match receive_any () with*)
(*  | Hello name ->*)
(*      Format.printf "Hello, %s! :D\n" name;*)
(*      Riot.shutdown ()*)
(*  | _ -> Format.printf "Oh no, an unhandled message! D:\n");*)
(*  loop ()*)
(*;;*)

open Riot

let () =
  Riot.run
  @@ fun () ->
  let _ = Logger.start () |> Result.get_ok in
  Runtime.set_log_level (Some Info);
  Logger.set_log_level (Some Info);
  Logger.info (fun f -> f "Hello %s" "chat")
;;

(*Format.printf "spawning listener loop\n";*)
(*let listener_pid = spawn loop in*)
(*Format.printf "sending foo\n";*)
(*Riot.send listener_pid (Foo "lol");*)
(*Format.printf "Going to sleep for 3 seconds\n";*)
(*(*Riot.sleep 3.0;*)*)
(*Format.printf "Waking up\n";*)
(*Format.printf "sending hello\n";*)
(*Riot.send listener_pid (Hello "chat")*)
