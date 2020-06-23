defmodule CardDeck.MixProject do
  use Mix.Project

  def project do
    [
      app: :card_deck,
      version: "0.1.0",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      name: "card_deck",
      source_url: "https://github.com/dkuku/elxir_card_deck"
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp description() do
    "Implements a basic card deck"
  end

  defp deps do
    [
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

    defp package() do
    [
      # These are the default files included in the package
      files: ~w(lib test .formatter.exs mix.exs README*),
      licenses: ["Apache-2.0"],
      links: %{"GitHub" =>  "https://github.com/dkuku/elxir_card_deck"}
    ]
  end
end
