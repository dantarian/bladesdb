Blades::Application.configure do
  config.lograge.enabled = true

  # add time to lograge
  config.lograge.custom_options = lambda do |event|
    { time: event.time }
  end

end
