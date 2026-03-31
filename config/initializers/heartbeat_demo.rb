return unless Rails.env.development?

Rails.application.config.after_initialize do
  next if defined?(Rails::Console)
  next if ENV["HEARTBEAT_DEMO_DISABLED"] == "1"
  next unless defined?(Rails::Server)

  Thread.new do
    Thread.current.name = "heartbeat-demo" if Thread.current.respond_to?(:name=)

    loop do
      sleep 3
      HeartbeatBroadcastJob.perform_later
    rescue => e
      Rails.logger.error("[heartbeat-demo] #{e.class}: #{e.message}")
    end
  end
end
