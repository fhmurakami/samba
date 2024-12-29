require "rails_helper"

RSpec.describe Report::CreateService, type: :service do
  describe ".call" do
    let(:user_admin) { create(:user_admin) }
    let(:collection) { create(:collection) }
    let(:grouping) { create(:grouping) }

    it "calls the instance method #call" do
      service_instance = instance_double(Report::CreateService)
      allow(Report::CreateService).to receive(:new).and_return(service_instance)
      allow(service_instance).to receive(:call)

      Report::CreateService.call(user_admin: user_admin, collection: collection, grouping: grouping)

      expect(Report::CreateService).to have_received(:new).with(user_admin, collection, grouping)
      expect(service_instance).to have_received(:call)
    end
  end

  describe "#initialize" do
    subject(:service) { described_class.new(user_admin, collection, grouping) }
    let(:user_admin) { create(:user_admin) }
    let(:collection) { create(:collection) }
    let(:grouping) { create(:grouping) }

    it "initializes with user_admin, collection and grouping" do
      expect(service.instance_variable_get(:@user_admin)).to eq(user_admin)
      expect(service.instance_variable_get(:@collection)).to eq(collection)
      expect(service.instance_variable_get(:@grouping)).to eq(grouping)
    end
  end

  describe "#call" do
    subject(:service) { described_class.new(user_admin, collection, grouping) }
    let(:user_admin) { create(:user_admin) }
    let(:collection) { create(:collection) }
    let(:grouping) { create(:grouping) }

    context "when report doesn't exist" do
      it "creates a report" do
        expect { service.call }.to change(Report, :count).by(1)
      end
    end

    context "when report already exists" do
      let!(:report) { create(:report, user_admin: user_admin, collection: collection, grouping: grouping) }

      it "doesn't create a report" do
        expect { service.call }.not_to change(Report, :count)
      end
    end
  end
end
