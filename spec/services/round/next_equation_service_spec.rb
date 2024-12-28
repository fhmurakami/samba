require "rails_helper"

RSpec.describe Round::NextEquationService, type: :service do
  let(:participant) { create(:user_participant) }
  let(:collection) { create(:collection) }
  let(:current_round) { create(:round, collection: collection, participant: participant) }
  let(:service) { described_class.new(current_round) }

  describe ".call" do
    it "initializes the service and calls #call" do
      expect_any_instance_of(described_class).to receive(:call)
      described_class.call(current_round)
    end
  end

  describe "#call" do
    context "when there are unanswered equations" do
      let!(:equation) { create(:equation, collections: [ collection ]) }

      before do
        allow(service).to receive(:unanswered_equations).and_return([ equation ])
      end

      it "returns the next equation" do
        current_equation = service.call
        expect(current_equation).to be_an Equation
        expect(current_equation).to eq(equation)
      end

      it "sets the start time for the current equation" do
        service.call
        expect(current_round.equation_started_at).to be_within(1.second).of(Time.current)
      end

      it "updates the current equation id for the round" do
        service.call
        expect(current_round.current_equation_id).to eq(equation.id)
      end
    end

    context "when there are no unanswered equations" do
      before do
        allow(service).to receive(:unanswered_equations).and_return([])
      end

      it "returns nil" do
        expect(service.call).to be_nil
      end
    end
  end
end
