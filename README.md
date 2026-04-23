# Demo Rails Cable

Small Rails 8.1 demo app for Blossom's standalone `cable` Procfile process.

It demonstrates:

- `web` serves normal HTTP traffic
- `cable` serves WebSocket traffic at `/cable`
- `jobs` runs Solid Queue jobs and recurring work
- `release` runs `rails db:prepare` so first deploy bootstraps the databases safely

## Blossom Deploy Note

If you deploy this app on Blossom and want the `cable` Procfile process to run, your server must include the `cable` role.

For a shared app server, use roles like:

```text
web, cable
```

If the server only has the `web` role, Blossom will not place the `cable` process there.

## Run

```sh
bundle exec rails db:prepare
bin/dev
```

Open:

```text
http://localhost:3000
```

## WebSocket Check

```sh
wscat -s actioncable-v1-json -c ws://localhost:3100/cable
```

## Key Files

- [Procfile](./Procfile)
- [Procfile.dev](./Procfile.dev)
- [bin/cable](./bin/cable)
- [cable/config.ru](./cable/config.ru)
