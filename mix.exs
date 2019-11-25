defmodule OpencensusPatterns.MixProject do
  use Mix.Project

  def project do
    [
      app: :opencensus_patterns,
      version: "0.2.1",
      elixir: "~> 1.7",
      start_permanent: Mix.env() == :prod,
      docs: [extras: ["README.md"], main: "readme"],
      deps: deps(),
      package: package(),
      description: "Utility functions for tracing."
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
      {:credo, "~> 1.0", only: [:dev]},
      {:ex_doc, ">= 0.0.0", only: :dev}
    ]
  end

  defp package do
    [
      name: "opencensus_patterns",
      files: ["lib/*", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["Michael Michalski"],
      licenses: ["MIT License"],
      links: %{"GitHub" => "https://github.com/michael-michalski/opencensus_patterns"}
    ]
  end
end
