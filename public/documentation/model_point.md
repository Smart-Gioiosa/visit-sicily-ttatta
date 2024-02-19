Da terminale lanciamo il comando:
```sh
bin/rails g model point name:string description:text
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

      t.timestamps
    end
  end
end
```

Per rendere effettive le modifiche e quindi creare la tabella `points` sul nostro database, lanciamo il comando:

```sh
bin/rails db:migrate
```


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