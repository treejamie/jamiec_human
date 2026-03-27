defmodule Jamie.Repo do
  use Ecto.Repo,
    otp_app: :jamiec_human,
    adapter: Ecto.Adapters.Postgres
end
