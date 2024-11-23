require "rails_helper"

RSpec.describe User::ParticipantsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/user/participants").to route_to("user/participants#index")
    end

    it "routes to #new" do
      expect(get: "/user/participants/new").to route_to("user/participants#new")
    end

    it "routes to #show" do
      expect(get: "/user/participants/1").to route_to("user/participants#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/user/participants/1/edit").to route_to("user/participants#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/user/participants").to route_to("user/participants#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/user/participants/1").to route_to("user/participants#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/user/participants/1").to route_to("user/participants#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/user/participants/1").to route_to("user/participants#destroy", id: "1")
    end
  end
end
