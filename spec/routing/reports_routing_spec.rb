require "rails_helper"

RSpec.describe ReportsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(
        get: "/reports"
      ).to route_to("reports#index", locale: I18n.locale.to_s)
    end

    it "routes to #show" do
      expect(
        get: "/reports/1"
      ).to route_to("reports#show", id: "1", locale: I18n.locale.to_s)
    end

    it "routes to #destroy" do
      expect(
        delete: "/reports/1"
      ).to route_to("reports#destroy", id: "1", locale: I18n.locale.to_s)
    end
  end
end
