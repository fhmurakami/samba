require "rails_helper"

RSpec.describe Round::StartService, type: :service do
  let(:collection) { create(:collection) }
  let(:participant) { create(:user_participant) }
  let(:start_service) do
    described_class.new(collection, participant)
  end

  describe "#call" do
    it "calls the start round method" do
      expect(start_service).to receive(:start_round)
      start_service.call
    end

    context "when the round is started for the first time" do
      it "creates and returns the round" do
        round = start_service.call

        expect(round).to be_a Round
        expect(Round.count).to eq 1
        expect(round).to be_persisted
        expect(round.started_at).to be_present
        expect(round.collection).to eq collection
        expect(round.participant).to eq participant
      end
    end

    context "when the round already exists" do
      it "returns the existing round" do
        first_round = start_service.call

        round = start_service.call

        expect(round).to eq first_round
        expect(Round.count).to eq 1
      end
    end
  end
end
