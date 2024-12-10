class CollectionEquation < ApplicationRecord
  belongs_to :collection
  belongs_to :equation

  has_many :answers

  validate :collection_equation_limit

  private

  def collection_equation_limit
    if collection.equations.size >= collection.equations_quantity
      errors.add(
        I18n.t("activerecord.models.collection"),
        I18n.t(
          "collections.errors.equations_limit",
          equations_limit: collection.equations_quantity,
        )
      )
    end
  end
end
