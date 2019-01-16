defmodule GifgenTest do
  use ExUnit.Case
  doctest Gifgen

  test "greets the world" do
    assert Gifgen.hello() == :world
  end
end
