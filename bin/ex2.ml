Riot.run
@@ fun () ->
let open Riot in
let _pid = spawn (fun () -> Format.printf "Hello, %a!" Pid.pp (self ())) in
Riot.shutdown ()
