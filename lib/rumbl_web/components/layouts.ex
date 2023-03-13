defmodule RumblWeb.Layouts do
  use RumblWeb, :html

  # TODO: Link를 쓰기위해서는 아래 link를 import 해와야함
  import Phoenix.HTML.Link
  alias Rumbl.Accounts

  embed_templates "layouts/*"
end
