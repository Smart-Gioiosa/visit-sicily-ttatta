# VISIT SICILY - TTATTÀ

Costruiremo un'applicazione web turistica. La chiameremo **Visit Sicily con Ttattà**. 

La maggior parte del lavoro sarà sul web, e utilizzeremo le estensioni native di [Hotwire](https://hotwired.dev/) per le app [iOS e Android](https://turbo.hotwired.dev/handbook/native).

Per costruire l'interfaccia grafica utilzzeremo [Tailwindcss](https://tailwindcss.com/).

## Setup del progetto
### I requisiti preliminari

Verifica che siano installate le versioni corrette di Ruby e Rails. Avrai bisogno di almeno Rails 7 e Ruby 3.2 per la creazione di questo progetto.

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

