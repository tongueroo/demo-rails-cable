# frozen_string_literal: true

require_relative "../config/environment"

map "/cable" do
  run ActionCable.server
end
