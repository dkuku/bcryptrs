defmodule BcryptrsTest do
  use ExUnit.Case
  use ExUnitProperties

  describe "works with elixir_bcrypt" do
    test "validates bcryptrs with bcrypt" do
      password = "password"
      hash = Bcryptrs.hash_pwd_salt(password)

      assert Bcrypt.verify_pass(password, hash) == true
      refute Bcrypt.verify_pass("other_password", hash)
    end

    test "validates bcrypt with bcryptrs" do
      password = "password"
      hash = Bcrypt.hash_pwd_salt(password)

      assert Bcryptrs.verify_pass(password, hash) == true
      refute Bcryptrs.verify_pass("other_password", hash) == true
    end
  end

  property "is compatible with elixir_bcrypt when encoding" do
    check all(password <- StreamData.string(:utf8)) do
      hash = Bcryptrs.hash_pwd_salt(password)

      assert Bcrypt.verify_pass(password, hash) == true
      assert Bcryptrs.verify_pass(password, hash) == true
    end
  end

  property "is compatible with elixir_bcrypt when validating" do
    check all(password <- StreamData.string(:utf8)) do
      hash = Bcrypt.hash_pwd_salt(password)

      assert Bcryptrs.verify_pass(password, hash) == true
      assert Bcrypt.verify_pass(password, hash) == true
    end
  end
end
