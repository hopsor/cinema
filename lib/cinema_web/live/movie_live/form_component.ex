defmodule CinemaWeb.MovieLive.FormComponent do
  use CinemaWeb, :live_component

  alias Cinema.Theater

  @impl true
  def render(assigns) do
    ~H"""
    <div>
      <.header>
        {@title}
        <:subtitle>Use this form to manage movie records in your database.</:subtitle>
      </.header>

      <.simple_form
        for={@form}
        id="movie-form"
        phx-target={@myself}
        phx-change="validate"
        phx-submit="save"
      >
        <.input field={@form[:title]} type="text" label="Title" />
        <.input field={@form[:duration]} type="number" label="Duration" />
        <:actions>
          <.button phx-disable-with="Saving...">Save Movie</.button>
        </:actions>
      </.simple_form>
    </div>
    """
  end

  @impl true
  def update(%{movie: movie} = assigns, socket) do
    {:ok,
     socket
     |> assign(assigns)
     |> assign_new(:form, fn ->
       to_form(Theater.change_movie(movie))
     end)}
  end

  @impl true
  def handle_event("validate", %{"movie" => movie_params}, socket) do
    changeset = Theater.change_movie(socket.assigns.movie, movie_params)
    {:noreply, assign(socket, form: to_form(changeset, action: :validate))}
  end

  def handle_event("save", %{"movie" => movie_params}, socket) do
    save_movie(socket, socket.assigns.action, movie_params)
  end

  defp save_movie(socket, :edit, movie_params) do
    case Theater.update_movie(socket.assigns.movie, movie_params) do
      {:ok, movie} ->
        notify_parent({:saved, movie})

        {:noreply,
         socket
         |> put_flash(:info, "Movie updated successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp save_movie(socket, :new, movie_params) do
    case Theater.create_movie(movie_params) do
      {:ok, movie} ->
        notify_parent({:saved, movie})

        {:noreply,
         socket
         |> put_flash(:info, "Movie created successfully")
         |> push_patch(to: socket.assigns.patch)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, form: to_form(changeset))}
    end
  end

  defp notify_parent(msg), do: send(self(), {__MODULE__, msg})
end
