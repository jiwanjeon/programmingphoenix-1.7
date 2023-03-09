defmodule RumblWeb.UserHTML do
  use RumblWeb, :html

  import Phoenix.HTML.Link
  alias Rumbl.Accounts

  def first_name(%Accounts.User{name: name}) do
    name
    |> String.split(" ")
    |> Enum.at(0)
  end

  embed_templates "user_html/*"
end
