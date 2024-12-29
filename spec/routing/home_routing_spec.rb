require "rails_helper"

RSpec.describe HomeController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(
        get: "/"
      ).to route_to("home#index", locale: I18n.locale.to_s)
    end

    it "routes to #index with a json format" do
      expect(
        get: "/.json"
      ).to route_to("home#index", format: "json", locale: I18n.locale.to_s)
    end

    it "does not route to #index with a bad method" do
      expect(post: "/").not_to be_routable
    end
  end
end
