require "rails_helper"

RSpec.describe HomeController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/").to route_to("home#index")
    end

    it "does not route to #index with a bad method" do
      expect(post: "/").not_to be_routable
    end

    it "does not route to #index with a bad format" do
      expect(get: "/.json").not_to be_routable
    end
  end
end
