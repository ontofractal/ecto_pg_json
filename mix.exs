defmodule EctoPgJson.MixProject do
  use Mix.Project

  def project do
    [
      app: :ecto_pg_json,
      version: "0.2.0",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:ecto, "~> 3.0"},
      {:ecto_sql, "~> 3.0"},
      {:postgrex, ">= 0.0.0"},
      {:jason, "~> 1.0"},
      {:mix_test_watch, "~> 0.8", only: :dev, runtime: false}  
    ]
  end
end
