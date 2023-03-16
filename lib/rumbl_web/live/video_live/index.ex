defmodule RumblWeb.VideoLive.Index do
  use RumblWeb, :live_view

  alias Rumbl.Multimedia
  alias Rumbl.Multimedia.Video

  @impl true
  def mount(_params, _session, socket) do
    {:ok, stream(socket, :videos, Multimedia.list_videos())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Video")
    |> assign(:video, Multimedia.get_video!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Video")
    |> assign(:video, %Video{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Videos")
    |> assign(:video, nil)
  end

  @impl true
  def handle_info({RumblWeb.VideoLive.FormComponent, {:saved, video}}, socket) do
    {:noreply, stream_insert(socket, :videos, video)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    video = Multimedia.get_video!(id)
    {:ok, _} = Multimedia.delete_video(video)

    {:noreply, stream_delete(socket, :videos, video)}
  end
end
