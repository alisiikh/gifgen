use Mix.Config

config :gifgen,
  gifgen: FakeGifgen,
  giphy: FakeGiphy,
  http_client: FakeHttpoison
