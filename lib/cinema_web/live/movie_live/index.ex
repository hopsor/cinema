defmodule CinemaWeb.MovieLive.Index do
  use CinemaWeb, :live_view

  alias Cinema.Theater
  alias Cinema.App.Projections.Movie

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     socket
     |> stream_configure(:movies, dom_id: &"#{&1.uuid}")
     |> stream(:movies, Theater.list_movies())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Movie")
    |> assign(:movie, Theater.get_movie!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Movie")
    |> assign(:movie, %Movie{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Movies")
    |> assign(:movie, nil)
  end

  @impl true
  def handle_info({CinemaWeb.MovieLive.FormComponent, {:saved, movie}}, socket) do
    {:noreply, stream_insert(socket, :movies, movie)}
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    movie = Theater.get_movie!(id)
    {:ok, _} = Theater.delete_movie(movie)

    {:noreply, stream_delete(socket, :movies, movie)}
  end
end
