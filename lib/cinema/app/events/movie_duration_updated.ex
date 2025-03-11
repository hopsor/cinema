defmodule Cinema.App.Events.MovieDurationUpdated do
  @moduledoc false
  @derive Jason.Encoder
  defstruct [:uuid, :duration]
end
