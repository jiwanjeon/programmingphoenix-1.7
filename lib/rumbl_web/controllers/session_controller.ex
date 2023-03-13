defmodule RumblWeb.SessionController do
  use RumblWeb, :controller
  alias Rumbl.Accounts.User
  alias Rumbl.Accounts

  def new(conn, _params) do
    IO.puts("INIT")

    render(
      conn,
      :new,
      changeset: Accounts.change_registration(%User{}, %{})
    )
  end

  def create(
        conn,
        %{"session" => %{"username" => username, "password" => pass}}
      ) do
      IO.inspect(conn)
    case Rumbl.Accounts.authenticate_by_username_and_pass(username, pass) do
      {:ok, user} ->
        conn
        |> RumblWeb.Auth.login(user)
        |> put_flash(:info, "Welcome back!")
        |> redirect(to: ~p"/users")

      {:error, _reason} ->
        conn
        |> put_flash(:error, "Invalid username/password combination")
        |> render(:new, changeset: Accounts.change_registration(%User{}, %{}))

      # {:error, %Ecto.Changeset{} = changeset} ->
      #   conn
      #   |> put_flash(:error, "Invalid username/password combination")
      #   |> render(:new, changeset: changeset)
    end
  end

  def delete(conn, _) do
    conn
    |> RumblWeb.Auth.logout()
    |> redirect(to: ~p"/users")
  end
end
