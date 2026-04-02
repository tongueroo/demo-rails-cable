# Demo Rails Cable

Small Rails 8.1 demo app for Blossom's standalone `cable` Procfile process.

It demonstrates:

- `web` serves normal HTTP traffic
- `cable` serves WebSocket traffic at `/cable`
- `jobs` runs Solid Queue jobs and recurring work
- `release` runs `rails db:prepare` so first deploy bootstraps the databases safely

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
