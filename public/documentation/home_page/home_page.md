# Struttura della pagina Home

Quando visitiamo la pagina home di `Visit Sicily con Ttatta` ci aspettiamo di vedere qualcosa del genere:

![Mockup Home Page - Visit Sicily con Ttattà](/public/documentation/home_page/images/Home%20page.png "Mockup Home Page - Visit Sicily con Ttattà")

Per prima cosa genera un controller `home` con un'azione `index`, per fare questo da terminale esegui il seguente comando:
```sh
bin/rails generate controller home index
```
Il comando genererà:
- Un controller `HomeController` -> `app/controllers/home`
- Una vista `index.html.erb` situata in `app/views/home`

Apri il file `config/routes` ed imposta il percorso radice(root) della nostra applicazione che sarà l'azione `index` del controller `home`.

```ruby
Rails.application.routes.draw do
  #...
  root "home#index"
end
```

Adesso apri il file `app/views/home/index.html.erb` e modificalo come segue:

```ruby

<%= render "hero_section"%>

<!-- Points -->
<div class="py-16 px-4">
    <div class="container mx-auto">
        <h2 class="text-2xl font-bold mb-8 text-center">Cosa vedere</h2>
        <!-- Featured Listing Cards -->
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <%@points.all.each do |point| %>
                <div class="bg-white rounded-lg shadow-md overflow-hidden">
                    <%if point.cover_image.present?%>
                        <!--<img src="image1.jpg" alt="Listing 1" class="w-full h-48 object-cover">-->
                        <%= image_tag point.cover_image, alt: point.name, class: "w-full object-cover" %>
                    <%end%>
                    <div class="p-4">
                        <h3 class="text-xl font-semibold mb-2"><%=point.name%></h3>
                        <p class="text-gray-600"><%= point.description%></p>
                        <!--<span class="text-yellow-500 font-semibold">$120/night</span>-->
                    </div>
                </div>
            <%end%> 
        </div>
    </div>
</div>

```

Dopo avver avviato il server, tramite:

