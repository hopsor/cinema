defmodule Cinema.TheaterTest do
  use Cinema.DataCase

  alias Cinema.Theater

  describe "movies" do
    alias Cinema.Theater.Movie

    import Cinema.TheaterFixtures

    @invalid_attrs %{title: nil, duration: nil}

    test "list_movies/0 returns all movies" do
      movie = movie_fixture()
      assert Theater.list_movies() == [movie]
    end

    test "get_movie!/1 returns the movie with given id" do
      movie = movie_fixture()
      assert Theater.get_movie!(movie.id) == movie
    end

    test "create_movie/1 with valid data creates a movie" do
      valid_attrs = %{title: "some title", duration: 42}

      assert {:ok, %Movie{} = movie} = Theater.create_movie(valid_attrs)
      assert movie.title == "some title"
      assert movie.duration == 42
    end

    test "create_movie/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Theater.create_movie(@invalid_attrs)
    end

    test "update_movie/2 with valid data updates the movie" do
      movie = movie_fixture()
      update_attrs = %{title: "some updated title", duration: 43}

      assert {:ok, %Movie{} = movie} = Theater.update_movie(movie, update_attrs)
      assert movie.title == "some updated title"
      assert movie.duration == 43
    end

    test "update_movie/2 with invalid data returns error changeset" do
      movie = movie_fixture()
      assert {:error, %Ecto.Changeset{}} = Theater.update_movie(movie, @invalid_attrs)
      assert movie == Theater.get_movie!(movie.id)
    end

    test "delete_movie/1 deletes the movie" do
      movie = movie_fixture()
      assert {:ok, %Movie{}} = Theater.delete_movie(movie)
      assert_raise Ecto.NoResultsError, fn -> Theater.get_movie!(movie.id) end
    end

    test "change_movie/1 returns a movie changeset" do
      movie = movie_fixture()
      assert %Ecto.Changeset{} = Theater.change_movie(movie)
    end
  end
end
