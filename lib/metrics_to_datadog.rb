require 'dogapi'
require 'json'

class MetricsToDatadog

  def initialize(app_key = nil, api_key = nil)
    if api_key.nil? || app_key.nil? then
      raise RuntimeError, "Please provide your datadog app and api keys"
    end
    @dogclient = Dogapi::Client.new(api_key, app_key)
  end

  def set_datadog(datadog)
    @dogclient = datadog
  end

  def set_dashboard(dashboard_config)
    if !File.exist?(dashboard_config) then
      raise RuntimeError, "The dashboard config does not exist."
    end

    File.open(dashboard_config) do |file|
      dashboard = JSON.parse(file.read.strip)
      @dogclient.create_screenboard(dashboard)
    end

  end

  def set_timeboard(dashboard_config, title, description)
    if !File.exist?(dashboard_config) then
      raise RuntimeError, "The dashboard config does not exist."
    end

    File.open(dashboard_config) do |file|
      dashboard = JSON.parse(file.read.strip)
      @dogclient.create_dashboard(title, description, dashboard["graphs"], dashboard["template_variables"])
    end

  end

  def get_all_screenboards
    screenboards = @dogclient.get_all_screenboards()
    JSON.dump(screenboards)
  end

  def get_screenboard(screenboard_id)
    screenboard = @dogclient.get_screenboard(screenboard_id)
    JSON.dump(screenboard)
  end

  def get_timeboard(timeboard_id)
    timeboard = @dogclient.get_dashboard(timeboard_id)
    JSON.dump(timeboard)
  end

  def get_monitor(monitor_id)
    monitor = @dogclient.get_monitor(monitor_id)
    JSON.dump(monitor)
  end
end
