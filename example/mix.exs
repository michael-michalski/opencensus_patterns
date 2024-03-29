defmodule Example.MixProject do
  use Mix.Project

  def project do
    [
      app: :example,
      version: "0.1.0",
      elixir: "~> 1.9",
      start_permanent: Mix.env() == :prod,
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
      {:opencensus, git: "https://github.com/census-instrumentation/opencensus-erlang.git", override: true},
      {:opencensus, "~> 0.8"},
      {:opencensus_zipkin, "~> 0.2.0"},
      {:opencensus_patterns, "~> 0.3.0"},
      {:dialyxir,            "~> 1.0.0-rc.6", only: [:dev, :test], runtime: false},
    ]
  end
end
