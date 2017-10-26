# Cds

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

## Search API

*Production Endpoint*

`https://cds-classic.herokuapp.com/`

*Development Endpoint*

`http://localhost:4000`

*Request*

```
curl -X GET \
  'https://cds-classic.herokuapp.com/api/search?query=text' \
  -H 'accept: application/json' \
  -H 'cache-control: no-cache' \
  -H 'content-type: application/json'
```

*Response*

```
{
    "query": "text",
    "data": [
        {
            "website_url": "elec.coom",
            "phone_number": "9412274444",
            "name": "Sam Electronics",
            "id": 1,
            "email": "samuelralak@hotmail.com",
            "description": "Awesome Text that will be searched here",
            "address": "P.O. Box 99656"
        }
    ]
}
```
