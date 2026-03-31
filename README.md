# Demo Rails Cable

This is a small Rails 8.1 app that demonstrates a standalone Action Cable process with a separate `cable` Procfile entry:

```Procfile
web: bin/rails server -p $PORT
cable: bin/cable
jobs: bin/jobs
```

It exists to test Blossom's `cable` process-type convention:

- `web` serves normal HTTP traffic
- `cable` serves WebSocket traffic at `/cable`
- `jobs` runs Solid Queue and recurring jobs

## What The Demo Does

The home page subscribes to a Turbo Stream channel and displays a live heartbeat counter.

- `HeartbeatBroadcastJob` updates the counter
- the browser receives updates through the standalone Cable server
- the recurring scheduler can broadcast every 3 seconds

This proves that `web`, `cable`, and `jobs` can run as separate processes while still working together.

## Local Setup

The app uses:

- PostgreSQL
- `solid_queue`
- `solid_cable`
- `solid_cache`

Prepare the databases:

```sh
bundle exec rails db:prepare
```

This creates the development databases for:

- primary
- queue
- cable
- cache

## Run Locally

Start all processes:

```sh
bin/dev
```

This runs:

- `web` on `http://localhost:3000`
- `cable` on `ws://localhost:3100/cable`
- `jobs` via `bin/jobs`
- Tailwind watcher

Open:

```text
http://localhost:3000
```

## WebSocket Debugging

If you want to test the standalone Cable endpoint directly with `wscat`, use the Action Cable subprotocol:

```sh
wscat -s actioncable-v1-json -c ws://localhost:3100/cable
```

If the connection succeeds, you should see the WebSocket handshake complete instead of a `404` or origin error.

## Recurring Heartbeat

The recurring job is configured in:

- [config/recurring.yml](./config/recurring.yml)

During focused WebSocket debugging you may want to comment it out temporarily to reduce log noise.

## Important Demo Choices

This app intentionally differs from a locked-down production app in a few ways:

- Action Cable origin checks are disabled in both development and production config
- the goal is to remove friction when testing standalone Cable behavior

That is acceptable here because this is a demo app for platform behavior, not a security reference app.

## Relevant Files

- [Procfile](./Procfile)
- [Procfile.dev](./Procfile.dev)
- [bin/cable](./bin/cable)
- [cable/config.ru](./cable/config.ru)
- [config/cable.yml](./config/cable.yml)
- [config/database.yml](./config/database.yml)
- [app/jobs/heartbeat_broadcast_job.rb](./app/jobs/heartbeat_broadcast_job.rb)
- [app/models/heartbeat_presenter.rb](./app/models/heartbeat_presenter.rb)
- [app/views/home/show.html.erb](./app/views/home/show.html.erb)
