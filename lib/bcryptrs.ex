defmodule Bcryptrs do
  @moduledoc """
  Bcryptrs is a drop in replacement for bcrypt_elixir that does not require C compiler

  To use it simply add the dependency to mix.exs
  and replace every usage of Bcrypt with Bcryptrs

  Don't forget to removew bcrypt_elixir from mix.exs and mix.lock
  """
  @doc """
  Returns a hash of probvided password.
  Optionally supports also a second argumet which is the cost

  ```elixir
    hashed_password = Bcryptrs.hash_pwd_salt(password)
  ```
  """
  defdelegate hash_pwd_salt(password), to: Bcryptrs.Native
  defdelegate hash_pwd_salt(password, cost), to: Bcryptrs.Native

  @doc """
  Runs hashing alghoritm in constant time.
  Used to avoid timing attacks against actors that check if an user exist

  ```elixir
  case User.get(id) do
    nil -> Bcryptrs.no_user_verify()
    user -> Bcryptrs.verify_password(password, user.hashed_password)
  end
  ```
  """
  defdelegate no_user_verify, to: Bcryptrs.Native
  defdelegate no_user_verify(cost), to: Bcryptrs.Native

  @doc """
  Verifies if a given password matches the stored hash

  ```elixir
    Bcryptrs.verify_password(password, hashed_password)
  ```
  """
  defdelegate verify_pass(password, hash), to: Bcryptrs.Native
end

defmodule Bcryptrs.Native do
  version = Mix.Project.config()[:version]

  unsupported = [
    "x86_64-unknown-freebsd"
  ]

  use RustlerPrecompiled,
    otp_app: :bcryptrs,
    crate: "bcryptrs_native",
    version: version,
    base_url: "https://github.com/dkuku/bcryptrs/releases/download/v#{version}",
    force_build: System.get_env("BCRYPTRS_TEST") in ["1", "true"],
    targets: Enum.uniq(RustlerPrecompiled.Config.default_targets() -- unsupported)

  @cost Application.compile_env(:bcryptrs, :cost, 12)
  def no_user_verify(cost \\ @cost) do
    hash_pwd_salt("password", cost)
    false
  end

  def hash_pwd_salt(password) do
    hash_pwd_salt(password, @cost)
  end

  def hash_pwd_salt(_arg1, _arg2), do: :erlang.nif_error(:nif_not_loaded)
  def verify_pass(_arg1, _arg2), do: :erlang.nif_error(:nif_not_loaded)
end
