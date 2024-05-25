defmodule Bcryptrs.MixProject do
  use Mix.Project

  @version "0.0.2"
  def project do
    [
      app: :bcryptrs,
      version: @version,
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      description: description()
    ]
  end

  defp description() do
    "bcryptrs is a drop in replacement for bcrypt_elixir that does not require C compiler"
  end

  defp package() do
    [
      # These are the default files included in the package
      files: [
        "lib",
        "mix.exs",
        "native/bcryptrs_native/.cargo",
        "native/bcryptrs_native/src",
        "native/bcryptrs_native/Cargo*",
        "checksum-*.exs",
        "README*"
      ],
      licenses: ["Apache-2.0"],
      links: %{
        "bcrypt_elixir" => "https://hexdocs.pm/bcrypt_elixir",
        "github" => "https://github.com/dkuku/bcryptrs"
      }
    ]
  end

  def application do
    []
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:stream_data, "~> 1.0", only: :test},
      {:bcrypt_elixir, "~> 3.0", only: :test},
      {:rustler, "~> 0.32.1", optional: true},
      {:rustler_precompiled, "~> 0.7", only: [:dev, :test], runtime: false},
      {:ex_doc, "~> 0.33", only: :dev, runtime: false}
    ]
  end
end
