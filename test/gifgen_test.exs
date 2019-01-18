defmodule GifgenTest do
  use ExUnit.Case
  doctest Gifgen

  test "generates gif file" do
    assert Gifgen.get_gif("foo") == {:ok, <<1, 2, 3, 4, 5>>}
  end
end
