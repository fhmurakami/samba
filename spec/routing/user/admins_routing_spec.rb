require "rails_helper"

RSpec.describe User::AdminsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/user/admins").to route_to("user/admins#index")
    end

    it "routes to #new" do
      expect(get: "/user/admins/new").to route_to("user/admins#new")
    end

    it "routes to #show" do
      expect(get: "/user/admins/1").to route_to("user/admins#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/user/admins/1/edit").to route_to("user/admins#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/user/admins").to route_to("user/admins#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/user/admins/1").to route_to("user/admins#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/user/admins/1").to route_to("user/admins#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/user/admins/1").to route_to("user/admins#destroy", id: "1")
    end
  end
end
