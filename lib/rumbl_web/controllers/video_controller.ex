defmodule RumblWeb.VideoController do
  use RumblWeb, :controller
  alias Rumbl.Multimedia
  alias Rumbl.Multimedia.Video
  # plug :authenticate_user when action in [:index, :show]

  def index(conn, _params) do
    videos = Multimedia.list_videos()
    render(conn, :index, videos: videos)
  end

  def show(conn, %{"id" => id}) do
    video = Multimedia.get_video!(id)
    render(conn, :show, video: video)
  end

  def new(conn, _params) do
    changeset = Video.changeset(%Video{}, %{})
    render(conn, :new, changeset: changeset)
  end

  def create(conn, %{"video" => video_params}) do
    case Multimedia.create_video(video_params) do
      {:ok, video} ->
        conn
        |> put_flash(:info, "#{video.title} created!")
        |> redirect(to: ~p"/videos")

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, :new, changeset: changeset)
    end
  end
end
