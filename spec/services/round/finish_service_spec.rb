require "rails_helper"

RSpec.describe Round::FinishService, type: :service do
  let(:current_round) { create(:round, :unfinished) }
  let(:current_admin) { create(:user_admin) }
  let(:collection) { create(:collection, user_admin: current_admin) }
  let(:participant) { create(:user_participant, user_admin: current_admin) }
  let(:completed_at) { Time.current }
  let(:finish_service) do
    described_class.new(current_round, collection, participant, current_admin)
  end

  describe "#call" do
    context "when collection is completed" do
      before do
        allow(finish_service).to receive(:collection_completed?).and_return(true)
      end

      it "finalizes the round" do
        expect(finish_service).to receive(:finalize_round)
        finish_service.call
      end

      it "updates completed_at field for current_round" do
        allow(Time).to receive(:current)
          .and_return(completed_at)

        finish_service.call

        expect(current_round.completed_at).to be_within(0.1.seconds).of(completed_at)
      end

      it "calculates the time spent to finish the round" do
        end_time = current_round.started_at + 5.minutes
        allow(Time).to receive(:current).and_return(end_time)

        finish_service.call

        expect(current_round.round_time).to eq 5.minutes.in_milliseconds
      end
    end

    context "when collection is not completed" do
      before do
        allow(finish_service).to receive(:collection_completed?).and_return(false)
      end

      it "does not finalize the round" do
        expect(finish_service).not_to receive(:finalize_round)
        finish_service.call
      end
    end
  end
end
