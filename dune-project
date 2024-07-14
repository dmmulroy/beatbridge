(lang dune 3.12)

(name beatbridge)

(generate_opam_files true)

(source
 (github dmmulroy/ocaml-playlist-transfer))

(authors "Dillon Mulroy")

(maintainers "Dillon Mulroy")

(license MIT)

(documentation https://github.com/dmmulroy/ocaml-playlist-transfer)

(package
 (name beatbridge)
 (synopsis "Seamlessly transfer playlists between music streaming services")
 (description
  "Seamlessly transfer playlists between music streaming services")
 (depends
  dune
  ; jose
  ocaml
  uri)
  ; serde
  ; serde_derive
  ; (riot
  ;  (>= 0.0.9)))
 (tags
  (music, ocaml, cli, learning, spotify, apple-music)))

; See the complete stanza docs at https://dune.readthedocs.io/en/stable/dune-files.html#dune-project
