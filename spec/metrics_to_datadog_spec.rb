require 'metrics_to_datadog'
require 'fakes/datadog'
require 'json'

RSpec.describe MetricsToDatadog do

  let! (:app_key) { "some_app_key" }
  let! (:api_key) { "some_api_key" }
  let (:metrics) { MetricsToDatadog.new(app_key, api_key) }

  context "when created with no params" do
    it "should raise an exception" do
      expect{MetricsToDatadog.new}.to raise_error(RuntimeError)
    end
  end

  context "#set_dashboard" do
    it "should validate the dashboard config file passed in exists" do
      expect{metrics.set_dashboard("/path/to/invalid")}.to raise_error(RuntimeError)
    end

    it "should make a POST request" do
      mock_datadog = MockDataDogApi::V1::ScreenboardService.new
      metrics.set_datadog(mock_datadog)
      expect(mock_datadog).to receive(:create_screenboard).with(JSON.parse( "{\"name\":\"redis\"}") )
      metrics.set_dashboard("./spec/fakes/redis.json")
    end
  end

  context "#get_all_screenboards" do
    it "should get all screenboards" do
      mock_datadog = MockDataDogApi::V1::ScreenboardService.new
      metrics.set_datadog(mock_datadog)

      expect(mock_datadog).to receive(:get_all_screenboards)

      metrics.get_all_screenboards()
    end
  end

  context "#get_screenboard" do
    it "should get the screenboard with the specified ID" do
      mock_datadog = MockDataDogApi::V1::ScreenboardService.new
      metrics.set_datadog(mock_datadog)

      expect(mock_datadog).to receive(:get_screenboard).with("screenboard_id")
      metrics.get_screenboard("screenboard_id")
    end
  end

  context "#get_monitor" do
    it "should get the monitor with the specified ID" do
      mock_datadog = MockDataDogApi::V1::ScreenboardService.new
      metrics.set_datadog(mock_datadog)

      expect(mock_datadog).to receive(:get_monitor).with("monitor_id")
      metrics.get_monitor("monitor_id")
    end
  end

end
