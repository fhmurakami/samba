require 'rails_helper'

RSpec.describe Round::SubmitAnswerService, type: :service do
  let(:current_equation) { create(:equation) }
  let(:current_round) { create(:round, current_equation_id: current_equation.id) }
  let(:answer_value) { 42 }
  let(:service) { described_class.new(current_round, answer_value) }

  describe '#initialize' do
    it 'initializes with current_round and answer_value' do
      expect(service.instance_variable_get(:@current_round)).to eq(current_round)
      expect(service.instance_variable_get(:@answer_value)).to eq(answer_value)
    end
  end

  describe ".call" do
    context "when calling the class method" do
      it "calls the instance method" do
        service = double
        allow(described_class).to receive(:new).and_return(service)
        allow(service).to receive(:call)

        described_class.call(current_round, answer_value)

        expect(described_class).to have_received(:new).with(current_round, answer_value)
        expect(service).to have_received(:call)
      end
    end
  end

  describe '#call' do
    context 'when the answer is submitted' do
      it 'calls the submit_answer method' do
        allow(service).to receive(:submit_answer)
        service.call
        expect(service).to have_received(:submit_answer)
      end
    end

    context 'when there is no current equation' do
      it 'raises an error' do
        current_round.current_equation_id = nil

        expect { service.call }.to raise_error(StandardError, I18n.t("errors.messages.no_current_equation"))
      end
    end

    context 'when there is a current equation' do
      it 'creates an answer' do
        correct_answer = true
        collection = create(:collection, equations: [ current_equation ])

        current_round.collection = collection
        allow(service).to receive(:correct_answer?).and_return(correct_answer)
        allow(service).to receive(:calculate_time_spent).and_return(10)

        expect {
          service.call
        }.to change(Answer, :count).by(1)
      end

      context 'when the answer is correct' do
        it 'creates an answer with correct_answer true' do
          correct_answer = true
          collection = create(:collection, equations: [ current_equation ])

          current_round.collection = collection
          allow(service).to receive(:correct_answer?).and_return(correct_answer)
          allow(service).to receive(:calculate_time_spent).and_return(10)

          answer = service.call

          expect(answer.correct_answer).to be true
        end
      end

      context 'when the answer is incorrect' do
        it 'creates an answer with correct_answer false' do
          correct_answer = false
          collection = create(:collection, equations: [ current_equation ])

          current_round.collection = collection
          allow(service).to receive(:correct_answer?).and_return(correct_answer)
          allow(service).to receive(:calculate_time_spent).and_return(10)

          answer = service.call

          expect(answer.correct_answer).to be false
        end
      end

      it 'calculates the time spent to solve the equation' do
        collection = create(:collection, equations: [ current_equation ])
        current_round.collection = collection
        current_round.equation_started_at = 1.minute.ago

        answer = service.call

        expect(answer.time_spent).to be_within(100).of(60000)
      end
    end
  end
end
