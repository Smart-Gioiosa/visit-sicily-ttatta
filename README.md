# VISIT SICILY - TTATTÀ

Costruiremo un'applicazione web turistica. La chiameremo **Visit Sicily con Ttattà**, in quanto sfrutterà "l'alieno ttatta" attraverso l'intelligenza artificiale. 

La maggior parte del lavoro sarà sul web, e utilizzeremo le estensioni native di [Hotwire](https://hotwired.dev/) per le app [iOS e Android](https://turbo.hotwired.dev/handbook/native).

Per costruire l'interfaccia grafica utilzzeremo [Tailwindcss](https://tailwindcss.com/).

## Setup del progetto
### I requisiti preliminari

Verifica che siano installate le versioni corrette di Ruby e Rails. Avrai bisogno di almeno Rails 7.1.3 e Ruby 3.3.0 per la creazione di questo progetto.

```sh
rails -v 
rails 7.1.3
```

```sh
ruby -v
ruby 3.3.0 (2023-12-25 revision 5124f9ac75) [x86_64-darwin19]
```

Node.js e Yarn sono necessari per transpilare il JavaScript e installare le librerie frontend.

```sh
node -v
v20.11.1
```

```sh
yarn -v
1.22.19
```


Assicurati di avere PostgreSQL e Foreman (utilizzato per orchestrare
diversi processi in fase di sviluppo) installati

```sh
foreman -v
0.87.2

postgres --version
postgres (PostgreSQL) 12.3
```

### Creazione dell'app Rails

Nell'app Rails, utilizzeremo [ESBuild](https://esbuild.github.io/) per transpilare e raggruppare il JavaScript e Bulma per il CSS. 
[Propshaft](https://github.com/rails/propshaft) verrà utilizzato per la distribuzione delle risorse. Il database sarà
PostgreSQL, sia in locale che in produzione.


Esegui il comando seguente per creare l'app Rails
```sh
rails new visit-sicily-ttatta -j esbuild --css tailwind -a propshaft -d postgresql
```

Questo creerà l'app in una cartella chiamata shopping-gioioso.

Addesso possiamo avviare l'app Rails:

```sh
cd visit-sicily-ttatta
bin/rails db:prepare
bin/dev
```

Se si verifica un problema durante la preparazione del database, potrebbe essere che PostgreSQL non sia in esecuzione sulla tua macchina locale, quindi vale la pena verificarlo.
**bin/dev** utilizza Foreman per eseguire il server Rails e i processi per monitorare i file CSS e JS in modo che vengano ricompilati automaticamente quando vengono modificati.
I comandi per avviare questi processi sono definiti in Procfile.dev.


La nostra applicazione sarà anche un api per servire un'appliczione mobile o chatbot, inseriamo quindi graphql.

### Aggiunta della gemma GraphQL.

La gemma graphql è la gemma per la creazione di API GraphQL all'interno delle applicazioni Ruby. È utilizzata da aziende come Shopify e GitHub.

```sh 
bundle add graphql
```

Una volta installata quella gemma, possiamo eseguire un generatore di Rails fornito dalla gemma stessa. Questo generatore configurerà la struttura GraphQL di cui la nostra applicazione ha bisogno:

```sh
rails g graphql:install
```

Questo generatore genera diversi file differenti.

Per testare la nostra API aggiungiamo la gemma `graphiql-rails`:
```sh
group :development do
  gem 'graphiql-rails'
end
```

### Configurazione di graphiql-rails
Nel file `config\routes.rb` aggiungiamo la seguente istruzione

``` ruby

Rails.application.routes.draw do

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "graphql#execute"
  end

  post "/graphql", to: "graphql#execute"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

end
```

Inoltre se abbiamo creato la nostra applicazione rails con l'instruzione --api[Questo non è il nostro caso], bisogna seguire le seguenti configurazioni:

- Aggiungere  "sprockets/railtie" ad  `application.rb`.

- Creare un file `app/assets/config/manifest.js` ed inseire inserire:

```sh
//= link graphiql/rails/application.css
//= link graphiql/rails/application.js
```
