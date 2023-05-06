import Config

config :esbuild,
  version: "0.14.41",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../dist/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__)
  ]

config :dart_sass,
  version: "1.61.0",
  default: [
    args: ~w(css/app.scss ../dist/assets/app.css),
    cd: Path.expand("../assets", __DIR__)
  ]
