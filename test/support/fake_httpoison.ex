defmodule FakeHttpoison do
  def get(_) do
    {:ok, %HTTPoison.Response{body: <<1,2,3,4,5>>}}
  end
end
