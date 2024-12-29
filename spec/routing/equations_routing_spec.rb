require "rails_helper"

RSpec.describe EquationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(
        get: "/equations"
      ).to route_to("equations#index", locale: I18n.locale.to_s)
    end

    it "routes to #new" do
      expect(
        get: "/equations/new"
      ).to route_to("equations#new", locale: I18n.locale.to_s)
    end

    it "routes to #show" do
      expect(
        get: "/equations/1"
      ).to route_to("equations#show", id: "1", locale: I18n.locale.to_s)
    end

    it "routes to #edit" do
      expect(
        get: "/equations/1/edit"
      ).to route_to("equations#edit", id: "1", locale: I18n.locale.to_s)
    end


    it "routes to #create" do
      expect(
        post: "/equations"
      ).to route_to("equations#create", locale: I18n.locale.to_s)
    end

    it "routes to #update via PUT" do
      expect(
        put: "/equations/1"
      ).to route_to("equations#update", id: "1", locale: I18n.locale.to_s)
    end

    it "routes to #update via PATCH" do
      expect(
        patch: "/equations/1"
      ).to route_to("equations#update", id: "1", locale: I18n.locale.to_s)
    end

    it "routes to #destroy" do
      expect(
        delete: "/equations/1"
      ).to route_to("equations#destroy", id: "1", locale: I18n.locale.to_s)
    end
  end
end
