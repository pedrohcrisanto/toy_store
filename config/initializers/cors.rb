Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # Altere para o domínio do seu frontend em produção, ex: 'http://localhost:3000' ou 'https://seufrotend.com'
    resource '*',
             headers: :any,
             methods: [:get, :post, :put, :patch, :delete, :options, :head],
             expose: ['Authorization'] # É crucial expor o cabeçalho Authorization para que o frontend possa ler o JWT
  end
end