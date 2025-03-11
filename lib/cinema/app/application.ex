defmodule Cinema.App.Application do
  use Commanded.Application,
    otp_app: :cinema,
    event_store: [
      adapter: Commanded.EventStore.Adapters.EventStore,
      event_store: Cinema.EventStore
    ]

  router(Cinema.App.Router)
end
