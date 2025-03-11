defmodule Cinema.App.Events.MovieTitleUpdated do
  @moduledoc false
  @derive Jason.Encoder
  defstruct [:uuid, :title]
end
