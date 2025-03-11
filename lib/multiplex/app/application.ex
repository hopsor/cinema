defmodule Multiplex.App.Application do
  @moduledoc false
  use Commanded.Application,
    otp_app: :multiplex,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: Multiplex.EventStore
    ]

  router(Multiplex.App.Router)
end
