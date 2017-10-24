# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :bdr,
  ecto_repos: [Bdr.Repo]


# Authentication configuration 
config :bdr, Bdr.Guardian, #:guardian is what the tutorial said. 
  issuer: "bdr",
  secret_key: "cd3ETCHa9SDjGd0gi3/FXgR7o9oyyYBJLm4WYW1W/NlGXiobSC+4pgA0E9P+VDRx",
  allowed_algos: ["HS512"], # optional
  verify_module: Guardian.JWT,  # optional
  ttl: { 30, :days },
  allowed_drift: 2000,
  verify_issuer: true, # optional
  serializer: Bdr.GuardianSerializer
  
  
config :ueberauth, Ueberauth,
  providers: [
    facebook: { Ueberauth.Strategy.Facebook, [display: "popup"] },
    github: { Ueberauth.Strategy.Google, [] },
    identity: { Ueberauth.Strategy.Identity, [
      callback_methods: ["POST"],
      uid_field: :name,
      nickname_field: :name,
    ] }

  ]

config :ueberauth, Ueberauth.Strategy.Google.OAuth,
  client_id: System.get_env("GOOGLE_CLIENT_ID"),
  client_secret: System.get_env("GOOGLE_CLIENT_SECRET"),
  redirect_uri: System.get_env("GOOGLE_REDIRECT_URI")
  

config :ueberauth, Ueberauth.Strategy.Facebook.OAuth,
  client_id: System.get_env("FACEBOOK_CLIENT_ID"),
  client_secret: System.get_env("FACEBOOK_CLIENT_SECRET")


config :argon2_elixir,
  t_cost: 2,
  m_cost: 12



# Configures the endpoint
config :bdr, BdrWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "nEYuPKgz2XGRfR8/jixyPfZ0ozK5Kjn1Ttclyd61ibvDHlBmSOjafQVjnH3UGQGd",
  render_errors: [view: BdrWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Bdr.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"

  
# Configure file uploads
config :arc,
  storage: Arc.Storage.Local # or Arc.Storage.S3
  # bucket: {:system, "AWS_S3_BUCKET"} # if using Amazon S3

