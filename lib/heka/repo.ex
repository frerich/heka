defmodule Heka.Repo do
  use Ecto.Repo,
    otp_app: :heka,
    adapter: Ecto.Adapters.Postgres
end
