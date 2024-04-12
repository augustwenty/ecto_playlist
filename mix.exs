defmodule EctoPlaylist.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_playlist,
      version: "0.0.3",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      # Hex
      description: "Simple ordered model management with Ecto.",
      package: package(),
      # Docs
      name: "ecto_playlist",
      source_url: "https://github.com/augustwenty/ecto_playlist",
      docs: [
        main: "readme",
        extras: ["README.md": []]
      ],
      groups_for_extras: [
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp package do
    [
      maintainers: ["DJ Daugherty"],
      licenses: ["MIT"],
      links: %{github: "https://github.com/augustwenty/ecto_playlist"},
      files: ~w(lib LICENSE mix.exs README.md)
    ]
  end

  defp deps do
    [
      {:ex_doc, "~> 0.20.2", only: [:dev, :doc], runtime: false},
      {:mix_test_watch, "~> 0.8", only: :dev, runtime: false}
    ]
  end
end
