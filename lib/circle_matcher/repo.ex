defmodule CircleMatcher.Repo do
  use Ecto.Repo,
    otp_app: :circle_matcher,
    adapter: Ecto.Adapters.Postgres
end
