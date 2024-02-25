# Il modello `point`

Di seguito il diagramma delle tabelle PostgresQL(il nostro database) che caratterizza  i nostri `points`(Punti di interesse) e le sue relazioni. 

![Diagramma della risorsa point](/public/documentation/points/visit-ttatta-points-diagram.png "Risorsa point")

Come da convenzione ruby on rails, il nome della tabella presente sul database è al plurale mentre in nome del modello è al singolare.

La risorsa `point` rappresenta il nostro punto di interesse. Iniziamo a creare il modello `point`.

Da terminale esegui il comando:

```sh
bin/rails g model point name:string description:text city:string address:string zipcode:string country:string latitude:float longitude:float
```

Questo genererà per noi il modello `app/models/point.rb`

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

Alla nostra tabella `points` manca l'allegato `cover_image`. Per caricare l'immageine di copertina per il nostro punto di interesse utilizzeremo `Active Storage`.

Per installare `active storage`, da terminale esegui il comando:
```sh
rails active_storage:install
```
Adesso per creare le tabelle necessarie ad `active storage` per salvare gli allegati, lancia, sempre da terminale, il comando:

```sh
rails db:migrate
```

Il database è ora pronto per unire qualsiasi modello `ActiveRecord` a un blob (un'immagine caricata), ma dobbiamo ancora dichiarare l'associazione nel nostro modello `apps/models/point.rb`.
Come da diagramma, vogliamo che il nostro punto di interesse abbia un immagine di copertina allegata(`cover_image`), che sarà l'immagine principale per il nostro punto. Per fare questo, aggiungiamo la seguente dichiarazione:

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
has_one :cover_image_blob, through: :cover_image_attachment
```

Il nostro modello ha quindi una `cover_image_attachment` e un `cover_image_blob` a cui può accedere tramite l'associazione `cover_image_attachment`. Se guardi il codice sorgente del metodo `has_one_attached`, c'è un po' di più dietro, ma fondamentalmente è questo che succede. Non è magia!

### Validazione dell'allegato
Per evitare che involontariamente un utente carichi un allegato troppo grande o nel formato non corretto, aggiungi al modello `app/models/point` la seguente validazione:

```ruby
class Point < ApplicationRecord
    #...
    has_one_attached :cover_image
    validate :acceptable_image

    def acceptable_image
        return unless cover_image.attached?
        
        unless cover_image.blob.byte_size <= 1.megabyte
            errors.add(:cover_image, "is too big")
        end

        acceptable_types = ["image/jpeg", "image/png", "image/webp"]

        unless acceptable_types.include?(cover_image.content_type)
            errors.add(:cover_image, "must be a JPEG, PNG or WEBP")
        end
    end

end

```

Il metodo `acceptable_image` fa in modo che un allegato non sia più grande di un megabyte e che sia nei seguenti formati: `jpeg`, `png` e `webp`.