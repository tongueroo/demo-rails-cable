class HeartbeatBroadcastJob < ApplicationJob
  queue_as :default

  def perform
    HeartbeatPresenter.tick!
  end
end
