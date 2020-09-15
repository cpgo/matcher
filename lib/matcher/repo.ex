defmodule Matcher.Repo do
  use Ecto.Repo,
    otp_app: :matcher,
    adapter: Ecto.Adapters.Postgres
end
