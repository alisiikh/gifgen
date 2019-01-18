defmodule FakeGiphy do
  def random(_) do
    %{"data" => %{"image_url" => "a_url"}}
  end
end
