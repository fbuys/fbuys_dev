import Config

config :esbuild,
  version: "0.14.41",
  default: [
    args: ~w(js/app.js),
    cd: Path.expand("../assets", __DIR__)
  ]

config :dart_sass,
  version: "1.61.0",
  default: [
    args: ~w(css/app.scss ../dist/assets/app.css),
    cd: Path.expand("../assets", __DIR__)
  ]
