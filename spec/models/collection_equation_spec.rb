require 'rails_helper'

RSpec.describe CollectionEquation, type: :model do
  describe 'database columns' do
    it { should have_db_column(:collection_id).of_type(:integer) }
    it { should have_db_column(:equation_id).of_type(:integer) }
    it { should have_db_column(:created_at).of_type(:datetime) }
    it { should have_db_column(:updated_at).of_type(:datetime) }
  end

  describe 'model associations' do
    let(:collection) { build_stubbed :collection }
    let(:equation) { build_stubbed :equation }
    let(:subject) {
      build_stubbed :collection_equation,
      collection: collection,
      equation: equation
    }

    it { should belong_to(:collection).without_validating_presence }
    it { should belong_to(:equation) }
  end

  describe "when creating a new CollectionEquation" do
    context 'and the CollectionEquation is valid' do
      let(:collection_equation) { build_stubbed :collection_equation }
      it 'should return true' do
        expect(collection_equation).to be_valid
      end
    end

    context 'and the CollectionEquation is invalid' do
      let(:collection_equation) { build :collection_equation, :invalid }
      it 'should not save' do
        expect(collection_equation).not_to be_valid
      end
    end

    context 'and the CollectionEquation is invalid (equations limit reached)' do
      let(:user_admin) { create :user_admin }
      let(:collection) {
        create :collection,
        equations_quantity: 1,
        user_admin: user_admin
      }
      let(:equation1) { create :equation, user_admin: user_admin }
      let(:equation2) { create :equation, user_admin: user_admin }

      it 'should not save' do
        create(
          :collection_equation,
          collection: collection,
          equation: equation1
        )

        collection.reload

        subject = build(
          :collection_equation,
          collection: collection,
          equation: equation2
        )

        subject.valid?
        expect(equation2.errors).not_to be_empty
        expect(equation2.errors.size).to eq 1
        expect(equation2.errors.first.full_message).to include(
          "#{ I18n.t('activerecord.models.collection') } #{ collection.name.downcase }"\
          " #{ I18n.t(
            "collections.errors.equations_limit",
            count: collection.equations_quantity
          )}"
        )
      end
    end
  end

  # describe '#collection_equation_limit' do
  #   let(:collection) { build_stubbed :collection, equations_quantity: 1 }
  #   let(:equation1) { build_stubbed :equation }
  #   let(:equation2) { build_stubbed :equation }
  #   let(:subject) {
  #     build_stubbed :collection_equation,
  #     collection: collection,
  #     equation: equation1
  #   }

  #   context 'when adding a collection_equation is successful' do
  #     it 'should return true' do
  #       expect(subject.collection_equation_limit).to be_valid
  #     end
  #   end

  #   context 'when adding a collection_equation fails (equations limit reached)' do
  #     let(:subject) {
  #       build_stubbed :collection_equation,
  #       collection: collection,
  #       equation: equation2
  #     }

  #     it 'should not return true' do
  #       binding.pry
  #       expect(subject).not_to be_valid
  #     end
  #   end
  # end
end
