class HomeController < ApplicationController
  def show
    @heartbeat = HeartbeatPresenter.current
  end
end
