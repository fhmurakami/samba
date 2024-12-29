class Report::CreateService
  def initialize(user_admin, collection, grouping)
    @user_admin = user_admin
    @collection = collection
    @grouping = grouping
  end

  def self.call(user_admin:, collection:, grouping:)
    new(user_admin, collection, grouping).call
  end

  def call
    create_report
  end

  def create_report
    @report = Report.find_or_create_by(
      user_admin: @user_admin,
      collection: @collection,
      grouping: @grouping
    )
  end
end
