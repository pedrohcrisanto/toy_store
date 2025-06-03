require 'pagy/extras/headers' # Essencial para APIs: adiciona links de paginação nos cabeçalhos HTTP
require 'pagy/extras/overflow' # Opcional: lida com requisições de páginas que não existem

# Define o número padrão de itens por página (ex: 20)
Pagy::DEFAULT[:items] = 20
# Opcional: Define o que acontece se a página solicitada for maior que o total de páginas
# :last_page (redireciona para a última página), :empty_page (retorna array vazio)
Pagy::DEFAULT[:overflow] = :last_page

Pagy::DEFAULT.freeze