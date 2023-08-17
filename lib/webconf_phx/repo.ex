defmodule WebconfPhx.Repo do
  use Ecto.Repo,
    otp_app: :webconf_phx,
    adapter: Ecto.Adapters.Postgres
end
