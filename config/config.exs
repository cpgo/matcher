import Config

config :matcher, Matcher.Repo,
  database: "matcher",
  username: "postgres",
  password: "postgres",
  hostname: "localhost"

config :matcher, ecto_repos: [Matcher.Repo]
