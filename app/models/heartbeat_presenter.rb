class HeartbeatPresenter
  CHANNEL = "heartbeat".freeze

  class << self
    def current
      {
        count: count,
        timestamp: timestamp
      }
    end

    def tick!
      values = {
        count: count + 1,
        timestamp: Time.current
      }

      Rails.cache.write(cache_key(:count), values[:count])
      Rails.cache.write(cache_key(:timestamp), values[:timestamp])
      broadcast!(values)
      values
    end

    def count
      Rails.cache.read(cache_key(:count)) || 0
    end

    def timestamp
      Rails.cache.read(cache_key(:timestamp)) || Time.current
    end

    def broadcast!(values = current)
      Turbo::StreamsChannel.broadcast_replace_to(
        CHANNEL,
        target: "heartbeat_card",
        partial: "home/heartbeat",
        locals: {
          heartbeat: values
        }
      )
    end

    private

    def cache_key(name)
      "heartbeat:#{name}"
    end
  end
end
