require 'rails_helper'

RSpec.describe "Rounds", type: :request do
  describe "GET /start" do
    let(:current_admin) { create(:user_admin) }

    before(:each) do
      sign_in current_admin
    end

    it "renders a successful response" do
      participant = create(:user_participant, user_admin: current_admin)
      collection = create(:collection, user_admin: current_admin)
      create(:equation, collections: [ collection ], user_admin: current_admin)

      post start_rounds_path, params: {
        collection_id: collection.id,
        participant_id: participant.id
      }

      expect(response).to be_successful
    end

    it "redirects to finish if no equation is found" do
      participant = create(:user_participant, user_admin: current_admin)
      collection = create(:collection, user_admin: current_admin)
      round = create(:round, collection: collection, participant: participant)

      allow(Round::StartService).to receive(:call).and_return(round)
      allow(Round::NextEquationService).to receive(:call).and_return(nil)

      post start_rounds_path, params: {
        collection_id: collection.id,
        participant_id: participant.id,
        round_id: round.id
      }

      expect(response).to redirect_to(
        action: :finish,
        collection_id: collection.id,
        participant_id: participant.id,
        round_id: round.id
      )
    end

    it "renders the start template if an equation is found" do
      participant = create(:user_participant, user_admin: current_admin)
      collection = create(:collection, user_admin: current_admin)
      round = create(:round, collection: collection, participant: participant)
      equation = create(:equation, collections: [ collection ], user_admin: current_admin)

      allow(Round::StartService).to receive(:call).and_return(round)
      allow(Round::NextEquationService).to receive(:call).and_return(equation)

      post start_rounds_path, params: {
        collection_id: collection.id,
        participant_id: participant.id,
        round_id: round.id
      }

      expect(response).to render_template(:start)
    end
  end

  describe "POST /submit_answer" do
    let(:current_admin) { create(:user_admin) }

    before(:each) do
      sign_in current_admin
    end

    it "calls the submit answer service" do
      participant = create(:user_participant, user_admin: current_admin)
      collection = create(:collection, user_admin: current_admin)
      equation = create(:equation, collections: [ collection ], user_admin: current_admin)
      round = create(
        :round,
        collection: collection,
        current_equation_id: equation.id,
        participant: participant
      )

      allow(Round).to receive(:find_by).and_return(round)

      expect(Round::SubmitAnswerService).to receive(:call).with(round, '42')

      post submit_answer_round_url(
        locale: I18n.locale,
        round_id: round.id,
        collection_id: collection.id,
        participant_id: participant.id,
        params: { answer_value: '42' }
      )
    end

    it "redirects to finish if no next equation is found" do
      participant = create(:user_participant, user_admin: current_admin)
      collection = create(:collection, user_admin: current_admin)
      round = create(
        :round,
        collection: collection,
        participant: participant
      )

      allow(Round).to receive(:find_by).and_return(round)
      allow(Round::NextEquationService).to receive(:call).and_return(nil)
      allow(Round::SubmitAnswerService).to receive(:call).with(round, '42')


      post submit_answer_round_url(
        locale: I18n.locale,
        round_id: round.id,
        collection_id: collection.id,
        participant_id: participant.id,
        params: { answer_value: '42' }
      )

      expect(response).to redirect_to(
        action: :finish,
        collection_id: collection.id,
        participant_id: participant.id,
        round_id: round.id
      )
    end

    it "renders the start template if a next equation is found" do
      answer_value = '42'
      participant = create(:user_participant, user_admin: current_admin)
      collection = create(:collection, user_admin: current_admin)
      round = create(:round, collection: collection, participant: participant)
      equation = create(:equation, collections: [ collection ], user_admin: current_admin)

      allow(Round).to receive(:find_by).and_return(round)
      allow(Round::NextEquationService).to receive(:call).and_return(equation)
      allow(Round::SubmitAnswerService).to receive(:call).with(round, answer_value)

      post submit_answer_round_url(
        locale: I18n.locale,
        round_id: round.id,
        collection_id: collection.id,
        participant_id: participant.id,
        params: { answer_value: answer_value }
      )

      expect(response).to render_template(:start)
    end
  end

  describe "GET /finish" do
    let(:current_admin) { create(:user_admin) }

    before(:each) do
      sign_in current_admin
    end
    it "renders the finish template" do
      participant = create(:user_participant, user_admin: current_admin)
      collection = create(:collection, user_admin: current_admin)
      round = create(:round, collection: collection, participant: participant)

      allow(Round::FinishService).to receive(:call).and_return(true)

      get finish_round_url(
        locale: I18n.locale,
        round_id: round.id,
        collection_id: collection.id,
        participant_id: participant.id
      )

      expect(response).to render_template(:finish)
    end
  end
end
