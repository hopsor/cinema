defmodule Multiplex.Repo do
  use Ecto.Repo,
    otp_app: :multiplex,
    adapter: Ecto.Adapters.Postgres
end