```sh
bin/dev
```
Se visiti la pagina [http://localhost:3000](http://localhost:3000) doversti vedere qualcosa di simile:

![Home Page - Visit Sicily con Ttattà](/public/documentation/home_page/images/home_page_visit_sicily_ttatta.png "Home Page - Visit Sicily con Ttattà")


Il codice 
```ruby
<%= render "hero_section"%>
<%#... ...%>
```
presente in *`app/views/home/index.html.erb`*, renderizza un `partial`, definito in *`app/views/home/_hero_section.html.erb`*

```ruby
<!-- app/views/home/_hero_section.html -->
<!-- Hero Section -->
<div class="bg-gray-800 text-white py-16">
    <div class="container mx-auto text-center">
        <h1 class="text-4xl font-bold mb-4">Visit Sicily con Ttattà</h1>
        <p class="text-lg">Scopri posti meravigliosi da visitare grazie all'intelligenza artificiale</p>
        <div class="mt-8">
            <a href="#" class="bg-yellow-500 text-gray-800 px-6 py-3 font-semibold rounded-full hover:bg-yellow-400 transition duration-300">Inizia adesso</a>
        </div>
    </div>
</div>
```

![Home Page - Visit Sicily con Ttattà](/public/documentation/home_page/images/partial_hero_visit_sicily.png "Home Page - Visit Sicily con Ttattà")

I `partials `sono un altro strumento per suddividere il processo di rendering in porzioni più gestibili. Con un `partial`, è possibile spostare il codice per il rendering di una particolare parte di una risposta in un proprio file, cosi da rendere più oridnato il nostro codice.

La restatnte parte di codice in `app/views/home/index.html.erb`:

```ruby
<div class="py-16 px-4">
    <div class="container mx-auto">
        <h2 class="text-2xl font-bold mb-8 text-center">Cosa vedere</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
            <%@points.each do |point| %>
                <div class="bg-white rounded-lg shadow-md overflow-hidden">
                    <%if point.cover_image.present?%>
                        <!--<img src="image1.jpg" alt="Listing 1" class="w-full h-48 object-cover">-->
                        <%= image_tag point.cover_image, alt: point.name, class: "w-full object-cover" %>
                    <%end%>
                    <div class="p-4">
                        <h3 class="text-xl font-semibold mb-2"><%=point.name%></h3>
                        <p class="text-gray-600"><%= point.description%></p>
                        <!--<span class="text-yellow-500 font-semibold">$120/night</span>-->
                    </div>
                </div>
            <%end%>
        </div>
    </div>
</div>
```
Visualizza tutti i punti di interesse presenti nella nostra applicazione.

La variabile `@points` definita nel controller 
`app/controllers/home`
```ruby
class HomeController < ApplicationController
  def index
    @points = Point.all
  end
end
```
contiene tutti i punti di interesse presenti nella tabella `points` del nostro database, grazie al metodo `Point.all` che genera un istruzione `sql`:

```sql
SELECT * FROM points;
```
Il risultato della `SELECT` sarà assegato in questo caso alla variabile `@points`, di tipo `array`. 

L'array `@points`  sarà visibile nella vista `app/views/home/index.html.erb`, dove grazie al metodo `each`, verrà scasionato e rederizzato ogni singolo punto di interesse.

*Lista dei punti di interesse*
![Home Page - Visit Sicily con Ttattà](/public/documentation/home_page/images/lista-di-tutti-i-punti-di-interesse-visit-sicily.png "Home Page - Visit Sicily con Ttattà")


## La barra di navigazione

Addesso costruiamo la struttura portante della navigazione di `Visit Sicily con Ttattà`: la barra di navigazione. 

Apri il file `app/views/layouts/applicazion.html.erb` e inserisci subito dopo il tag `<body>` il partial: `navbar`

```ruby

<!DOCTYPE html>
<html>
  <head>
    <title>Visit Sicily con Ttattà</title>
    <meta name="viewport" content="width=device-width,initial-scale=1">
    <%= csrf_meta_tags %>
    <%= csp_meta_tag %>

    <%= stylesheet_link_tag "application", "data-turbo-track": "reload" %>
    <%= javascript_include_tag "application", "data-turbo-track": "reload", type: "module" %>
  </head>

  <body>
    <%= render "layouts/header/navbar"%>
    <div class="">
      <main class="">
        <%= yield %>
      </main>
    </div>
    <%= render "layouts/footer/footer_section"%>
  </body>
</html>
```

Crea il `partial` in `layouts/header/` e chiamalo `_navbar.html.erb`:

```ruby
<!-- Navigation -->
<nav class="sticky top-0 bg-white shadow-md">
    <div class="container mx-auto flex justify-between items-center p-4">
        <a href="/" class="text-xl font-bold text-gray-800">
        Visit Sicily<br>
        <div class="text-xs text-center">con Ttattà</div>
        </a>

        <!-- Mobile Menu Button -->
        <a role="button" class="lg:hidden focus:outline-none shadow-md p-2 rounded-full flex">
            Menu 
            <svg class="w-6 h-6 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" fill="none" 
            xmlns="http://www.w3.org/2000/svg">
            <path d="M7 10L12 15L17 10" stroke="#000000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </a>

        <!-- Desktop Menu -->
        <ul class="hidden lg:flex space-x-4 shadow-md p-3 rounded-full"> 
            <li><a href="/" class="text-gray-600 hover:text-gray-800">Cosa vedere</a></li>
            <li><a href="/" class="text-gray-600 hover:text-gray-800">Esperienze</a></li>
            <li><a href="/" class="text-gray-600 hover:text-gray-800">Eventi</a></li>
        </ul>
        <a href="#" class="text-gray-600 hover:text-gray-800">Account</a>
    </div>

    <!-- Mobile Menu -->
    <div class="lg:hidden fixed inset-0 bg-white z-50 hidden" data-navbar-target="content">
        <div class="flex justify-end p-4">
            <a role="button" class="focus:outline-none">
                <svg class="w-6 h-6 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M6 18L18 6M6 6l12 12"></path>
                </svg>
            </a>
        </div>
        <ul class="flex flex-col items-center">
            <li class="py-2"><a href="/" class="text-gray-600 hover:text-gray-800">Home</a></li>
            <li class="py-2"><a href="/" class="text-gray-600 hover:text-gray-800">Cosa vedere</a></li>
            <li class="py-2"><a href="/" class="text-gray-600 hover:text-gray-800">Esperienze</a></li>
            <li class="py-2"><a href="/" class="text-gray-600 hover:text-gray-800">Eventi</a></li>
        </ul>
    </div>
</nav>
```

Adesso la `homepage` avrà una barra di navigazione. La visualizzazione da desktop è la seguente:

*Navbar desktop*
![Home Page Navbar Desktop - Visit Sicily con Ttattà](/public/documentation/home_page/images/navbar-desktop.png "Home Page Navbar Desktop - Visit Sicily con Ttattà")

Mentre da mobile ha la seguente visualizzazione:

![Home Page Navbar Mobile - Visit Sicily con Ttattà](/public/documentation/home_page/images/navbar-mobile.png "Home Page Navbar Mobile - Visit Sicily con Ttattà")

Quando clicchi sul menù nella versione mobile, non è funzionante. Per far funzionare il menu da mobile, devi creare un `controller` Stimulus.

Da terminale:
```sh
bin/rails g stimulus navbar
```
Il controller verrà creato nella cartella `app/javascript/controllers/`. Avrà un aspetto simile a quanto mostrato di seguito:

```javascript
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  connect() {
  }
}
```
Il metodo `connect` viene chiamato quando il controller viene allegato al `DOM`. È utile per eseguire qualsiasi configurazione necessaria, ma in questo caso non è necessario. Il generatore ha anche registrato questo nuovo controller nell'applicazione Stimulus. Puoi vedere ciò in:

`app/javascript/controllers/index.js`

```javascript
// This file is auto-generated by ./bin/rails stimulus:manifest:update
// Run that command whenever you add a new controller or create them with
// ./bin/rails generate stimulus controllerName

import { application } from "./application"

import HelloController from "./hello_controller"
application.register("hello", HelloController)

import NavbarController from "./navbar_controller"
application.register("navbar", NavbarController)
```

L'implementazione del controller stimulus navbar è mostrata di seguito:

`app/javascript/controllers/navbar_controller.js`

```javascript
import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="navbar"
export default class extends Controller {
  //static targets = [ "arrow", "menu", "closeButton"]
  static targets = ["content"]

    connect() {
      this.close()
    }
  
    toggle() {
      if (this.contentTarget.classList.contains("hidden")) {
        this.open()
      }
      else {
        this.close()
      }
    }
  
    open() {
      this.contentTarget.classList.remove("hidden")
    }

    close() {
      this.contentTarget.classList.add("hidden")
    }

}

```

Il menu mobile è collegato al metodo di `toggle` utilizzando un'azione, che cambierà la classe necessaria per aprirlo e chiuderlo. L'ultimo passo è aggiungere gli attributi HTML per collegare questo controller al `DOM`.
Modifichiamo il file `/app/views/layouts/header/_navbar.html.erb` come segue:

```ruby
<!-- Navigation -->
<nav class="sticky top-0 bg-white shadow-md" data-controller="navbar">
    <div class="container mx-auto flex justify-between items-center p-4">
        <a href="/" class="text-xl font-bold text-gray-800">
        Visit Sicily<br>
        <div class="text-xs text-center">con Ttattà</div>
        </a>

        <!-- Mobile Menu Button -->
        <a role="button" class="lg:hidden focus:outline-none shadow-md p-2 rounded-full flex" data-action="click->navbar#toggle">
            Menu 
            <svg class="w-6 h-6 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24" fill="none" 
            xmlns="http://www.w3.org/2000/svg">
            <path d="M7 10L12 15L17 10" stroke="#000000" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </a>

        <!-- Desktop Menu -->
        <ul class="hidden lg:flex space-x-4 shadow-md p-3 rounded-full"> 
            <li><a href="/" class="text-gray-600 hover:text-gray-800">Cosa vedere</a></li>
            <li><a href="/" class="text-gray-600 hover:text-gray-800">Esperienze</a></li>
            <li><a href="/" class="text-gray-600 hover:text-gray-800">Eventi</a></li>
        </ul>
        <a href="#" class="text-gray-600 hover:text-gray-800">Account</a>
    </div>

    <!-- Mobile Menu -->
    <div class="lg:hidden fixed inset-0 bg-white z-50 hidden" data-navbar-target="content">
        <div class="flex justify-end p-4">
            <a role="button" class="focus:outline-none" data-action="click->navbar#toggle">
                <svg class="w-6 h-6 text-gray-600" fill="none" stroke="currentColor" viewBox="0 0 24 24"
                    xmlns="http://www.w3.org/2000/svg">
                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2"
                        d="M6 18L18 6M6 6l12 12"></path>
                </svg>
            </a>
        </div>
        <ul class="flex flex-col items-center">
            <li class="py-2"><a href="/" class="text-gray-600 hover:text-gray-800">Home</a></li>
            <li class="py-2"><a href="/" class="text-gray-600 hover:text-gray-800">Cosa vedere</a></li>
            <li class="py-2"><a href="/" class="text-gray-600 hover:text-gray-800">Esperienze</a></li>
            <li class="py-2"><a href="/" class="text-gray-600 hover:text-gray-800">Eventi</a></li>
        </ul>
    </div>
</nav>
```

Adesso il nostro menu da mobile è perfettamente funzionate.

![Home Page Navbar Mobile - Visit Sicily con Ttattà](/public/documentation/home_page/images/menu-mobile-.png "Home Page Navbar Mobile - Visit Sicily con Ttattà")


