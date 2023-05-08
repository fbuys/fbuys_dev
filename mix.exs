defmodule FbuysDev.MixProject do
  use Mix.Project

  def project do
    [
      app: :fbuys_dev,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      aliases: aliases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:dart_sass, "~> 0.6"},
      {:esbuild, "~> 0.5"},
      {:makeup_elixir, ">= 0.0.0"},
      {:makeup_erlang, ">= 0.0.0"},
      {:nimble_publisher, "~> 1.0"},
      {:phoenix_live_view, "~> 0.18"},
      { :uuid, "~> 1.1" },
      # Dev and Test
      {:credo, "~> 1.6", only: [:dev, :test], runtime: false}
    ]
  end

  defp aliases() do
    [
      "site.build": [
        "build",
        "sass default --no-source-map --style=compressed",
        "esbuild default --minify"
      ]
    ]
  end
end
