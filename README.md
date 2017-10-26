# Cds

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix

## Search API

*Request*

```
curl -X GET \
  'http://localhost:4000/api/search?query=text' \
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
