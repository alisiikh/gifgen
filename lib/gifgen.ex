defmodule Gifgen do
  def get_gif(theme) do
    with {:ok, url} <- gif_url(theme),
         {:ok, img} <- download_gif(url) do
      {:ok, img}
    end
  end

  defp gif_url(theme) do
    %{"data" => %{"image_url" => gif_url}} = GiphyEx.Gifs.random(theme)
    {:ok, gif_url}
  end

  defp download_gif(url) do
    {:ok, %HTTPoison.Response{body: img}} = HTTPoison.get(url)
    {:ok, img}
  end
end

defmodule Gifgen.App do
  use Application

  def start(_type, _args) do
    children = [
      Gifgen.Server
    ]

    opts = [strategy: :one_for_one, name: Gifgen.Supervisor]
    Supervisor.start_link(children, opts)
  end
end

defmodule Gifgen.Server do
  use Maru.Server, otp_app: :gifgen
end

defmodule Gifgen.Router.Getgif do
  use Gifgen.Server

  params do
    requires :theme, type: String
  end

  get do
    {:ok, img} = params[:theme]
      |> Gifgen.get_gif

    conn
    |> put_resp_content_type("image/gif")
    |> send_resp(200, img)
    |> halt

      # json(conn, %{msg: "hello, world!"})
  end
end

defmodule Gifgen.API do
  use Gifgen.Server

  plug Plug.Parsers,
    pass: ["*/*"],
    json_decoder: Elixir.Jason,
    parsers: [:urlencoded, :json, :multipart]

  mount Gifgen.Router.Getgif

  rescue_from :all do
    conn
    |> put_status(500)
    |> text("Oops, no cats today.")
  end
end
