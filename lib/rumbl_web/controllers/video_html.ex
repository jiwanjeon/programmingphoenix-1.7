defmodule RumblWeb.VideoHTML do
  use RumblWeb, :html

  import Phoenix.HTML.Link
  # alias Rumbl.Multimedia

  # def first_name(%Multimedia.Video{name: name}) do
  #   name
  #   |> String.split(" ")
  #   |> Enum.at(0)
  # end

  embed_templates "video_html/*"
end
