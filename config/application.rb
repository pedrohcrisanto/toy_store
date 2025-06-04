require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ToyStore
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0
    config.cache_store = :solid_cache, {
      # Opcional: nome da tabela de cache, padrão é 'solid_cache_entries'
      # table_name: 'my_app_cache_entries',
      # Opcional: para usar um banco de dados separado para o cache
      # database: { writing: :solid_cache_writing, reading: :solid_cache_reading },
      # Opcional: tamanho máximo para o valor do cache (em bytes), padrão é 64KB
      # max_value_bytes: 1.megabyte
    }
    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])
    config.session_store :cookie_store, key: '_interslice_session'
    config.middleware.use ActionDispatch::Cookies
    config.middleware.use config.session_store, config.session_options
    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.api_only = true
  end
end
