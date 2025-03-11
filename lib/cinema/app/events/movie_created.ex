defmodule Cinema.App.Events.MovieCreated do
  @derive Jason.Encoder
  defstruct [:uuid, :title, :duration]
end
