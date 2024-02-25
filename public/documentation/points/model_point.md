### Il modello `point`

Di seguito il diagramma delle tabelle PostgresQL(il nostro database) che caratterizza  i nostri `points`(Punti di interesse) e le sue relazioni. 

![Diagramma della risorsa point](/public/documentation/points/visit-ttatta-points-diagram.png "Risorsa point")

Come da convensione ruby on rails, il nome della tabella presente sul database è al plurale mente in nome del modello è al singolare.

La risorsa point rappresenta il nostro punto di interesse. Iniziamo con creare il modello `point`.

Da terminale esegui il comando:

```sh
bin/rails g model point name:string description:text city:string address:string zipcode:string country:string latitude:float longitude:float
```

Questo genererà per noi il modello `app/model/point.rb`

```ruby
class Point < ApplicationRecord
end
```

ed un file di migrazione: 

```ruby
class CreatePoints < ActiveRecord::Migration[7.1]
  def change
    create_table :points do |t|
      t.string :name
      t.text :description
      t.string :city
      t.string :address
      t.string :zipcode
      t.string :country
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
```

Per rendere effettive le modifiche e  creare la tabella `points` sul nostro database, lancia il comando:

```sh
bin/rails db:migrate
```

Alla nostra tabella `points` manca l'allegato `cover_image`. Per caricare l'immageine di opertina per il nostro punto di interesse utilizzeremo `Active Storage`.

Per installare `active storage`, da terminale esegui il comando:
```sh
rails active_storage:install
```
Adesso per creare le tabelle necessarie ad `active storage` per salvare gli allegati, lancia, sempre da terminale, il comando:

```sh
rails db:migrate
```

Il database è ora pronto per unire qualsiasi modello `ActiveRecord` a un blob (un'immagine caricata), ma dobbiamo ancora dichiarare l'associazione nel nostro modello `apps/models/point.rb`.
Come da diagramma, vogliamo che il nostro punto di interesse abbia un immagine di copertina allegata(`cover_image`), che sarà l'immagine principale per il nostro punto. Per fare questo, aggiungiamo la seguente dichiarazione

```ruby
class Point < ApplicationRecord
    #....
    has_one_attached :cover_image
    #...
end
```
Il nome del campo lo puoi scegliere come preferisci.
Quindi, cosa fa questa dichiarazione `has_one_attached?` Beh, utilizzando un po' di metaprogrammazione, crea efficacemente due associazioni come segue:

```ruby
has_one :cover_image_attachment, dependent: :destroy
has_one :cover_image_blob, through: :main_image_attachment
```

Il nostro modello ha quindi una `cover_image_attachment` e un `cover_image_blob` a cui può accedere tramite l'associazione `cover_image_attachment`. Se guardi il codice sorgente del metodo `has_one_attached`, c'è un po' di più dietro, ma fondamentalmente è questo che succede. Non è magia!


### Grapql

```sh
mutation{
    createPoint(input: {
        name: "Palermo",
        description: "Palermo"
    })
    {
        point{
            name
            description
        }
    }
}
```

```sh
query{
    points{
        id
        name
        description
        pointCount
    }
}
```