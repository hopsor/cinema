defmodule Multiplex.App.Events.MovieCreated do
  @moduledoc false
  @derive Jason.Encoder
  defstruct [:uuid, :title, :duration]
end
